import SwiftUI

struct CreateStudyView: View {
    @State private var studyName: String = ""
    @State private var studyType: Int = 0
    @State private var selectedTime: Date = Date()

    @State private var meetingGoal: Int = 5
    let meetingNums = Array(3...30)

    @State private var selectedHour: Int = 0
    @State private var selectedMinute: Int = 0
    let hours = Array(0...4)
    let minutes = [0, 15, 30, 45]
    
    private let studyTypes = ["스터디", "문화생활", "경험공유"]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 40) {
            Text("농부 모임 만들기 🌱")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top)
            
            // 스터디 이름  
            VStack(alignment: .leading, spacing: 8) {
                Text("스터디 이름")
                    .font(.headline)
                
                TextField("코딩 스터디", text: $studyName)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
            }

            // 스터디 타입
            VStack(alignment: .leading, spacing: 8) {
                Text("내용")
                    .font(.headline)
                
                Picker("스터디 타입", selection: $studyType) {
                    ForEach(0..<studyTypes.count, id: \.self) { index in
                        Text(studyTypes[index])
                    }
                }
                .pickerStyle(.segmented)
            }

            // 스터디원
            VStack(alignment: .leading, spacing: 8) {
                Text("인원")
                    .font(.headline)
                
            }

            // 스터디 시간
            VStack(alignment: .leading, spacing: 8) {
                Text("스터디 시간")
                    .font(.headline)
                
                HStack(spacing: 15) {
                    HStack {
                        Picker("시", selection: $selectedHour) {
                            ForEach(hours, id: \.self) { hour in
                                Text("\(hour)시")
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .frame(width: 80)
                        .background(Color(.systemGray6))
                        .cornerRadius(5)
                    }
                    
                    HStack {
                        Picker("분", selection: $selectedMinute) {
                            ForEach(minutes, id: \.self) { minute in
                                Text("\(minute)분")
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .frame(width: 80)
                        .background(Color(.systemGray6))
                        .cornerRadius(5)
                    }
                }
            }

            // 목표 만남 횟수
            VStack(alignment: .leading, spacing: 8) {
                Text("목표 만남 횟수")
                    .font(.headline)

                Picker("선택", selection: $meetingGoal) {
                    ForEach(meetingNums, id: \.self) { number in
                        Text("\(number)회")
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .frame(width: 80)
                .background(Color(.systemGray6))
                .cornerRadius(5)
            }
            
            Spacer()
            
            Button(action: {
                // 완료 로직 구현
            }) {
                Text("완료")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green.opacity(0.8))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.bottom)
        }
        .padding()
    }
}


#Preview {
    CreateStudyView()
}