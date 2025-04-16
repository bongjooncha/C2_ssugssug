from fastapi import FastAPI
from .database import engine, Base
from .routers import auth, groups
import uvicorn

# 데이터베이스 테이블 생성
Base.metadata.create_all(bind=engine)

app = FastAPI(title="쑥쑥 API", description="스터디 앱 API")

# 라우터 등록
app.include_router(auth.router)
app.include_router(groups.router)

@app.get("/")
def read_root():
    return {"message": "쑥쑥 API에 오신 것을 환영합니다"}

if __name__ == "__main__":
    uvicorn.run("app.main:app", host="0.0.0.0", port=8000, reload=True) 