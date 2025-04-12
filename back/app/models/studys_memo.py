from sqlalchemy import Column, String
from ..database import Base

class StudysMemo(Base):
    __tablename__ = "studys_memo"
    
    nickname = Column(String, primary_key=True, index=True)
    study_name = Column(String, primary_key=True, index=True)
    study_date = Column(String, primary_key=True, index=True)
    study_goal = Column(String, nullable=False)
    study_imp = Column(String, nullable=False) 