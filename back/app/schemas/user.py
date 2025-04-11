from pydantic import BaseModel

class UserCreate(BaseModel):
    nickname: str
    password: str

class UserResponse(BaseModel):
    nickname: str
    
    class Config:
        orm_mode = True

class UserLogin(BaseModel):
    nickname: str
    password: str 