import SwiftUI

/// ToDoListApp의 메인 진입점입니다.
@main
struct TodoListAppApp: App {
    /// 앱의 씬(Scene)을 정의하는 본문입니다.
    var body: some Scene {
        /// 앱의 사용자 인터페이스를 포함하는 윈도우를 제공하는 씬입니다.
        WindowGroup {
            /// 애플리케이션의 루트 뷰입니다.
            ContentView()
        }
    }
}