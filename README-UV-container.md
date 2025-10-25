# LangChain UV 開發容器

這是一個使用 **UV**（現代化 Python 包管理器）的 LangChain 開發容器環境，提供更快的依賴管理和更好的開發體驗。

## 🚀 快速開始

### 方法 1：使用 Docker Compose（推薦）

```bash
# 構建並啟動容器
docker-compose up --build

# 在背景運行
docker-compose up -d --build
```

### 方法 2：使用 Docker

```bash
# 構建映像
docker build -t langchain-uv-dev .

# 運行容器
docker run -it -p 8888:8888 -p 11434:11434 -v $(pwd):/app langchain-uv-dev
```

### 方法 3：使用 VS Code Dev Containers

1. 安裝 VS Code Dev Containers 擴展
2. 打開專案資料夾
3. 按 `Ctrl+Shift+P`，選擇 "Dev Containers: Reopen in Container"

## ⚡ UV 的優勢

- **🚀 極快的依賴解析**：比 pip 快 10-100 倍
- **🔒 可重現的構建**：使用 `uv.lock` 確保一致性
- **📦 更好的依賴管理**：自動處理版本衝突
- **🛠️ 內建開發工具**：整合 Black、Flake8、Pytest 等

## 📋 包含的服務

- **Python 3.12** - 主要開發環境
- **UV** - 現代化 Python 包管理器
- **Jupyter Lab** - 互動式開發環境 (端口 8888)
- **Ollama** - 本地 LLM 服務 (端口 11434)
- **LangChain** - AI 應用開發框架
- **FastAPI** - Web API 框架
- **Gradio** - 快速 UI 建構工具

## 🔧 預安裝的模型

容器啟動時會自動下載以下模型：

- `gemma:2b` - Google 的輕量級模型
- `llama3.2:1b` - Meta 的高效模型
- `qwen2.5:1.5b` - 阿里巴巴的多語言模型

## 📁 專案結構

```
.
├── Dockerfile              # Docker 映像定義
├── docker-compose.yml      # 容器編排配置
├── .devcontainer/          # VS Code 開發容器配置
│   └── devcontainer.json
├── pyproject.toml         # UV 專案配置
├── uv.lock               # UV 鎖定檔案
├── start-container.sh     # UV 容器啟動腳本
├── .dockerignore         # Docker 忽略檔案
└── README-container.md   # 說明文件
```

## 🌐 訪問服務

- **Jupyter Lab**: http://localhost:8888
- **Ollama API**: http://localhost:11434

## 💡 使用範例

### 在 Jupyter 中使用 Ollama

```python
from ollama import chat
from ollama import ChatResponse

response: ChatResponse = chat(model='gemma:2b', messages=[
    {
        'role': 'user',
        'content': 'Hello, how are you?',
    },
])

print(response['message']['content'])
```

### 使用 LangChain 與 Ollama

```python
from langchain_ollama import OllamaLLM

llm = OllamaLLM(model="gemma:2b")
response = llm.invoke("What is LangChain?")
print(response)
```

### 使用 UV 管理依賴

```bash
# 添加新依賴
uv add requests

# 添加開發依賴
uv add --dev pytest

# 同步依賴
uv sync

# 運行腳本
uv run python main.py

# 運行 Jupyter
uv run jupyter lab
```

## 🛠️ 開發工具

容器內預裝了以下開發工具：

- **Black** - Python 程式碼格式化
- **Flake8** - 程式碼檢查
- **Pytest** - 測試框架
- **MyPy** - 類型檢查
- **Pre-commit** - Git hooks
- **Git** - 版本控制

## 📝 常用命令

### Docker 命令

```bash
# 查看運行中的容器
docker-compose ps

# 查看容器日誌
docker-compose logs -f

# 停止容器
docker-compose down

# 重新構建容器
docker-compose up --build

# 進入容器
docker-compose exec langchain-dev bash
```

### UV 命令

```bash
# 同步依賴
uv sync

# 添加依賴
uv add package-name

# 添加開發依賴
uv add --dev package-name

# 移除依賴
uv remove package-name

# 運行腳本
uv run python script.py

# 運行測試
uv run pytest

# 格式化程式碼
uv run black .

# 檢查程式碼
uv run flake8 .
```

### Ollama 命令

```bash
# 查看模型列表
ollama list

# 下載模型
ollama pull gemma:2b

# 運行模型
ollama run gemma:2b

# 刪除模型
ollama rm gemma:2b
```

## 🔍 故障排除

### UV 相關問題

```bash
# 清除 UV 快取
uv cache clean

# 重新同步依賴
uv sync --reinstall

# 檢查依賴
uv tree
```

### Ollama 服務無法啟動

```bash
# 檢查 Ollama 狀態
ollama list

# 重啟 Ollama 服務
pkill ollama
ollama serve &
```

### Jupyter Lab 無法訪問

- 確認端口 8888 未被占用
- 檢查防火牆設定
- 嘗試使用 `http://127.0.0.1:8888`

### 模型下載失敗

```bash
# 手動下載模型
ollama pull gemma:2b

# 檢查磁碟空間
df -h
```

## 🆚 UV vs Pip 比較

| 功能 | UV | Pip |
|------|----|----|
| 依賴解析速度 | ⚡ 極快 | 🐌 慢 |
| 鎖定檔案 | ✅ uv.lock | ❌ 無 |
| 依賴衝突處理 | ✅ 自動 | ❌ 手動 |
| 開發工具整合 | ✅ 內建 | ❌ 需額外安裝 |
| 虛擬環境管理 | ✅ 自動 | ❌ 手動 |

## 📚 更多資源

- [UV 官方文檔](https://docs.astral.sh/uv/)
- [LangChain 官方文檔](https://python.langchain.com/)
- [Ollama 官方文檔](https://ollama.com/docs)
- [Docker 官方文檔](https://docs.docker.com/)
- [VS Code Dev Containers](https://code.visualstudio.com/docs/remote/containers)
