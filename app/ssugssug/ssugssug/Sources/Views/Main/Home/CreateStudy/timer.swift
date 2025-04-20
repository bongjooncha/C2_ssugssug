import SwiftUI

struct TimePickerView: View {
    @Binding var selectedTime: Date  // Binding으로 변경

    var body: some View {
        VStack {
            DatePicker("시간 선택", selection: $selectedTime, displayedComponents: .hourAndMinute)
                .datePickerStyle(WheelDatePickerStyle()) 
                .labelsHidden()
        }
    }
}

// 미리보기를 위한 래퍼 뷰
struct TimePickerPreview: View {
    @State private var previewTime = Date()
    
    var body: some View {
        TimePickerView(selectedTime: $previewTime)
    }
}

#Preview {
    TimePickerPreview()
}