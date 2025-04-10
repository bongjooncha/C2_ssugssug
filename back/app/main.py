from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
import uvicorn

from app.config import settings
from app.database import init_db
from app.routers import auth, study_groups, study_notes

# 애플리케이션 생성
app = FastAPI(
    title=settings.APP_NAME,
    openapi_url=f"{settings.API_V1_STR}/openapi.json"
)

# CORS 설정
app.add_middleware(
    CORSMiddleware,
    allow_origins=[str(origin) for origin in settings.BACKEND_CORS_ORIGINS],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# 라우터 등록
app.include_router(auth.router, prefix=settings.API_V1_STR)
app.include_router(study_groups.router, prefix=settings.API_V1_STR)
app.include_router(study_notes.router, prefix=settings.API_V1_STR)


@app.on_event("startup")
def startup_event():
    """애플리케이션 시작 시 실행될 이벤트"""
    init_db()


@app.get("/")
def root():
    """루트 엔드포인트"""
    return {"message": "Welcome to SSugSSug API"}


if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)
