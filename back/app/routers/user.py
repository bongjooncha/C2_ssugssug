from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from typing import List

from ..database import get_db
from ..models.user import User
from ..schemas.user import UserResponse

router = APIRouter(
    prefix="/users",
    tags=["users"]
)

@router.get("/", response_model=List[str])
def get_all_user_nicknames(db: Session = Depends(get_db)):
    """
    모든 사용자의 닉네임을 리스트로 반환합니다.
    """
    users = db.query(User.nickname).all()
    nicknames = [user[0] for user in users]
    return nicknames
