# 구조
app/
 ├── __init__.py
 ├── main.py                   # FastAPI 앱 인스턴스
 ├── database.py               # DB 연결, 모델 정의
 ├── config.py                 # 환경 설정
 ├── utils.py                  # 암호화 등 유틸리티 함수
 |
 ├── routers/              
 │     ├── __init__.py
 │     ├── auth.py             # 인증 관련 엔드포인트
 │     ├── study_groups.py     # 스터디 그룹 관련 엔드포인트
 │     └── study_notes.py      # 스터디 메모 관련 엔드포인트
 |
 ├── models/               
 │     ├── __init__.py
 │     ├── user.py             # 사용자 모델
 │     ├── study_group.py      # 스터디 그룹 모델
 │     └── study_note.py       # 스터디 메모 모델
 |
 └── schemas/
       ├── __init__.py
       ├── user.py             # 사용자 스키마
       ├── study_group.py      # 스터디 그룹 스키마
       └── study_note.py       # 스터디 메모 스키마


1. 인증 API:
- POST /auth/signup - 회원가입
- POST /auth/login - 로그인
- DELETE /auth/users/{nickname} - 회원 탈퇴
- PUT /auth/users/{nickname}/password - 비밀번호 변경

2. 스터디 그룹 API:
- POST /groups - 스터디 그룹 생성
- GET /groups - 스터디 그룹 목록 조회
- GET /groups/{name} - 특정 스터디 그룹 조회
- PUT /groups/{name} - 스터디 그룹 정보 업데이트

3. 스터디 메모 API:
- POST /notes - 메모 생성
- GET /notes - 메모 목록 조회
- GET /notes/{group_name}/{date}/{nickname} - 특정 메모 조회
- PUT /notes/{group_name}/{date}/{nickname} - 메모 업데이트