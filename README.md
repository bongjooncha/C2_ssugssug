    db      : sqlight
back frame  : fastapi
    app     : ios(swiftui)
------------------------

로그인 방식:
닉네임, 비밀번호
비밀번호는 앱에서 salted 된 sha-256을 받고 이를 백에서 다시 한번 salt 처리 후 sha-256 암호화 후 db에 저장
앱에서 로그인 시 닉네임을 변수로 저장 후 이를 통해 사용자로 사용.

------------------------

DB
로그인 테이블
nickname(str):pwd(str)
=> prime key - nickname

스터디 테이블
groupName(str):groupType(str),nickname(str):cycle(int):startDate(date):endDate(date):goalGrouth(int):grouth(int)
=> prime key - groupName

스터디 메모 테이블
groupName(str):date(date):nickname(str):goal(str):result(str)
=>prime key - groupName(str):date(date):nickname(str)