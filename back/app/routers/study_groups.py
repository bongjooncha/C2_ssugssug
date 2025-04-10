from typing import Any, List
from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session

from app import schemas, models, utils
from app.database import get_db

router = APIRouter(prefix="/groups", tags=["study_groups"])


@router.post("", response_model=schemas.study_group.StudyGroup)
def create_study_group(
    group_in: schemas.study_group.StudyGroupCreate,
    current_user: models.user.User = Depends(utils.get_current_user),
    db: Session = Depends(get_db)
) -> Any:
    """스터디 그룹 생성 API"""
    # 그룹 이름 중복 체크
    db_group = db.query(models.study_group.StudyGroup).filter(
        models.study_group.StudyGroup.group_name == group_in.group_name
    ).first()
    
    if db_group:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="이미 존재하는 그룹 이름입니다."
        )
    
    # 새 그룹 생성
    db_group = models.study_group.StudyGroup(
        **group_in.dict(),
        nickname=current_user.nickname,
        growth=0
    )
    
    db.add(db_group)
    db.commit()
    db.refresh(db_group)
    
    return db_group


@router.get("", response_model=List[schemas.study_group.StudyGroup])
def read_study_groups(
    current_user: models.user.User = Depends(utils.get_current_user),
    db: Session = Depends(get_db)
) -> Any:
    """스터디 그룹 목록 조회 API"""
    # 현재 사용자의 스터디 그룹 목록 반환
    groups = db.query(models.study_group.StudyGroup).filter(
        models.study_group.StudyGroup.nickname == current_user.nickname
    ).all()
    
    return groups


@router.get("/{name}", response_model=schemas.study_group.StudyGroup)
def read_study_group(
    name: str,
    current_user: models.user.User = Depends(utils.get_current_user),
    db: Session = Depends(get_db)
) -> Any:
    """특정 스터디 그룹 조회 API"""
    # 해당 그룹 조회
    group = db.query(models.study_group.StudyGroup).filter(
        models.study_group.StudyGroup.group_name == name,
        models.study_group.StudyGroup.nickname == current_user.nickname
    ).first()
    
    if not group:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="그룹을 찾을 수 없습니다."
        )
    
    return group


@router.put("/{name}", response_model=schemas.study_group.StudyGroup)
def update_study_group(
    name: str,
    group_in: schemas.study_group.StudyGroupUpdate,
    current_user: models.user.User = Depends(utils.get_current_user),
    db: Session = Depends(get_db)
) -> Any:
    """스터디 그룹 정보 업데이트 API"""
    # 해당 그룹 조회
    group = db.query(models.study_group.StudyGroup).filter(
        models.study_group.StudyGroup.group_name == name,
        models.study_group.StudyGroup.nickname == current_user.nickname
    ).first()
    
    if not group:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="그룹을 찾을 수 없습니다."
        )
    
    # 업데이트할 항목 필터링
    update_data = group_in.dict(exclude_unset=True)
    for key, value in update_data.items():
        setattr(group, key, value)
    
    db.add(group)
    db.commit()
    db.refresh(group)
    
    return group
