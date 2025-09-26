import SwiftUI

/// 할 일 목록의 단일 행을 나타내는 뷰입니다.
struct TodoRowView: View {
    /// `TodoItem`에 대한 바인딩입니다. 이를 통해 뷰는 할 일 항목의 상태
    /// (예: `isCompleted` 상태)를 직접 수정할 수 있으며, 변경 사항은
    /// 원본 데이터 소스(`TodoListViewModel`)에 반영됩니다.
    @Binding var todo: TodoItem

    var body: some View {
        HStack {
            // 완료 상태를 토글하는 체크박스 이미지입니다.
            Image(systemName: todo.isCompleted ? "checkmark.square.fill" : "square")
                .foregroundColor(todo.isCompleted ? .blue : .primary)
                .onTapGesture {
                    // 바인딩된 `todo` 항목의 `isCompleted` 속성을 토글합니다.
                    todo.isCompleted.toggle()
                }

            // 할 일의 제목입니다.
            Text(todo.title)
                // 항목이 완료되면 취소선 효과를 적용합니다.
                .strikethrough(todo.isCompleted)
                // 항목이 완료되면 텍스트 색상을 흐리게 처리합니다.
                .foregroundColor(todo.isCompleted ? .gray : .primary)
        }
    }
}