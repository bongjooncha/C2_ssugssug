from pydantic_settings import BaseSettings
import secrets
from pathlib import Path

# 프로젝트 기본 디렉토리
BASE_DIR = Path(__file__).resolve().parent.parent


class Settings(BaseSettings):
    # 앱 설정
    APP_NAME: str = "SSugSSug API"
    API_V1_STR: str = "/api/v1"
    
    # 보안 설정
    SECRET_KEY: str = secrets.token_urlsafe(32)
    ALGORITHM: str = "HS256"
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 60 * 24 * 7  # 7일
    
    # 데이터베이스 설정
    DATABASE_URL: str = f"sqlite:///{BASE_DIR}/ssugssug.db"
    
    # CORS 설정
    BACKEND_CORS_ORIGINS: list = ["*"]
    
    class Config:
        case_sensitive = True


settings = Settings()
