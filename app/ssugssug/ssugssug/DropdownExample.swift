import SwiftUI

struct DropdownExample: View {
    @State private var selectedNumber = 20
    let numbers = Array(1...30)
    
    var body: some View {
        VStack {
            Picker("선택", selection: $selectedNumber) {
                ForEach(numbers, id: \.self) { number in
                    Text("\(number)")
                }
            }
            .pickerStyle(MenuPickerStyle())
            .frame(width: 100)
            .background(Color(.systemGray5))
            .cornerRadius(8)
            
            Text("선택된 숫자: \(selectedNumber)")
                .padding()
        }
        .padding()
    }
}

#Preview {
    DropdownExample()
}
