from sqlalchemy import Column, String, Date, ForeignKey
from sqlalchemy.orm import relationship

from app.database import Base


class StudyNote(Base):
    __tablename__ = "study_notes"
    
    group_name = Column(String, ForeignKey("study_groups.group_name"), primary_key=True)
    date = Column(Date, primary_key=True)
    nickname = Column(String, ForeignKey("users.nickname"), primary_key=True)
    goal = Column(String, nullable=False)
    result = Column(String, nullable=True)
    
    # 관계 정의
    user = relationship("User", back_populates="study_notes")
    study_group = relationship("StudyGroup", back_populates="study_notes")
