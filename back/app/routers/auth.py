from datetime import timedelta
from typing import Any
from fastapi import APIRouter, Depends, HTTPException, status
from fastapi.security import OAuth2PasswordRequestForm
from sqlalchemy.orm import Session

from app import schemas, models, utils
from app.config import settings
from app.database import get_db

router = APIRouter(prefix="/auth", tags=["auth"])


@router.post("/signup", response_model=schemas.user.User)
def signup(user_in: schemas.user.UserCreate, db: Session = Depends(get_db)) -> Any:
    """회원가입 API"""
    # 기존 사용자 확인
    user = db.query(models.user.User).filter(models.user.User.nickname == user_in.nickname).first()
    if user:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="이미 사용 중인 닉네임입니다."
        )
    
    # 비밀번호 해싱
    hashed_password = utils.hash_password(user_in.password)
    
    # 사용자 생성
    db_user = models.user.User(
        nickname=user_in.nickname,
        password=hashed_password
    )
    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    
    return db_user


@router.post("/login", response_model=schemas.user.Token)
def login(
    form_data: OAuth2PasswordRequestForm = Depends(),
    db: Session = Depends(get_db)
) -> Any:
    """로그인 API"""
    # 사용자 확인
    user = db.query(models.user.User).filter(models.user.User.nickname == form_data.username).first()
    if not user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="닉네임 또는 비밀번호가 올바르지 않습니다.",
            headers={"WWW-Authenticate": "Bearer"}
        )
    
    # 비밀번호 검증
    if not utils.verify_password(form_data.password, user.password):
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="닉네임 또는 비밀번호가 올바르지 않습니다.",
            headers={"WWW-Authenticate": "Bearer"}
        )
    
    # 토큰 생성
    access_token_expires = timedelta(minutes=settings.ACCESS_TOKEN_EXPIRE_MINUTES)
    access_token = utils.create_access_token(
        subject=user.nickname, expires_delta=access_token_expires
    )
    
    return {
        "access_token": access_token,
        "token_type": "bearer"
    }


@router.delete("/users/{nickname}", response_model=schemas.user.User)
def delete_user(
    nickname: str,
    current_user: models.user.User = Depends(utils.get_current_user),
    db: Session = Depends(get_db)
) -> Any:
    """회원 탈퇴 API"""
    # 본인 확인
    if current_user.nickname != nickname:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="자신의 계정만 삭제할 수 있습니다."
        )
    
    # 사용자 확인
    user = db.query(models.user.User).filter(models.user.User.nickname == nickname).first()
    if not user:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="사용자를 찾을 수 없습니다."
        )
    
    # 사용자 삭제
    db.delete(user)
    db.commit()
    
    return user


@router.put("/users/{nickname}/password", response_model=schemas.user.User)
def update_password(
    nickname: str,
    password_in: schemas.user.UserPasswordUpdate,
    current_user: models.user.User = Depends(utils.get_current_user),
    db: Session = Depends(get_db)
) -> Any:
    """비밀번호 변경 API"""
    # 본인 확인
    if current_user.nickname != nickname:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="자신의 비밀번호만 변경할 수 있습니다."
        )
    
    # 사용자 확인
    user = db.query(models.user.User).filter(models.user.User.nickname == nickname).first()
    if not user:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="사용자를 찾을 수 없습니다."
        )
    
    # 현재 비밀번호 검증
    if not utils.verify_password(password_in.current_password, user.password):
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="현재 비밀번호가 올바르지 않습니다."
        )
    
    # 새 비밀번호 해싱 및 저장
    user.password = utils.hash_password(password_in.new_password)
    db.add(user)
    db.commit()
    db.refresh(user)
    
    return user
