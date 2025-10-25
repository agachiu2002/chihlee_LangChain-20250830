# LangChain 開發容器

這是一個專為 LangChain 開發設計的 Docker 容器環境，包含了所有必要的工具和服務。

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
docker build -t langchain-dev .

# 運行容器
docker run -it -p 8888:8888 -p 11434:11434 -v $(pwd):/app langchain-dev
```

### 方法 3：使用 VS Code Dev Containers

1. 安裝 VS Code Dev Containers 擴展
2. 打開專案資料夾
3. 按 `Ctrl+Shift+P`，選擇 "Dev Containers: Reopen in Container"

## 📋 包含的服務

- **Python 3.12** - 主要開發環境
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
├── requirements.txt        # Python 依賴
├── start-container.sh      # 容器啟動腳本
├── .dockerignore          # Docker 忽略檔案
└── README.md              # 說明文件
```

## 🌐 訪問服務

- **Jupyter Lab**: http://localhost:8888
- **Ollama API**: http://localhost:11434

## 💡 使用範例

### 在 Jupyter 中使用 Ollama

```python
from ollama import chat

response = chat(model='gemma:2b', messages=[
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

## 🛠️ 開發工具

容器內預裝了以下開發工具：

- **Black** - Python 程式碼格式化
- **Flake8** - 程式碼檢查
- **Pytest** - 測試框架
- **Git** - 版本控制

## 📝 常用命令

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

# 查看 Ollama 模型
docker-compose exec langchain-dev ollama list

# 下載新模型
docker-compose exec langchain-dev ollama pull <model-name>
```

## 🔍 故障排除

### Ollama 服務無法啟動
```bash
# 檢查 Ollama 狀態
docker-compose exec langchain-dev ollama list

# 重啟 Ollama 服務
docker-compose exec langchain-dev pkill ollama
docker-compose exec langchain-dev ollama serve &
```

### Jupyter Lab 無法訪問
- 確認端口 8888 未被占用
- 檢查防火牆設定
- 嘗試使用 `http://127.0.0.1:8888`

### 模型下載失敗
```bash
# 手動下載模型
docker-compose exec langchain-dev ollama pull gemma:2b
```

## 📚 更多資源

- [LangChain 官方文檔](https://python.langchain.com/)
- [Ollama 官方文檔](https://ollama.com/docs)
- [Docker 官方文檔](https://docs.docker.com/)
- [VS Code Dev Containers](https://code.visualstudio.com/docs/remote/containers)
