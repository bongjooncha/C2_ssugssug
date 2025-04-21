from pydantic import BaseModel

class StudyInfoBase(BaseModel):
    nickname: str
    study_name: str
    study_type: int
    # study_time: int
    meating_num: int
    meating_goal: int

class StudyInfoResponse(StudyInfoBase):
    class Config:
        orm_mode = True 