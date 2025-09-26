import Foundation
import Combine

/// 할 일 목록의 ViewModel으로, `TodoItem` 데이터를 관리하고 비즈니스 로직을 처리합니다.
/// `ObservableObject`를 준수하여 SwiftUI 뷰가 변경 사항을 구독할 수 있도록 합니다.
class TodoListViewModel: ObservableObject {
    /// 뷰에 표시될 `TodoItem` 배열입니다.
    /// `@Published` 프로퍼티 래퍼는 이 배열에 대한 변경 사항을 자동으로 알려 UI가 업데이트되도록 합니다.
    @Published var todos: [TodoItem] = []

    /// `UserDefaults`에서 할 일 항목을 저장하고 불러올 때 사용하는 키입니다.
    private let todosDataKey = "todosDataKey"
    
    /// Combine 구독을 저장하여 메모리를 관리하고 적절하게 해제되도록 합니다.
    private var cancellables = Set<AnyCancellable>()

    /// ViewModel을 초기화합니다. 생성 시 `UserDefaults`에서 할 일 항목을 불러옵니다.
    init() {
        loadTodos()
    }

    /// 목록에 새로운 할 일 항목을 추가합니다.
    /// - Parameter title: 새로운 할 일의 제목입니다.
    func addTodo(title: String) {
        // 제목이 비어 있지 않은지 확인한 후 추가합니다.
        if !title.isEmpty {
            let newTodo = TodoItem(id: UUID(), title: title, isCompleted: false)
            // 가시성을 높이기 위해 배열의 맨 앞에 새 항목을 삽입합니다.
            todos.insert(newTodo, at: 0)
        }
    }

    /// 인덱스 집합을 기반으로 목록에서 하나 이상의 할 일 항목을 삭제합니다.
    /// 이 메서드는 SwiftUI의 `onDelete` 수정자와 함께 작동하도록 설계되었습니다.
    /// - Parameter offsets: 삭제할 항목의 인덱스를 포함하는 `IndexSet`입니다.
    func deleteTodo(at offsets: IndexSet) {
        todos.remove(atOffsets: offsets)
    }

    /// 현재 할 일 목록을 `UserDefaults`에 저장합니다.
    /// 이 메서드는 `todos` 배열이 수정될 때마다 자동으로 호출됩니다.
    private func saveTodos() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(todos) {
            UserDefaults.standard.set(encoded, forKey: todosDataKey)
        }
    }

    /// `UserDefaults`에서 할 일 항목을 불러옵니다. 저장된 데이터가 없으면
    /// 목록을 몇 가지 샘플 항목으로 채웁니다.
    private func loadTodos() {
        // UserDefaults에서 데이터를 로드하고 디코딩을 시도합니다.
        if let savedTodosData = UserDefaults.standard.data(forKey: todosDataKey),
           let loadedTodos = try? JSONDecoder().decode([TodoItem].self, from: savedTodosData) {
            self.todos = loadedTodos
        } else {
            // 로드에 실패하면 기본 샘플 데이터를 제공합니다.
            self.todos = [
                TodoItem(id: UUID(), title: "MVVM 패턴 배우기", isCompleted: false),
                TodoItem(id: UUID(), title: "코드 리팩토링", isCompleted: true),
            ]
        }

        // `todos` 배열이 변경될 때마다 자동으로 저장하도록 Combine 파이프라인을 설정합니다.
        $todos
            .sink { [weak self] _ in
                // `[weak self]`는 순환 참조를 방지합니다.
                self?.saveTodos()
            }
            .store(in: &cancellables) // 구독을 저장합니다.
    }
}