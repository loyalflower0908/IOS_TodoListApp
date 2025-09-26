import SwiftUI

/// 애플리케이션의 메인 뷰로, 할 일 목록을 표시합니다.
struct ContentView: View {
    /// 할 일 목록의 상태와 로직을 관리합니다.
    /// `@StateObject`는 뷰의 생명주기 동안 `TodoListViewModel`을 유지합니다.
    @StateObject private var viewModel = TodoListViewModel()

    /// 사용자가 생성 중인 새로운 할 일의 제목을 담는 상태 변수입니다.
    @State private var newTodoTitle: String = ""

    var body: some View {
        NavigationStack {
            VStack {
                // MARK: - 새로운 할 일 입력을 위한 UI
                HStack {
                    // 새로운 할 일의 제목을 입력받는 텍스트 필드입니다.
                    TextField("새로운 할 일 추가", text: $newTodoTitle)
                        .textFieldStyle(.roundedBorder)
                        .padding(.leading)

                    // 새로운 할 일을 추가하는 버튼입니다.
                    Button(action: {
                        viewModel.addTodo(title: newTodoTitle)
                        newTodoTitle = "" // 추가 후 입력 필드를 초기화합니다.
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.largeTitle)
                            .padding(.trailing)
                    }
                    // 입력 필드가 비어있으면 버튼을 비활성화합니다.
                    .disabled(newTodoTitle.isEmpty)
                }

                // MARK: - 할 일 목록
                List {
                    // ViewModel의 `todos` 배열을 순회하여 각 할 일을 표시합니다.
                    // `$` 접두사는 각 `todo` 항목에 대한 바인딩을 생성하여
                    // `TodoRowView`가 직접 수정할 수 있도록 합니다.
                    ForEach($viewModel.todos) { $todo in
                        TodoRowView(todo: $todo)
                    }
                    // 목록에서 스와이프하여 삭제하는 기능을 활성화합니다.
                    .onDelete(perform: viewModel.deleteTodo)
                }
            }
            .navigationTitle("ToDo 리스트")
        }
    }
}

// MARK: - 미리보기
#Preview {
    ContentView()
}
