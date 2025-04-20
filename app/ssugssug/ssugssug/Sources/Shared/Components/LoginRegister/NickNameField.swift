import SwiftUI

struct NickNameField: View {
    @Binding var nickname: String
    var placeholder: String = "닉네임(영문)"
    
    var body: some View {
        TextFieldWithIcon(
            icon: "person",
            placeholder: placeholder,
            text: $nickname
        )
    }
}


