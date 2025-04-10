from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

from .config import settings

# 데이터베이스 엔진 생성
engine = create_engine(
    settings.DATABASE_URL, connect_args={"check_same_thread": False}
)

# 세션 생성
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

# 모델 베이스 클래스
Base = declarative_base()


# 데이터베이스 세션 의존성
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


# 데이터베이스 초기화 함수
def init_db():
    # import all models here to ensure they are registered with Base
    from app.models import user, study_group, study_note
    
    Base.metadata.create_all(bind=engine)
