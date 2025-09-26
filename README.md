# SwiftUI To-Do List App

<br>

<p align="center">
  <img width="414" height="945" alt="image" src="https://github.com/user-attachments/assets/826e0a0e-5a09-4d17-b3ef-b0def13fc6a2" />
</p>


<p align="center">
 SwiftUI와 MVVM 아키텍처 패턴을 학습하며 만든 두 번째 iOS 앱입니다.<br>
  사용자가 할 일을 추가, 완료, 삭제하고 앱을 다시 실행해도 데이터가 유지되는 간단한 To-Do 리스트 앱입니다.
</p>

<br>

## ✨ 주요 기능

- **할 일 추가**: 텍스트 필드에 새로운 할 일을 입력하고 추가할 수 있습니다.
- **상태 변경**: 체크박스를 탭하여 할 일의 완료/미완료 상태를 변경할 수 있습니다.
- **할 일 삭제**: 목록에서 항목을 왼쪽으로 스와이프하여 삭제할 수 있습니다.
- **데이터 영속성**: `UserDefaults`를 사용하여 앱을 종료하고 다시 실행해도 할 일 목록이 유지됩니다.

<br>

## 🛠️ 기술 스택

- **UI Framework**: `SwiftUI`
- **Language**: `Swift`
- **Architecture**: `MVVM (Model-View-ViewModel)`
- **Asynchronous Programming**: `Combine`
- **Data Persistence**: `UserDefaults` & `Codable`

<br>

## 📖 학습 및 성장 포인트

이 프로젝트를 통해 다음과 같은 개념들을 깊이 있게 학습하고 적용할 수 있었습니다.

### 1. MVVM 아키텍처의 이해
- **Model**: `TodoItem` - 앱의 데이터를 표현하는 순수한 `struct`.
- **View**: `ContentView`, `TodoRowView` - 사용자 인터페이스를 그리고, 모든 사용자 입력을 ViewModel에 전달하는 역할.
- **ViewModel**: `TodoListViewModel` - View를 위한 상태를 관리하고, 데이터를 추가, 삭제, 저장, 로드하는 모든 비즈니스 로직을 담당.
- 각 컴포넌트의 역할을 명확히 분리함으로써 코드의 **유지보수성**과 **테스트 용이성**을 높이는 방법을 배웠습니다.

### 2. SwiftUI의 데이터 흐름 (Data Flow)
- **`@StateObject`**: View의 생명주기 동안 ViewModel 인스턴스를 안정적으로 소유하고 관리하는 방법을 익혔습니다.
- **`@Published`**: ViewModel의 데이터가 변경될 때마다 View가 자동으로 업데이트되도록 하는 핵심적인 프로퍼티 래퍼 사용법을 이해했습니다.
- **`@Binding`**: 부모 View가 가진 데이터를 자식 View(`TodoRowView`)에서 직접 수정할 수 있도록 양방향 바인딩을 구현하는 방법을 배웠습니다. 이를 통해 `TodoRowView`가 `isCompleted` 상태를 직접 변경할 수 있었습니다.

### 3. Combine 프레임워크 기초
- `todos` 배열의 변경사항을 감지하기 위해 `@Published` 프로퍼티가 제공하는 Publisher에 `.sink`를 사용하여 구독(subscribe)하는 방법을 적용했습니다.
- 데이터가 변경될 때마다 `saveTodos()` 메서드가 자동으로 호출되도록 하여, 데이터 저장 로직을 반응형으로 구현했습니다.
- `Set<AnyCancellable>`을 사용하여 구독을 관리하고 메모리 누수를 방지하는 방법을 배웠습니다.

### 4. 데이터 영속성 (Data Persistence)
- `Codable` 프로토콜을 사용하여 `TodoItem` 같은 커스텀 타입을 `JSON` 데이터로 인코딩 및 디코딩하는 방법을 익혔습니다.
- `UserDefaults`를 사용하여 앱의 간단한 데이터를 사용자의 디바이스에 저장하고 불러오는 방법을 실습했습니다.
