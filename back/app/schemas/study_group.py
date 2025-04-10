from datetime import date
from typing import Optional
from pydantic import BaseModel


# 스터디 그룹 기본 스키마
class StudyGroupBase(BaseModel):
    group_name: str
    group_type: str
    cycle: int
    start_date: date
    end_date: date
    goal_growth: int


# 스터디 그룹 생성 스키마
class StudyGroupCreate(StudyGroupBase):
    pass


# 스터디 그룹 업데이트 스키마
class StudyGroupUpdate(BaseModel):
    group_type: Optional[str] = None
    cycle: Optional[int] = None
    start_date: Optional[date] = None
    end_date: Optional[date] = None
    goal_growth: Optional[int] = None
    growth: Optional[int] = None


# 스터디 그룹 응답 스키마
class StudyGroup(StudyGroupBase):
    nickname: str
    growth: int = 0
    
    class Config:
        orm_mode = True
