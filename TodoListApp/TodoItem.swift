import Foundation

/// 목록에 있는 단일 할 일 항목을 나타냅니다.
struct TodoItem: Identifiable, Codable, Equatable {
    /// `Identifiable` 프로토콜을 준수하기 위한 고유 식별자입니다.
    let id: UUID
    
    /// 할 일의 제목 또는 설명입니다.
    var title: String
    
    /// 할 일의 완료 여부를 나타내는 부울 값입니다.
    var isCompleted: Bool
}