import SwiftUI

struct LoadingPageView: View {
    @State private var isAnimating = false
    @State private var completedTasks = [true, false, true] // 체크 표시 상태
    
    // 세 개 원에 대한 각각의 애니메이션 상태
    @State private var animationStates = [false, false, false]
    @State private var timerCount = 0
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            // 배경색
            Color(red: 0.95, green: 0.95, blue: 0.9)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                ZStack {
                    ForEach(0..<3) { index in
                        Circle()
                            .stroke(Color.green, lineWidth: 2)
                            .frame(width: animationStates[index] ? 250 : 150, 
                                   height: animationStates[index] ? 250 : 150)
                            .opacity(animationStates[index] ? 0 : 1)
                    }
                    Circle()
                        .fill(Color.green)
                        .frame(width: 70, height: 70)
                }
                .frame(height: 150)
                
                Spacer()
                Button(action: {
                    // 완료 처리
                }) {
                    Text("다음")
                        .foregroundColor(.white)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 8)
                        .background(Color.green)
                        .cornerRadius(20)
                }
                .padding(.bottom, 30)
            }
        }
        .onAppear {
            // 초기 애니메이션 상태 설정
            animationStates[0] = true
        }
        .onReceive(timer) { _ in
            withAnimation(.easeInOut(duration: 0.6)) {
                // 0.3초마다 타이머 증가
                timerCount += 1
                
                // 0.3초마다 새 원 시작
                if timerCount % 1 == 0 && timerCount < 3 {
                    animationStates[timerCount] = true
                }
                
                // 주기적으로 애니메이션 재시작
                if timerCount >= 3 {
                    // 모든 원 리셋
                    if timerCount % 3 == 0 {
                        animationStates = [false, false, false]
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            withAnimation(.easeInOut(duration: 0.6)) {
                                animationStates[0] = true
                            }
                        }
                    } else if timerCount % 3 == 1 {
                        withAnimation(.easeInOut(duration: 0.6)) {
                            animationStates[1] = true
                        }
                    } else if timerCount % 3 == 2 {
                        withAnimation(.easeInOut(duration: 0.6)) {
                            animationStates[2] = true
                        }
                    }
                }
            }
        }
    }
}

struct LoadingPageView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingPageView()
    }
}
