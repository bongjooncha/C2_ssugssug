from sqlalchemy import Column, String, Integer
from ..database import Base

class StudysInfo(Base):
    __tablename__ = "studys_info"
    
    nickname = Column(String, primary_key=True, index=True)
    study_name = Column(String, primary_key=True, index=True)
    study_type = Column(Integer, nullable=False)
    meating_num = Column(Integer, default=0)
    meating_goal = Column(Integer, nullable=False) 