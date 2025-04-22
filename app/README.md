## ViewModel

### AuthViewModel
#### 생성할 변수
- user
- isAuthenticated
- errorMessage
- isLoading

#### 역활
- 사용자가 로그인 했는지 확인
- 사용자가 누구인지 확인(currentUser 변수를 통해)

#### 위치
- View 최외각에서 사용자 인증 및 하위 View에 사용자 nickname전달


### StudyViewModel
#### 외부로 부터 받을 변수
- AuthViewModel의 currentUser

#### 생성할 변수
- 
- isAuthenticated
- errorMessage
- isLoading

#### 역활
- 사용자가 로그인 했는지 확인
- 사용자가 누구인지 확인(currentUser 변수를 통해)

#### 위치
- View 최외각에서 사용자 인증 및 하위 View에 사용자 nickname전달