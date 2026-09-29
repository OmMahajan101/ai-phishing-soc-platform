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
