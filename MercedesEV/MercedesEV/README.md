# MercedesEV

A SwiftUI application that helps users find nearby electric vehicle charging stations using Open Charge Map API.

---
 Test
## 🚧 Architecture Overview

This project follows a modular MVVM (Model-View-ViewModel) architecture:

- **Models**: Represent the data structures (e.g., `ChargingStation`, `AddressInfo`, etc.).
- **Views**: SwiftUI views such as `StationListView` and `StationDetailView` for displaying station data.
- **ViewModels**: ObservableObjects like `StationListViewModel` and `StationDetailViewModel` handle business logic and state.
- **Services**: `ChargingStationService` handles API interaction using dependency injection to promote testability.

Test coverage is provided for view models and networking service using `XCTest` with dependency injection and mock services.

---

## 🛠 Setup Instructions

1. Clone the repository
   ``bash
   git clone https://github.com/jordonb2/MercedesEV.git
   
2. Open in Xcode
Open the .xcodeproj or .xcworkspace in Xcode.

3. Build & Run
    •    Target: MercedesEV
    •    Simulator: iPhone 16 Pro (or any supported device)
    •    Build & run using the play button or Cmd + R
    
4. Unit Tests
Run all tests using the shortcut Cmd + U or through the Test navigator.

🧪 Testing
    •    Unit tests are written using XCTest.
    •    Services and ViewModels are tested using mock objects via dependency injection.
    •    All tests can be found in the MercedesEVTests folder.
    
📦 Dependencies
    •    SwiftUI
    •    Combine
    •    XCTest (unit testing)

📘 Decision Log

Key technical decisions made:
    •    MVVM Pattern: Chosen for maintainability and clear separation between logic and UI.
    •    Dependency Injection: ViewModels accept service protocols to support mocking in unit tests.
    •    XCTest: Native Apple testing framework used for reliability and compatibility.
    •    Mocking Strategy: A simple mock class (MockChargingStationService) simulates success and failure cases for unit testing.
    •    No 3rd-party Dependencies: Kept the project lightweight and native.

    
📍 Author

Jordon Bowen
Created on 7/25/2025
