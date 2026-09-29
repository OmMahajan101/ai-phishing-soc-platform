#!/usr/bin/env bash
# ==============================================================================
# Enterprise AI Phishing Detection & SOC Platform - Project Initializer (POSIX)
# Stack: FastAPI + React + Chrome Extension (Manifest V3) + Local FIM Sandbox
# GitHub: https://github.com/OmMahajan101/ai-phishing-soc-platform.git
# ==============================================================================

set -euo pipefail

echo "======================================================================"
echo "🛡️  Initializing AI Phishing Detection & SOC Platform Architecture"
echo "======================================================================"

# 1. Create Directory Architecture
echo "[1/5] Creating directory trees..."

# Backend directories
mkdir -p backend/app/api/v1/endpoints
mkdir -p backend/core
mkdir -p backend/models
mkdir -p backend/services
mkdir -p backend/utils

# Data directories
mkdir -p data/raw
mkdir -p data/processed

# Brand templates & FIM Sandbox
mkdir -p brand_templates
mkdir -p fim_sandbox

# Chrome Extension (Manifest V3)
mkdir -p extension/src/background
mkdir -p extension/src/content
mkdir -p extension/src/popup
mkdir -p extension/public/icons

# Frontend (React)
mkdir -p frontend/public
mkdir -p frontend/src/components
mkdir -p frontend/src/pages
mkdir -p frontend/src/services
mkdir -p frontend/src/assets

# 2. Touch Python Module Inits and Gitkeeps
echo "[2/5] Creating module inits and .gitkeep markers..."
touch backend/app/__init__.py
touch backend/app/api/__init__.py
touch backend/app/api/v1/__init__.py
touch backend/app/api/v1/endpoints/__init__.py
touch backend/core/__init__.py
touch backend/models/__init__.py
touch backend/services/__init__.py
touch backend/utils/__init__.py

touch data/raw/.gitkeep
touch data/processed/.gitkeep
touch brand_templates/.gitkeep
touch fim_sandbox/.gitkeep
touch extension/public/icons/.gitkeep
touch frontend/src/assets/.gitkeep

# 3. Create Backend Boilerplate
echo "[3/5] Creating backend and extension baseline files..."

# backend/requirements.txt
cat << 'EOF' > backend/requirements.txt
fastapi>=0.110.0
uvicorn[standard]>=0.28.0
pydantic>=2.6.0
pydantic-settings>=2.2.0
watchdog>=4.0.0
scikit-learn>=1.4.0
joblib>=1.3.2
numpy>=1.26.0
pandas>=2.2.0
beautifulsoup4>=4.12.0
requests>=2.31.0
python-dotenv>=1.0.1
tldextract>=5.1.2
python-multipart>=0.0.9
EOF

# backend/app/main.py
cat << 'EOF' > backend/app/main.py
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from backend.core.config import settings

app = FastAPI(
    title="AI Phishing Detection & SOC Platform API",
    description="Enterprise-grade real-time phishing analysis, threat intelligence, and File Integrity Monitoring (FIM).",
    version="1.0.0"
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/healthz", tags=["Health"])
async def health_check():
    return {
        "status": "healthy",
        "service": "ai-phishing-soc-platform",
        "version": "1.0.0"
    }

if __name__ == "__main__":
    import uvicorn
    uvicorn.run("backend.app.main.py:app", host=settings.HOST, port=settings.PORT, reload=settings.DEBUG)
EOF

# backend/core/config.py
cat << 'EOF' > backend/core/config.py
from pydantic_settings import BaseSettings

class Settings(BaseSettings):
    PROJECT_NAME: str = "AI Phishing SOC Platform"
    HOST: str = "0.0.0.0"
    PORT: int = 8000
    DEBUG: bool = True
    FIM_DIRECTORY: str = "./fim_sandbox"
    MODEL_PATH: str = "./backend/models/phishing_model.pkl"

    class Config:
        env_file = ".env"
        case_sensitive = True

settings = Settings()
EOF

# 4. Create Chrome Extension Manifest V3 Boilerplate
cat << 'EOF' > extension/public/manifest.json
{
  "manifest_version": 3,
  "name": "AI Phishing Shield & SOC Sensor",
  "version": "1.0.0",
  "description": "Enterprise Chrome extension providing real-time AI phishing detection and telemetry to the SOC Platform.",
  "permissions": [
    "activeTab",
    "storage",
    "declarativeNetRequest",
    "notifications",
    "tabs"
  ],
  "host_permissions": [
    "<all_urls>"
  ],
  "background": {
    "service_worker": "src/background/service_worker.js"
  },
  "content_scripts": [
    {
      "matches": ["<all_urls>"],
      "js": ["src/content/content_script.js"],
      "run_at": "document_idle"
    }
  ],
  "action": {
    "default_popup": "src/popup/popup.html",
    "default_title": "AI Phishing Defense Status"
  }
}
EOF

# 5. Connect Git Repository
echo "[4/5] Setting up Git repository and remote origin..."
if [ ! -d ".git" ]; then
    git init
    git branch -M main
fi

REMOTE_URL="https://github.com/OmMahajan101/ai-phishing-soc-platform.git"
if git remote | grep -q "^origin$"; then
    git remote set-url origin "$REMOTE_URL"
else
    git remote add origin "$REMOTE_URL"
fi

echo "[5/5] Project structure successfully initialized!"
echo "----------------------------------------------------------------------"
echo "Remote configured: $(git remote get-url origin)"
echo "Next step: Review files, then run initial git commit and push."
echo "======================================================================"
