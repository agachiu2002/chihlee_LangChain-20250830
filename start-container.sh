#!/bin/bash

# LangChain UV 開發容器啟動腳本

echo "🚀 啟動 LangChain UV 開發環境..."

# 檢查 UV 是否已安裝
if ! command -v uv &> /dev/null; then
    echo "❌ UV 未安裝，正在安裝..."
    pip install uv
fi

# 同步依賴
echo "📦 同步 UV 依賴..."
uv sync --dev

# 檢查 Ollama 是否已安裝
if ! command -v ollama &> /dev/null; then
    echo "❌ Ollama 未安裝，正在安裝..."
    curl -fsSL https://ollama.com/install.sh | sh
fi

# 啟動 Ollama 服務
echo "🔄 啟動 Ollama 服務..."
ollama serve &
OLLAMA_PID=$!

# 等待 Ollama 啟動
echo "⏳ 等待 Ollama 服務啟動..."
sleep 10

# 檢查 Ollama 是否運行
if ! curl -s http://localhost:11434/api/tags > /dev/null; then
    echo "❌ Ollama 服務啟動失敗"
    exit 1
fi

echo "✅ Ollama 服務已啟動"

# 下載常用模型
echo "📥 下載常用模型..."

# 下載 gemma 2b 模型
echo "📥 下載 gemma:2b 模型..."
ollama pull gemma:2b || echo "⚠️ gemma:2b 下載失敗，將使用其他模型"

# 下載 llama3.2 模型
echo "📥 下載 llama3.2:1b 模型..."
ollama pull llama3.2:1b || echo "⚠️ llama3.2:1b 下載失敗"

# 下載 qwen2.5 模型
echo "📥 下載 qwen2.5:1.5b 模型..."
ollama pull qwen2.5:1.5b || echo "⚠️ qwen2.5:1.5b 下載失敗"

echo "✅ 模型下載完成"

# 顯示可用模型
echo "📋 可用模型列表："
ollama list

# 使用 UV 啟動 Jupyter Lab
echo "🚀 使用 UV 啟動 Jupyter Lab..."
uv run jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root --NotebookApp.token='' --NotebookApp.password=''

# 清理函數
cleanup() {
    echo "🛑 正在關閉服務..."
    kill $OLLAMA_PID 2>/dev/null
    exit 0
}

# 設定信號處理
trap cleanup SIGINT SIGTERM

# 等待
wait