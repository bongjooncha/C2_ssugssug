from typing import Any, List
from datetime import date
from fastapi import APIRouter, Depends, HTTPException, status, Query
from sqlalchemy.orm import Session

from app import schemas, models, utils
from app.database import get_db

router = APIRouter(prefix="/notes", tags=["study_notes"])


@router.post("", response_model=schemas.study_note.StudyNote)
def create_study_note(
    note_in: schemas.study_note.StudyNoteCreate,
    current_user: models.user.User = Depends(utils.get_current_user),
    db: Session = Depends(get_db)
) -> Any:
    """스터디 메모 생성 API"""
    # 그룹 존재 확인
    group = db.query(models.study_group.StudyGroup).filter(
        models.study_group.StudyGroup.group_name == note_in.group_name,
        models.study_group.StudyGroup.nickname == current_user.nickname
    ).first()
    
    if not group:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="해당 스터디 그룹을 찾을 수 없습니다."
        )
    
    # 메모 중복 확인
    existing_note = db.query(models.study_note.StudyNote).filter(
        models.study_note.StudyNote.group_name == note_in.group_name,
        models.study_note.StudyNote.date == note_in.date,
        models.study_note.StudyNote.nickname == current_user.nickname
    ).first()
    
    if existing_note:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="해당 날짜에 이미 메모가 존재합니다."
        )
    
    # 메모 생성
    db_note = models.study_note.StudyNote(
        **note_in.dict(),
        nickname=current_user.nickname
    )
    
    db.add(db_note)
    db.commit()
    db.refresh(db_note)
    
    return db_note


@router.get("", response_model=List[schemas.study_note.StudyNote])
def read_study_notes(
    group_name: str = Query(None),
    current_user: models.user.User = Depends(utils.get_current_user),
    db: Session = Depends(get_db)
) -> Any:
    """스터디 메모 목록 조회 API"""
    query = db.query(models.study_note.StudyNote).filter(
        models.study_note.StudyNote.nickname == current_user.nickname
    )
    
    # 그룹명으로 필터링
    if group_name:
        query = query.filter(models.study_note.StudyNote.group_name == group_name)
    
    notes = query.all()
    return notes


@router.get("/{group_name}/{date}/{nickname}", response_model=schemas.study_note.StudyNote)
def read_study_note(
    group_name: str,
    date: date,
    nickname: str,
    current_user: models.user.User = Depends(utils.get_current_user),
    db: Session = Depends(get_db)
) -> Any:
    """특정 스터디 메모 조회 API"""
    # 본인 확인
    if current_user.nickname != nickname:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="자신의 메모만 조회할 수 있습니다."
        )
    
    # 메모 조회
    note = db.query(models.study_note.StudyNote).filter(
        models.study_note.StudyNote.group_name == group_name,
        models.study_note.StudyNote.date == date,
        models.study_note.StudyNote.nickname == nickname
    ).first()
    
    if not note:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="메모를 찾을 수 없습니다."
        )
    
    return note


@router.put("/{group_name}/{date}/{nickname}", response_model=schemas.study_note.StudyNote)
def update_study_note(
    group_name: str,
    date: date,
    nickname: str,
    note_in: schemas.study_note.StudyNoteUpdate,
    current_user: models.user.User = Depends(utils.get_current_user),
    db: Session = Depends(get_db)
) -> Any:
    """스터디 메모 업데이트 API"""
    # 본인 확인
    if current_user.nickname != nickname:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="자신의 메모만 수정할 수 있습니다."
        )
    
    # 메모 조회
    note = db.query(models.study_note.StudyNote).filter(
        models.study_note.StudyNote.group_name == group_name,
        models.study_note.StudyNote.date == date,
        models.study_note.StudyNote.nickname == nickname
    ).first()
    
    if not note:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="메모를 찾을 수 없습니다."
        )
    
    # 업데이트할 항목 필터링
    update_data = note_in.dict(exclude_unset=True)
    for key, value in update_data.items():
        setattr(note, key, value)
    
    db.add(note)
    db.commit()
    db.refresh(note)
    
    return note
