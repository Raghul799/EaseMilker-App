# 🐄 Ease Milker

**Ease Milker** is a comprehensive Flutter-based mobile application designed to help dairy farmers monitor and manage automated milking devices, track daily milk production statistics, and streamline farm operations.

---

## 📋 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Technology Stack](#technology-stack)
- [Project Structure](#project-structure)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Running the Application](#running-the-application)
- [Application Architecture](#application-architecture)
- [Key Components](#key-components)
- [Authentication](#authentication)
- [User Interface](#user-interface)
- [Data Persistence](#data-persistence)
- [Platform Support](#platform-support)
- [Development](#development)
- [Build & Deployment](#build--deployment)
- [Contributing](#contributing)
- [License](#license)

---

## 🎯 Overview

**Ease Milker** is a mobile-first application that empowers small to medium-scale dairy farmers with digital tools to:
- Monitor automated milking machine operations
- Track daily milk production and history
- Manage machine variants (High, Medium, Low)
- Access a shop for dairy supplies and equipment
- Receive real-time notifications about machine status
- Configure app settings and preferences

The app is built with Flutter for cross-platform compatibility and uses Material Design principles for a clean, intuitive user experience.

---

## ✨ Features

### 🏠 Home Dashboard
- Welcome screen with personalized farmer information
- Real-time milk production statistics
- Quick access to all major features
- Machine status monitoring
- Alert notifications for tank status and machine issues

### 📊 History Tracking
- View historical milk production data
- Date-wise production records
- Statistical insights and trends
- Detailed production cards with expandable information

### 💎 Premium Management
- Three machine variants: High, Medium, and Low
- Variant-specific feature access
- Premium features for high-variant machines
- Upgrade options for lower variants

### 🛒 Shop & Marketplace
- Browse dairy equipment and supplies
- Product listings with images and descriptions
- Booking system for purchases
- Order tracking and management
- Shopping cart functionality

### 📬 Notifications
- Real-time alerts for:
  - Tank filling status
  - Milk flow issues
  - Machine malfunctions
  - Production milestones
- Message center with read/unread status
- Action buttons for critical alerts

### ⚙️ Settings & Configuration
- User profile management
- Machine ID and connection settings
- Alert sound customization
- App theme preferences
- About Us and Help & Contact sections
- Logout functionality

---

## 🛠️ Technology Stack

### Frontend Framework
- **Flutter** (SDK ^3.9.2)
- **Dart** programming language
- **Material Design** UI components

### State Management
- StatefulWidget and StatelessWidget
- Local state management with setState()

### Data Persistence
- **shared_preferences** (^2.5.3) - For storing user preferences and authentication state

### Development Tools
- **flutter_lints** (^5.0.0) - Linting rules
- **flutter_launcher_icons** (^0.13.1) - Custom app icon generation
- **flutter_test** - Testing framework

### Build System
- Gradle (Kotlin DSL) for Android
- Xcode for iOS
- CMake for Linux/Windows desktop builds

---

## 📁 Project Structure

```
EaseMilker-App/
├── lib/
│   ├── main.dart                      # Application entry point
│   ├── Home page/
│   │   └── home_page.dart            # Main dashboard with tabs
│   ├── loading page/
│   │   └── loading_page.dart         # Splash screen with auth check
│   ├── login/
│   │   ├── login_page.dart           # Login UI
│   │   └── auth_service.dart         # Authentication service
│   ├── History page/
│   │   └── history_page.dart         # Production history view
│   ├── Premium page/
│   │   └── premium_page.dart         # Variant management
│   ├── Shop page/
│   │   ├── shop_page.dart            # Marketplace UI
│   │   └── booking_page.dart         # Order management
│   ├── Settings page/
│   │   ├── settings_page.dart        # Settings hub
│   │   ├── about_us_page.dart        # About information
│   │   ├── help_contact_page.dart    # Support page
│   │   ├── alert_sound_service.dart  # Sound settings service
│   │   └── alert_sound_dialog.dart   # Sound settings dialog
│   ├── NavBar/
│   │   └── navbar.dart               # Bottom navigation bar
│   └── widgets/
│       ├── top_header.dart           # Reusable header component
│       └── message_page.dart         # Notifications center
├── assets/
│   └── images/                       # App icons and graphics
├── android/                          # Android-specific configuration
├── ios/                              # iOS-specific configuration
├── web/                              # Web platform support
├── windows/                          # Windows desktop support
├── linux/                            # Linux desktop support
├── macos/                            # macOS desktop support
├── pubspec.yaml                      # Dependencies and metadata
├── analysis_options.yaml             # Linter configuration
└── README.md                         # Project documentation
```

---

## 📋 Prerequisites

Before running this project, ensure you have:

1. **Flutter SDK** (3.9.2 or higher)
   - Download from [flutter.dev](https://flutter.dev)
   - Add Flutter to your system PATH

2. **Dart SDK** (included with Flutter)

3. **Platform-specific tools**:
   - **Android**: Android Studio with Android SDK
   - **iOS**: Xcode (macOS only)
   - **Desktop**: Platform-specific build tools

4. **IDE** (recommended):
   - Visual Studio Code with Flutter extension
   - Android Studio with Flutter plugin

5. **Device/Emulator**:
   - Physical device connected via USB
   - Android Emulator or iOS Simulator
   - Desktop platform for Windows/Linux/macOS

---

## 🚀 Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/Raghul799/EaseMilker-App.git
   cd EaseMilker-App
   ```

2. **Install Flutter dependencies**:
   ```powershell
   flutter pub get
   ```

3. **Verify Flutter installation**:
   ```powershell
   flutter doctor
   ```

4. **Generate app icons** (if needed):
   ```powershell
   flutter pub run flutter_launcher_icons
   ```

---

## 🎮 Running the Application

### Development Mode

1. **List available devices**:
   ```powershell
   flutter devices
   ```

2. **Run on specific device**:
   ```powershell
   flutter run -d <device-id>
   ```

3. **Run on Android**:
   ```powershell
   flutter run -d android
   ```

4. **Run on iOS** (macOS only):
   ```powershell
   flutter run -d ios
   ```

5. **Run on Chrome** (web):
   ```powershell
   flutter run -d chrome
   ```

6. **Run on Windows**:
   ```powershell
   flutter run -d windows
   ```

### Production Mode

**Build release APK** (Android):
```powershell
flutter build apk --release
```

**Build app bundle** (Android):
```powershell
flutter build appbundle --release
```

**Build iOS app** (macOS only):
```powershell
flutter build ios --release
```

**Build web app**:
```powershell
flutter build web --release
```

---

## 🏗️ Application Architecture

### Navigation Flow

```
LoadingPage (Splash)
    ├─ Check Authentication
    ├─ If Logged In → HomePage
    └─ If Not Logged In → LoginPage
             └─ After Login → HomePage

HomePage (Bottom Navigation)
    ├─ Tab 0: Home Dashboard
    ├─ Tab 1: History Page
    ├─ Tab 2: Premium Page
    ├─ Tab 3: Shop Page
    └─ Tab 4: Settings Page

TopHeader (All Pages)
    ├─ Profile Avatar → Settings Page
    └─ Bell Icon → Message Page
```

### State Management Pattern

- **Local State**: Using StatefulWidget with setState() for component-level state
- **Persistent State**: shared_preferences for cross-session data
- **Navigation State**: Navigator with named routes and MaterialPageRoute

### Service Layer

1. **AuthService** (`lib/login/auth_service.dart`)
   - Singleton pattern implementation
   - Handles login/logout operations
   - Manages authentication state persistence
   - Stores machine ID

2. **AlertSoundService** (`lib/Settings page/alert_sound_service.dart`)
   - Singleton pattern for sound settings
   - Manages alert sound preferences
   - Uses shared_preferences for persistence

---

## 🔑 Key Components

### 1. Loading Page
**File**: `lib/loading page/loading_page.dart`

- Initial splash screen displayed for 3 seconds
- Checks authentication state using AuthService
- Automatically routes to HomePage or LoginPage
- Features app branding (cow image and logo)
- Responsive design for various screen sizes

### 2. Login Page
**File**: `lib/login/login_page.dart`

**Features**:
- Machine ID and password input fields
- Form validation
- Password visibility toggle
- Default credentials for testing:
  - Machine ID: `EM1234`
  - Password: `admin123`
- Error handling with SnackBar notifications
- Responsive layout with adaptive spacing

### 3. Home Page
**File**: `lib/Home page/home_page.dart`

**Features**:
- IndexedStack for tab navigation (preserves state)
- Five main sections accessible via bottom navigation
- Dashboard with production statistics
- Welcome message personalized with farmer name
- Gradient background matching brand colors
- Real-time alert sound state management

**Tabs**:
0. Home Dashboard - Production overview and quick stats
1. History - Historical production data
2. Premium - Machine variant features
3. Shop - Marketplace for equipment
4. Settings - App configuration

### 4. History Page
**File**: `lib/History page/history_page.dart`

**Features**:
- Displays historical milk production records
- Card-based layout for each day's production
- Consistent gradient header design
- Scrollable content area
- Reuses TopHeader component

### 5. Premium Page
**File**: `lib/Premium page/premium_page.dart`

**Features**:
- Three variant cards: High, Medium, Low
- Access control based on machine variant
- Visual distinction between accessible/locked features
- Upgrade prompts for lower variants
- Descriptive text for each variant's capabilities

### 6. Shop Page
**File**: `lib/Shop page/shop_page.dart`

**Features**:
- Product listing interface
- Shopping bag icon leading to BookingPage
- Brand imagery (cow and logo)
- Clean white card design for products
- Navigation to booking management

### 7. Booking Page
**File**: `lib/Shop page/booking_page.dart`

**Features**:
- Display user's current bookings
- Order status tracking
- Product details in card format
- Integration with bottom navigation

### 8. Settings Page
**File**: `lib/Settings page/settings_page.dart`

**Features**:
- List-based settings menu
- Account management section
- Alert sound toggle
- Navigation to About Us page
- Navigation to Help & Contact page
- Logout functionality with confirmation dialog
- Consistent icon design for each setting

### 9. Message Page
**File**: `lib/widgets/message_page.dart`

**Features**:
- Notification center for machine alerts
- Two types of messages:
  - "Tank filled" alerts with action buttons
  - "Milk not coming" warnings
- Read/unread message status
- Timestamp for each notification
- Responsive card design
- Navigation back to home via bottom bar

### 10. Navigation Bar
**File**: `lib/NavBar/navbar.dart`

**Features**:
- Gradient background (blue theme)
- Five navigation items with custom icons
- Active state indication with white underline
- Smooth animations on tab switch
- Responsive icon sizing
- Touch feedback with InkWell effects

### 11. Top Header
**File**: `lib/widgets/top_header.dart`

**Features**:
- Reusable component across all pages
- Profile avatar (tappable → Settings)
- User name and machine ID display
- Notification bell icon (tappable → Messages)
- Consistent styling with drop shadow
- Adapts to different page contexts

---

## 🔐 Authentication

### Login Credentials (Testing)
- **Machine ID**: `EM1234`
- **Password**: `admin123`

### Authentication Flow

1. **First Launch**:
   - LoadingPage checks login state
   - User is directed to LoginPage
   - Credentials are validated
   - AuthService saves login state
   - User is redirected to HomePage

2. **Subsequent Launches**:
   - LoadingPage checks login state
   - If authenticated, directly navigate to HomePage
   - Session persists across app restarts

3. **Logout**:
   - Settings page → Logout option
   - Confirmation dialog appears
   - AuthService clears login state
   - User is redirected to LoginPage

### Security Notes
- Authentication state stored using shared_preferences
- Machine ID stored securely on device
- No sensitive credentials in source code (ready for backend integration)
- Ready to integrate with REST API or Firebase

---

## 🎨 User Interface

### Design System

**Color Palette**:
- Primary Blue: `#006CC7`
- Light Blue: `#68B6FF`
- Accent Blue: `#2874F0`
- Background: `#FFFFFF`
- Text Primary: `#212121`
- Text Secondary: `#9E9E9E`

**Gradients**:
- Header Gradient: Linear gradient from `#006CC7` to `#68B6FF`
- NavBar Gradient: Linear gradient from `#0786F0` to `#044D8A`

**Typography**:
- Primary Font: Poppins (headings, titles)
- Secondary Font: Roboto (body text)
- Font Sizes: 12-24px (responsive scaling)

**Spacing**:
- Consistent padding: 12-24px
- Card spacing: 16px between elements
- Screen margins: 20px horizontal

**Shadows**:
- Elevation for cards and components
- Soft shadows for depth perception
- Blue-tinted shadows on primary elements

### Responsive Design

- Adaptive layouts for different screen sizes
- Minimum screen width support: 320px
- Maximum content width constraints
- Dynamic font sizing based on screen width
- Flexible image scaling with aspect ratio preservation

---

## 💾 Data Persistence

### Shared Preferences Usage

**Authentication Data**:
- `is_logged_in`: Boolean flag for login state
- `machine_id`: Stored machine ID after successful login

**Settings Data**:
- `alert_sound_enabled`: Boolean for alert sound preference (default: true)

### Future Backend Integration Points

The app is structured to easily integrate with a backend API:

1. **Authentication Endpoint**: Replace local validation with API calls
2. **Production Data**: Fetch real-time milk production statistics
3. **History API**: Retrieve historical data from database
4. **Shop Inventory**: Load products from backend
5. **Notifications**: Push notifications via FCM or similar
6. **User Profile**: Sync user data across devices

---

## 🖥️ Platform Support

### Android
- **Minimum SDK**: Configured via Flutter
- **Target SDK**: Latest
- **Namespace**: `com.example.easemilker`
- **Build System**: Gradle with Kotlin DSL
- **Java Version**: 11

### iOS
- **Deployment Target**: iOS 12.0+
- **Build System**: Xcode project
- **Swift Version**: 5.0+

### Web
- **Browser Support**: Modern browsers (Chrome, Firefox, Edge, Safari)
- **Responsive**: Adapts to desktop and tablet viewports

### Desktop
- **Windows**: Native Windows app support
- **Linux**: CMake-based build system
- **macOS**: Native macOS app support

---

## 👨‍💻 Development

### Code Quality

**Linting**:
```powershell
flutter analyze
```

**Formatting**:
```powershell
flutter format lib/
```

**Testing**:
```powershell
flutter test
```

### Development Workflow

1. **Hot Reload**: Press `r` in terminal during debug session
2. **Hot Restart**: Press `R` in terminal during debug session
3. **Debugging**: Use VS Code debugger or Android Studio
4. **Logging**: Use `print()` or `debugPrint()` statements

### Clean Build

If you encounter build issues:
```powershell
flutter clean
flutter pub get
flutter pub run flutter_launcher_icons
flutter run
```

### Adding Dependencies

1. Add package to `pubspec.yaml`:
   ```yaml
   dependencies:
     package_name: ^version
   ```

2. Install:
   ```powershell
   flutter pub get
   ```

3. Import in Dart files:
   ```dart
   import 'package:package_name/package_name.dart';
   ```

---

## 📦 Build & Deployment

### Android Release Build

1. **Generate keystore** (first time only):
   ```powershell
   keytool -genkey -v -keystore ~/key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key
   ```

2. **Configure signing** in `android/key.properties`

3. **Build release APK**:
   ```powershell
   flutter build apk --release
   ```
   Output: `build/app/outputs/flutter-apk/app-release.apk`

4. **Build app bundle** (for Play Store):
   ```powershell
   flutter build appbundle --release
   ```
   Output: `build/app/outputs/bundle/release/app-release.aab`

### iOS Release Build

1. **Open Xcode**:
   ```bash
   open ios/Runner.xcworkspace
   ```

2. **Configure signing** in Xcode
3. **Archive** the app
4. **Distribute** to App Store or TestFlight

### Web Deployment

1. **Build**:
   ```powershell
   flutter build web --release
   ```

2. **Deploy** `build/web/` folder to hosting service

---

## 🤝 Contributing

### Guidelines

1. **Fork** the repository
2. **Create** a feature branch:
   ```bash
   git checkout -b feature/your-feature-name
   ```
3. **Commit** your changes:
   ```bash
   git commit -m "Add: your feature description"
   ```
4. **Push** to your branch:
   ```bash
   git push origin feature/your-feature-name
   ```
5. **Open** a Pull Request

### Code Standards

- Follow Dart style guide
- Use meaningful variable and function names
- Add comments for complex logic
- Keep functions small and focused
- Write tests for new features
- Ensure all tests pass before submitting PR

### Security

- **Never commit** sensitive data (API keys, credentials)
- **Do not share** signing keys or provisioning profiles
- **Review** dependencies for security vulnerabilities
- **Use** environment variables for configuration

---

## 📄 License

This project is developed for educational and commercial purposes. All rights reserved.

---

## 📞 Contact & Support

- **Repository**: [github.com/Raghul799/EaseMilker-App](https://github.com/Raghul799/EaseMilker-App)
- **Issues**: Submit via GitHub Issues
- **Owner**: Raghul799

---

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Material Design for UI/UX guidelines
- Open source community for packages and tools

---

**Version**: 0.1.0  
**Last Updated**: November 2025  
**Status**: Active Development

---

*Made with ❤️ for dairy farmers worldwide*
