from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from ..database import get_db
from ..models.user import User
from ..schemas.user import UserCreate, UserResponse, UserLogin
from ..utils import get_password_hash, verify_password

router = APIRouter(
    prefix="/auth",
    tags=["auth"]
)

"""회원가입"""
@router.post("/signup", response_model=UserResponse)
def signup(user: UserCreate, db: Session = Depends(get_db)):
    # 사용자 존재 여부 확인
    db_user = db.query(User).filter(User.nickname == user.nickname).first()
    if db_user:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="이미 존재하는 닉네임입니다"
        )
    
    # 사용자 생성
    hashed_password = get_password_hash(user.password)
    db_user = User(nickname=user.nickname, password=hashed_password)
    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    
    return db_user

"""로그인"""
@router.post("/login", response_model=UserResponse)
def login(user_data: UserLogin, db: Session = Depends(get_db)):
    print(user_data)
    # 사용자 찾기
    user = db.query(User).filter(User.nickname == user_data.nickname).first()
    if not user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="존재하지 않는 사용자입니다"
        )
    
    # 비밀번호 확인
    if not verify_password(user_data.password, user.password):
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="비밀번호가 일치하지 않습니다"
        )
    
    # 성공 시 사용자 정보 반환
    return user

"""회원 탈퇴"""
@router.delete("/users/{nickname}", response_model=dict)
def delete_user(nickname: str, db: Session = Depends(get_db)):
    # 사용자 존재 여부 확인
    user = db.query(User).filter(User.nickname == nickname).first()
    if not user:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="사용자를 찾을 수 없습니다"
        )
    
    # 사용자 삭제
    db.delete(user)
    db.commit()
    
    return {"message": "사용자가 성공적으로 삭제되었습니다"} 