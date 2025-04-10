from sqlalchemy import Column, String, Integer, Date, ForeignKey
from sqlalchemy.orm import relationship

from app.database import Base


class StudyGroup(Base):
    __tablename__ = "study_groups"
    
    group_name = Column(String, primary_key=True, index=True)
    group_type = Column(String, nullable=False)
    nickname = Column(String, ForeignKey("users.nickname"))
    cycle = Column(Integer, nullable=False)
    start_date = Column(Date, nullable=False)
    end_date = Column(Date, nullable=False)
    goal_growth = Column(Integer, nullable=False)
    growth = Column(Integer, nullable=False, default=0)
    
    # 관계 정의
    user = relationship("User", back_populates="study_groups")
    study_notes = relationship("StudyNote", back_populates="study_group")
