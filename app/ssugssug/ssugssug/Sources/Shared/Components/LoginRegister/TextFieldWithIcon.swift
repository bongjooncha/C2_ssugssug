import SwiftUI

struct TextFieldWithIcon: View {
    let icon: String
    let placeholder: String
    @Binding var text: String
    let isSecure: Bool
    
    init(icon: String, placeholder: String, text: Binding<String>, isSecure: Bool = false) {
        self.icon = icon
        self.placeholder = placeholder
        self._text = text
        self.isSecure = isSecure
    }
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.gray)
                .frame(width: 20)
            
            if isSecure {
                SecureField(placeholder, text: $text)
            } else {
                TextField(placeholder, text: $text)
            }
        }
        .padding()
        .background(Color(UIColor.systemGray6))
        .cornerRadius(8)
        .padding(.horizontal)
    }
} 

