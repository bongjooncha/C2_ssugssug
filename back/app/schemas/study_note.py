from datetime import date
from typing import Optional
from pydantic import BaseModel


# 스터디 메모 기본 스키마
class StudyNoteBase(BaseModel):
    group_name: str
    date: date
    goal: str
    result: Optional[str] = None


# 스터디 메모 생성 스키마
class StudyNoteCreate(StudyNoteBase):
    pass


# 스터디 메모 업데이트 스키마
class StudyNoteUpdate(BaseModel):
    goal: Optional[str] = None
    result: Optional[str] = None


# 스터디 메모 응답 스키마
class StudyNote(StudyNoteBase):
    nickname: str
    
    class Config:
        orm_mode = True
