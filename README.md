# 🛡️ Enterprise AI Phishing Detection & SOC Platform

[![FastAPI](https://img.shields.io/badge/Backend-FastAPI-009688?style=flat&logo=fastapi&logoColor=white)](https://fastapi.tiangolo.com)
[![React](https://img.shields.io/badge/Frontend-React-61DAFB?style=flat&logo=react&logoColor=black)](https://react.dev)
[![Manifest V3](https://img.shields.io/badge/Extension-Chrome%20Manifest%20V3-4285F4?style=flat&logo=googlechrome&logoColor=white)](https://developer.chrome.com/docs/extensions/develop)
[![Watchdog](https://img.shields.io/badge/FIM-Local%20Watchdog%20Sandbox-FF6F00?style=flat&logo=security&logoColor=white)](https://github.com/gorakhargosh/watchdog)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

An enterprise-grade, multi-tiered cybersecurity platform combining **Machine Learning Phishing Detection**, a **Security Operations Center (SOC) Console**, a **Chrome Browser Defense Extension (Manifest V3)**, and a **Local File Integrity Monitoring (FIM)** sandbox.

---

## 📌 Architectural Overview

The platform bridges real-time client-side telemetry with deep server-side AI evaluation and host-level filesystem security:

```mermaid
flowchart TD
    subgraph ClientLayer [Client & Host Defense Layer]
        Ext[Chrome Extension - Manifest V3] -->|Active URL / DOM Signals| APIGateway
        FIM[Local FIM Sandbox Watchdog] -->|File Hash & Mutation Events| APIGateway
    end

    subgraph BackendLayer [FastAPI SOC Backend Engine]
        APIGateway[FastAPI Gateway /core] --> MLService[AI Phishing Inference /services/ml_detector]
        APIGateway --> FIMService[FIM State & Tamper Engine /services/fim_watcher]
        APIGateway --> BrandService[Brand Impersonation Matcher /brand_templates]
        MLService --> ModelStore[(Trained Models /models)]
    end

    subgraph AnalystLayer [SOC Operations Console]
        Dashboard[React SOC Frontend] <-->|REST & WebSockets| APIGateway
        Dashboard --> AlertStream[Real-Time Threat Telemetry & Live Triage]
    end
```

---

## 📁 Production Directory Architecture

```text
ai-phishing-soc-platform/
├── .gitignore                     # Production-grade ignore rules (venv, .pkl, credentials, etc.)
├── README.md                      # Comprehensive system documentation & setup guide
├── init_project.sh                # Automated project setup script (Linux/macOS)
├── init_project.bat               # Automated project setup script (Windows)
│
├── backend/                       # FastAPI High-Performance Backend
│   ├── app/
│   │   ├── api/                   # REST API routes (v1 endpoints)
│   │   │   └── v1/
│   │   │       └── endpoints/     # Feature-specific route controllers
│   │   ├── core/                  # Security, configurations, and logging utilities
│   │   ├── models/                # Pydantic validation schemas and data models
│   │   ├── services/              # ML inference, FIM watcher, and brand verification
│   │   ├── utils/                 # Feature extraction, hashing, and token handling
│   │   └── main.py                # FastAPI application entrypoint
│   └── requirements.txt           # Python backend dependencies
│
├── data/                          # Data Storage Pipelines
│   ├── raw/                       # Raw datasets (PhishTank, OpenPhish, legitimate URLs)
│   └── processed/                 # Featurized datasets ready for model training
│
├── brand_templates/               # Normalized HTML/visual templates for impersonation detection
│
├── extension/                     # Chrome Browser Extension (Manifest V3)
│   ├── public/
│   │   ├── manifest.json          # Chrome Extension Manifest V3 configuration
│   │   └── icons/                 # Extension toolbar & alert icons
│   └── src/
│       ├── background/            # Background service worker (intercepts navigation)
│       ├── content/               # DOM scraper & in-page warning banner injector
│       └── popup/                 # Interactive user popup UI
│
├── frontend/                      # React SOC Analyst Dashboard
│   ├── public/                    # Static web assets
│   └── src/
│       ├── assets/                # Design assets and logos
│       ├── components/            # Reusable UI components (ThreatCards, GraphView)
│       ├── pages/                 # SOC views (Dashboard, IncidentDetails, FIMStream)
│       └── services/              # Axios/Fetch API integrations
│
└── fim_sandbox/                   # Monitored directory for File Integrity Monitoring demo
```

---

## 🚀 Quick Setup & Initialization

### Option A: Using the Automated Scripts

#### On Windows:
```cmd
init_project.bat
```

#### On Linux / macOS:
```bash
chmod +x init_project.sh
./init_project.sh
```

---

## 🛠️ Step-by-Step Module Setup

### 1. Backend Service (FastAPI)

```bash
# Navigate to backend and create virtual environment
cd backend
python -m venv venv

# Activate virtual environment
# Windows:
venv\Scripts\activate
# Linux/macOS:
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt

# Launch FastAPI development server
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
```
API Documentation will be available at: `http://localhost:8000/docs`.

### 2. Chrome Extension (Manifest V3)

1. Open Google Chrome and navigate to `chrome://extensions/`.
2. Enable **Developer mode** (toggle in the top-right corner).
3. Click **Load unpacked**.
4. Select the `extension/` directory.

### 3. Frontend SOC Console (React)

```bash
cd frontend
npm install
npm run dev
```

---

## 🔗 Git Initial Commit & Remote Repository Connection

This repository is connected to:
**`https://github.com/OmMahajan101/ai-phishing-soc-platform.git`**

To stage your project, create the initial commit, and push to GitHub:

```bash
# 1. Initialize git (if not already done)
git init

# 2. Set default branch to main
git branch -M main

# 3. Connect remote repository
git remote add origin https://github.com/OmMahajan101/ai-phishing-soc-platform.git

# Verify remote
git remote -v

# 4. Stage all architectural files and configurations
git add .

# 5. Create initial production commit
git commit -m "feat: initialize enterprise AI Phishing Detection & SOC Platform architecture"

# 6. Push to GitHub main branch
git push -u origin main
```

---

## 🔒 Security & Data Hygiene
- **Never commit `.env` files**: All secrets, API keys, and model paths must remain local.
- **Model weights**: Models (`*.pkl`, `*.joblib`) are excluded from Git via `.gitignore`. Version them using DVC or remote cloud storage.
- **FIM Sandbox**: Dynamic files generated in `fim_sandbox/` during testing are automatically ignored by Git.
