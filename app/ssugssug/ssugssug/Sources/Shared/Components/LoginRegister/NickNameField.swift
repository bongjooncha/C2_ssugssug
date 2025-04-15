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

// 선택사항: 미리보기 추가
#Preview {
    @State var previewNickname = ""
    return NickNameField(nickname: $previewNickname)
}