from pydantic import BaseModel, Field


# 사용자 기본 스키마
class UserBase(BaseModel):
    nickname: str


# 사용자 생성 스키마
class UserCreate(UserBase):
    password: str = Field(..., min_length=6)


# 비밀번호 변경 스키마
class UserPasswordUpdate(BaseModel):
    current_password: str
    new_password: str = Field(..., min_length=6)


# 토큰 스키마
class Token(BaseModel):
    access_token: str
    token_type: str


# 토큰 페이로드 스키마
class TokenPayload(BaseModel):
    sub: str = None
    exp: int = None


# 사용자 응답 스키마
class User(UserBase):
    class Config:
        orm_mode = True
