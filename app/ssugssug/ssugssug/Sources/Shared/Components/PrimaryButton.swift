import SwiftUI

struct PrimaryButton: View {
    let title: String
    let action: () -> Void
    let isDisabled: Bool
    
    init(title: String, isDisabled: Bool = false, action: @escaping () -> Void) {
        self.title = title
        self.isDisabled = isDisabled
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(isDisabled ? Color.gray : Color.green)
                .cornerRadius(8)
                .padding(.horizontal)
        }
        .disabled(isDisabled)
    }
} 

