from sqlalchemy import Column, String
from sqlalchemy.orm import relationship

from app.database import Base


class User(Base):
    __tablename__ = "users"
    
    nickname = Column(String, primary_key=True, index=True)
    password = Column(String, nullable=False)
    
    # 관계 정의
    study_groups = relationship("StudyGroup", back_populates="user")
    study_notes = relationship("StudyNote", back_populates="user")
