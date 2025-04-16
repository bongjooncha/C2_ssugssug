from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from typing import List
from ..database import get_db
from ..models.studys_info import StudysInfo
from ..schemas.studys_info import StudyInfoResponse

router = APIRouter(
    prefix="/groups",
    tags=["groups"]
)

@router.get("/studies", response_model=List[StudyInfoResponse])
def get_all_studies(db: Session = Depends(get_db)):
    """모든 스터디 정보 조회"""
    studies = db.query(StudysInfo).all()
    return studies

@router.get("/studies/{study_name}", response_model=List[StudyInfoResponse])
def get_study_by_name(study_name: str, db: Session = Depends(get_db)):
    """특정 스터디 이름으로 정보 조회"""
    studies = db.query(StudysInfo).filter(StudysInfo.study_name == study_name).all()
    if not studies:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="해당 이름의 스터디를 찾을 수 없습니다"
        )
    return studies

@router.get("/studies/user/{nickname}", response_model=List[StudyInfoResponse])
def get_studies_by_user(nickname: str, db: Session = Depends(get_db)):
    """특정 사용자의 스터디 정보 조회"""
    studies = db.query(StudysInfo).filter(StudysInfo.nickname == nickname).all()
    if not studies:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="해당 사용자의 스터디 정보를 찾을 수 없습니다"
        )
    return studies
