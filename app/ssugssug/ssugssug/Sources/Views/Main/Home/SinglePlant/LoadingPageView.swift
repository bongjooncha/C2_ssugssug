import SwiftUI

struct LoadingPageView: View {
    @Binding var navBarHidden: Bool
    @State private var isAnimating = false
    @State private var animationStates = [false, false, false]
    @State private var timerCount = 0
    @Environment(\.presentationMode) var presentationMode
    
    // 참가자 관련 상태 추가
    @State private var participants = [
        "Test1": false,
        "Test2": false,
        "Test3": false,
        "Test4": false
    ]
    
    // 다음 버튼 활성화 상태
    @State private var nextButtonEnabled: Bool = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Color(red: 0.95, green: 0.95, blue: 0.9)
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading) {
                // 뒤로가기 버튼
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("뒤로")
                    }
                    .foregroundColor(.green)
                    .padding(.leading, 16)
                }
                .padding(.top, 10)
                
                // 참가자 확인 패널 - 좌상단(뒤로가기 아래)에 배치
                VStack(alignment: .leading, spacing: 12) {
                    Text("참가자 확인")
                        .font(.headline)
                        .padding(.bottom, 4)
                    
                    ForEach(participants.sorted(by: { $0.key < $1.key }), id: \.key) { nickname, isChecked in
                        HStack {
                            Text(nickname)
                                .font(.subheadline)
                            Spacer()
                            Button(action: {
                                participants[nickname] = !isChecked
                                updateNextButtonState()
                            }) {
                                Image(systemName: isChecked ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(isChecked ? .green : .gray)
                                    .font(.system(size: 20))
                            }
                        }
                        .padding(.vertical, 4)
                        .padding(.horizontal, 8)
                        .cornerRadius(8)
                    }
                }
                .frame(width: 130)
                .background(Color.white.opacity(0.3))
                .cornerRadius(12)
                .padding(.leading, 20)
                .padding(.top, 40)
                
                
                // 애니메이션 원들 - 화면 중앙에 배치
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
                .frame(width: 300, height: 300)
                .frame(maxWidth: .infinity)
                .padding(.top, -60)
                
                Spacer()
                
                // 다음 버튼
                Button(action: {
                    // 완료 처리
                }) {
                    Text("다음")
                        .foregroundColor(.white)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 8)
                        .background(nextButtonEnabled ? Color.green : Color.gray)
                        .cornerRadius(20)
                }
                .disabled(!nextButtonEnabled)
                .padding(.bottom, 20)
                .frame(maxWidth: .infinity)
            }
        }
        .onAppear {
            animationStates[0] = true
            navBarHidden = true
        }
        .navigationBarHidden(true)
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
    
    // 다음 버튼 활성화 상태 업데이트 함수
    private func updateNextButtonState() {
        let totalCount = participants.count
        let checkedCount = participants.values.filter { $0 }.count
        let percentChecked = Double(checkedCount) / Double(totalCount) * 100.0
        
        nextButtonEnabled = percentChecked >= 65.0
    }
}

#Preview {
    LoadingPageView(navBarHidden: .constant(false))
}