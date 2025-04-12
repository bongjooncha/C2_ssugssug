    db      : sqlight
back frame  : fastapi
    app     : ios(swiftui)
------------------------

로그인 방식:
nickname, 비밀번호
비밀번호는 앱에서 salted 된 sha-256을 받고 이를 백에서 다시 한번 salt 처리 후 sha-256 암호화 후 db에 저장
앱에서 로그인 시 nickname을 변수로 저장 후 이를 통해 사용자로 사용.

------------------------