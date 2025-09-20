# chihlee_LangChain-20250830

# A first-level heading
## A second-level heading
### A third-level heading

## 專案設定

本專案使用 [uv](https://pypi.org/project/uv/) 作為套件管理器。請依照以下步驟設定您的開發環境：

### 1. 建立並啟用虛擬環境

首先，確保您的系統已安裝 `uv`。如果沒有，請參考 [uv 官方文件](https://astral.sh/uv/install/) 進行安裝。

然後，在專案根目錄下建立虛擬環境：

```bash
uv venv
```

接著，啟用虛擬環境：

**Windows PowerShell:**
```bash
.venv\Scripts\activate
```

**Linux/macOS 或 Git Bash:**
```bash
source .venv/bin/activate
```

### 2. 安裝專案相依性

在虛擬環境啟用後，您可以使用 `uv` 安裝 `pyproject.toml` 和 `uv.lock` 中定義的專案相依套件：

```bash
uv sync
```

`uv.lock` 檔案確保所有團隊成員和部署環境都使用相同的套件版本，以保證一致性。