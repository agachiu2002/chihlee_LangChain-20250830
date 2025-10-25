# 使用 Python 3.12 官方映像
FROM python:3.12-slim

# 設定工作目錄
WORKDIR /app

# 安裝系統依賴
RUN apt-get update && apt-get install -y \
    git \
    curl \
    wget \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# 安裝 UV
RUN pip install uv

# 安裝 Ollama
RUN curl -fsSL https://ollama.com/install.sh | sh

# 複製專案檔案
COPY pyproject.toml ./
COPY uv.lock* ./

# 使用 UV 安裝依賴
RUN uv sync --frozen

# 使用 UV 安裝 Jupyter 相關套件
RUN uv add jupyter jupyterlab ipywidgets notebook

# 創建 Jupyter 配置
RUN uv run jupyter lab --generate-config && \
    echo "c.ServerApp.ip = '0.0.0.0'" >> ~/.jupyter/jupyter_lab_config.py && \
    echo "c.ServerApp.port = 8888" >> ~/.jupyter/jupyter_lab_config.py && \
    echo "c.ServerApp.open_browser = False" >> ~/.jupyter/jupyter_lab_config.py && \
    echo "c.ServerApp.allow_root = True" >> ~/.jupyter/jupyter_lab_config.py

# 暴露端口
EXPOSE 8888 11434

# 創建啟動腳本
RUN echo '#!/bin/bash\n\
# 啟動 Ollama 服務\n\
ollama serve &\n\
\n\
# 等待 Ollama 啟動\n\
sleep 5\n\
\n\
# 下載 gemma 模型（如果不存在）\n\
ollama pull gemma:2b || true\n\
\n\
# 使用 UV 啟動 Jupyter Lab\n\
uv run jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root\n\
' > /app/start.sh && chmod +x /app/start.sh

# 設定環境變數
ENV PYTHONPATH=/app
ENV JUPYTER_ENABLE_LAB=yes
ENV UV_SYSTEM_PYTHON=1

# 啟動命令
CMD ["/app/start.sh"]
