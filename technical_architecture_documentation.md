# SpaceLinx HR - Technical & Architectural Documentation

## 1. Overview
The SpaceLinx HR mobile application is built using the **Flutter** framework. It follows a highly structured, scalable approach blending **Feature-Driven Architecture** with **Clean Architecture** principles to separate concerns between the UI, State Management, and Data layers.

## 2. Environment & Versioning
- **Flutter SDK**: `flutter` (Uses Material Design)
- **Dart SDK**: `^3.10.8`
- **Current App Version**: `1.0.0+1`

## 3. High-Level Architecture
The project is organized inside the `lib/` directory using the following structural standards:

```text
lib/
├── core/             # Application-wide core setups
│   ├── api/          # API interceptors and base configurations
│   ├── auth/         # Authentication core logic
│   └── theme/        # Global themes, colors, typography (Figma implemented)
├── data/             # Data Layer (Network & Local Storage)
│   ├── models/       # Data models and DTOs
│   ├── repositories/ # Repository pattern for data abstraction
│   └── services/     # API service implementations
├── providers/        # State Management Layer
├── services/         # Application-level services (e.g., Auth actions)
└── ui/               # Presentation Layer (Feature-first strategy)
    ├── screens/      # Full-page application views 
    └── widgets/      # Reusable, common, and feature-specific widgets
```

### 3.1 Separation of Concerns
1. **Presentation Layer (`lib/ui`)**: Contains only pure UI code. Widgets are designed to be as stateless as possible, listening to logical states from providers.
2. **State Management (`lib/providers`)**: Handles business logic and UI state. Acts as the intermediary between external data and the UI.
3. **Data Layer (`lib/data`)**: Responsible for fetching, parsing, and sending data to the backend via APIs.

## 4. Key Dependencies & Libraries
The application relies on several robust open-source packages to handle critical functionality:

### 4.1 State Management & Dependency Injection
- **`provider` (^6.0.5)**: The primary state management solution used to inject dependencies and manage widget rebuilds reacting to state changes.

### 4.2 Networking & API
- **`dio` (^5.3.3)**: A powerful HTTP client used for handling complex API requests, interceptors (for tokens), and error handling.

### 4.3 Authentication
- **`aad_oauth` (^1.0.1)**: Microsoft Azure Active Directory OAuth implementation used to handle the primary login flow via MSAL (Microsoft Authentication Library).

### 4.4 Data Parsing
- **`json_annotation` (^4.8.1)** & **`json_serializable` (^6.7.1)**: Used alongside `build_runner` to auto-generate from/to JSON methods for reliable data model serialization.

### 4.5 UI & Styling
- **`google_fonts` (^6.2.1)**: Dynamic font loading to match Figma typographies.
- **`fl_chart` (^0.63.0)**: Used in the Dashboard screens to display graphical data and analytics.
- **`cupertino_icons` (^1.0.8)**: iOS style iconography.

### 4.6 Utilities
- **`shared_preferences` (^2.2.1)**: Persistent local storage for user preferences and lightweight caching (e.g., token storage before secure vaulting).
- **`intl` (^0.18.1)**: Internationalization and Date/Time formatting.
- **`crypto` (^3.0.3)**: Cryptographic hashing functions.

## 5. Build Tools
Code generation is heavily utilized to prevent boilerplate coding errors:
- **`build_runner` (^2.4.6)**: Run via `dart run build_runner build` to generate JSON serializable models.
- **`flutter_lints` (^6.0.0)**: Enforces strict coding guidelines across the codebase.
