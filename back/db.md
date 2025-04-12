## DB skema
User(사용자 테이블)
- *nickname(닉네임) ||* pwd(비밀번호)

StudysInfo(스터디 정보 테이블)
- *nickname(닉네임) | study_name(스터디 이름) ||* study_type(스터디 내용) | meating_num(만남 횟수) | meating_goal(목표 만남 횟수)

StudysMemo(스터디 진행 테이블)
- *nickname(닉네임) | study_name(스터디 이름) | study_date(스터디 일자) ||* study_goal(당일 목표) | study_imp(당일 느낀점)
-----------

속성값 (INT,REAL,TEXT,BLOB,NULL)

- nickname(TEXT): 사용자 닉네임
- pwd(TEXT): 사용자 비밀번호

- study_name(TEXT): 사용자가 참여하고 있는 스터디
- study_type(INT): 사용자가 참여하고 있는 스터디 내용(0:스터디,1:문화생활,2: 경험공유)
- meating_goal(INT): 사용자가 참여하고 있는 스터디 목표 만남 횟수
- meating_num(INT:defulte 0): 사용자가 참여하고 있는 스터디 만남 횟수

- study_date(TEXT): 해당 스터디를 진행한 일자
- study_goal(TEXT): 해당 스터디를 진행 시 목표
- study_imp(TEXT): 해당 스터디를 진행 후 느낀점