@echo off
REM ==============================================================================
REM Enterprise AI Phishing Detection & SOC Platform - Project Initializer (Windows)
REM Stack: FastAPI + React + Chrome Extension (Manifest V3) + Local FIM Sandbox
REM GitHub: https://github.com/OmMahajan101/ai-phishing-soc-platform.git
REM ==============================================================================

setlocal enabledelayedexpansion

echo ======================================================================
echo 🛡️  Initializing AI Phishing Detection ^& SOC Platform Architecture
echo ======================================================================

REM 1. Create Directory Architecture
echo [1/5] Creating directory trees...

REM Backend folders
if not exist "backend\app\api\v1\endpoints" mkdir "backend\app\api\v1\endpoints"
if not exist "backend\core" mkdir "backend\core"
if not exist "backend\models" mkdir "backend\models"
if not exist "backend\services" mkdir "backend\services"
if not exist "backend\utils" mkdir "backend\utils"

REM Data folders
if not exist "data\raw" mkdir "data\raw"
if not exist "data\processed" mkdir "data\processed"

REM Brand templates & FIM Sandbox
if not exist "brand_templates" mkdir "brand_templates"
if not exist "fim_sandbox" mkdir "fim_sandbox"

REM Chrome Extension (Manifest V3)
if not exist "extension\src\background" mkdir "extension\src\background"
if not exist "extension\src\content" mkdir "extension\src\content"
if not exist "extension\src\popup" mkdir "extension\src\popup"
if not exist "extension\public\icons" mkdir "extension\public\icons"

REM Frontend (React)
if not exist "frontend\public" mkdir "frontend\public"
if not exist "frontend\src\components" mkdir "frontend\src\components"
if not exist "frontend\src\pages" mkdir "frontend\src\pages"
if not exist "frontend\src\services" mkdir "frontend\src\services"
if not exist "frontend\src\assets" mkdir "frontend\src\assets"

REM 2. Create Module Inits and Gitkeeps
echo [2/5] Creating module inits and .gitkeep markers...
type nul > "backend\app\__init__.py"
type nul > "backend\app\api\__init__.py"
type nul > "backend\app\api\v1\__init__.py"
type nul > "backend\app\api\v1\endpoints\__init__.py"
type nul > "backend\core\__init__.py"
type nul > "backend\models\__init__.py"
type nul > "backend\services\__init__.py"
type nul > "backend\utils\__init__.py"

type nul > "data\raw\.gitkeep"
type nul > "data\processed\.gitkeep"
type nul > "brand_templates\.gitkeep"
type nul > "fim_sandbox\.gitkeep"
type nul > "extension\public\icons\.gitkeep"
type nul > "frontend\src\assets\.gitkeep"

REM 3. Create Backend Baseline Files
echo [3/5] Creating baseline requirements and boilerplate...

REM backend/requirements.txt
(
echo fastapi^>=0.110.0
echo uvicorn[standard]^>=0.28.0
echo pydantic^>=2.6.0
echo pydantic-settings^>=2.2.0
echo watchdog^>=4.0.0
echo scikit-learn^>=1.4.0
echo joblib^>=1.3.2
echo numpy^>=1.26.0
echo pandas^>=2.2.0
echo beautifulsoup4^>=4.12.0
echo requests^>=2.31.0
echo python-dotenv^>=1.0.1
echo tldextract^>=5.1.2
echo python-multipart^>=0.0.9
) > "backend\requirements.txt"

REM backend/app/main.py
(
echo from fastapi import FastAPI
echo from fastapi.middleware.cors import CORSMiddleware
echo from backend.core.config import settings
echo.
echo app = FastAPI^(
echo     title="AI Phishing Detection & SOC Platform API",
echo     description="Enterprise-grade real-time phishing analysis, threat intelligence, and File Integrity Monitoring ^(FIM^).",
echo     version="1.0.0"
echo ^)
echo.
echo app.add_middleware^(
echo     CORSMiddleware,
echo     allow_origins=["*"],
echo     allow_credentials=True,
echo     allow_methods=["*"],
echo     allow_headers=["*"],
echo ^)
echo.
echo @app.get^("/healthz", tags=["Health"]^)
echo async def health_check^(^):
echo     return ^{
echo         "status": "healthy",
echo         "service": "ai-phishing-soc-platform",
echo         "version": "1.0.0"
echo     ^}
echo.
echo if __name__ == "__main__":
echo     import uvicorn
echo     uvicorn.run^("backend.app.main:app", host=settings.HOST, port=settings.PORT, reload=settings.DEBUG^)
) > "backend\app\main.py"

REM backend/core/config.py
(
echo from pydantic_settings import BaseSettings
echo.
echo class Settings^(BaseSettings^):
echo     PROJECT_NAME: str = "AI Phishing SOC Platform"
echo     HOST: str = "0.0.0.0"
echo     PORT: int = 8000
echo     DEBUG: bool = True
echo     FIM_DIRECTORY: str = "./fim_sandbox"
echo     MODEL_PATH: str = "./backend/models/phishing_model.pkl"
echo.
echo     class Config:
echo         env_file = ".env"
echo         case_sensitive = True
echo.
echo settings = Settings^(^)
) > "backend\core\config.py"

REM Chrome Extension Manifest V3
(
echo ^{
echo   "manifest_version": 3,
echo   "name": "AI Phishing Shield & SOC Sensor",
echo   "version": "1.0.0",
echo   "description": "Enterprise Chrome extension providing real-time AI phishing detection and telemetry to the SOC Platform.",
echo   "permissions": [
echo     "activeTab",
echo     "storage",
echo     "declarativeNetRequest",
echo     "notifications",
echo     "tabs"
echo   ],
echo   "host_permissions": [
echo     "^<all_urls^>"
echo   ],
echo   "background": ^{
echo     "service_worker": "src/background/service_worker.js"
echo   ^},
echo   "content_scripts": [
echo     ^{
echo       "matches": ["^<all_urls^>"],
echo       "js": ["src/content/content_script.js"],
echo       "run_at": "document_idle"
echo     ^}
echo   ],
echo   "action": ^{
echo     "default_popup": "src/popup/popup.html",
echo     "default_title": "AI Phishing Defense Status"
echo   ^}
echo ^}
) > "extension\public\manifest.json"

REM 4. Connect Git Repository
echo [4/5] Setting up Git repository and remote origin...
if not exist ".git" (
    git init
    git branch -M main
)

set REMOTE_URL=https://github.com/OmMahajan101/ai-phishing-soc-platform.git
git remote | findstr /R "^origin$" >nul 2>&1
if %ERRORLEVEL% equ 0 (
    git remote set-url origin %REMOTE_URL%
) else (
    git remote add origin %REMOTE_URL%
)

echo [5/5] Project structure successfully initialized!
echo ----------------------------------------------------------------------
git remote -v
echo ======================================================================
echo Completed initialization. Review your files and perform initial commit.
