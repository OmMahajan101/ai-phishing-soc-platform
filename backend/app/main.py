from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from backend.core.config import settings

app = FastAPI(
    title="AI Phishing Detection & SOC Platform API",
    description="Enterprise-grade real-time phishing analysis, threat intelligence, and File Integrity Monitoring ^(FIM^).",
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
    uvicorn.run("backend.app.main:app", host=settings.HOST, port=settings.PORT, reload=settings.DEBUG)
