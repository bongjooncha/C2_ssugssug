import hashlib
import secrets
from datetime import datetime, timedelta
from typing import Optional, Union, Any

from fastapi import Depends, HTTPException, status
from fastapi.security import OAuth2PasswordBearer
from jose import jwt, JWTError
from passlib.context import CryptContext
from sqlalchemy.orm import Session

from .config import settings
from .database import get_db
from .models import user as user_model
from .schemas.user import TokenPayload

# 비밀번호 해싱 컨텍스트
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

# OAuth2 스키마
oauth2_scheme = OAuth2PasswordBearer(tokenUrl=f"{settings.API_V1_STR}/auth/login")


def generate_salt() -> str:
    """랜덤 솔트 생성"""
    return secrets.token_hex(16)


def hash_password(password: str, salt: str = None) -> str:
    """비밀번호 해싱
    
    앱에서 이미 1차 해싱된 비밀번호를 다시 한번 솔트 처리 후 해싱
    """
    if salt is None:
        salt = generate_salt()
        
    # SHA-256 해싱
    salted_password = password + salt
    hashed = hashlib.sha256(salted_password.encode()).hexdigest()
    
    # 최종적으로 bcrypt로 한번 더 해싱
    return f"{pwd_context.hash(hashed)}:{salt}"


def verify_password(plain_password: str, hashed_password: str) -> bool:
    """비밀번호 검증"""
    if ":" not in hashed_password:
        return False
        
    hashed, salt = hashed_password.split(":", 1)
    
    # 입력된 비밀번호를 동일한 방식으로 해싱
    salted_plain = plain_password + salt
    plain_hashed = hashlib.sha256(salted_plain.encode()).hexdigest()
    
    # bcrypt로 해싱된 비밀번호 검증
    return pwd_context.verify(plain_hashed, hashed)


def create_access_token(subject: Union[str, Any], expires_delta: Optional[timedelta] = None) -> str:
    """JWT 토큰 생성"""
    if expires_delta:
        expire = datetime.utcnow() + expires_delta
    else:
        expire = datetime.utcnow() + timedelta(minutes=settings.ACCESS_TOKEN_EXPIRE_MINUTES)
    
    to_encode = {"exp": expire, "sub": str(subject)}
    encoded_jwt = jwt.encode(to_encode, settings.SECRET_KEY, algorithm=settings.ALGORITHM)
    return encoded_jwt


def get_current_user(
    db: Session = Depends(get_db), token: str = Depends(oauth2_scheme)
) -> user_model.User:
    """현재 사용자 확인"""
    try:
        # 토큰 디코딩
        payload = jwt.decode(token, settings.SECRET_KEY, algorithms=[settings.ALGORITHM])
        token_data = TokenPayload(**payload)
        
        # 토큰 만료 확인
        if datetime.fromtimestamp(token_data.exp) < datetime.now():
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="토큰이 만료되었습니다.",
                headers={"WWW-Authenticate": "Bearer"}
            )
    except JWTError:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="유효하지 않은 토큰입니다.",
            headers={"WWW-Authenticate": "Bearer"}
        )
    
    # 사용자 확인
    user = db.query(user_model.User).filter(user_model.User.nickname == token_data.sub).first()
    if user is None:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="사용자를 찾을 수 없습니다."
        )
    
    return user
