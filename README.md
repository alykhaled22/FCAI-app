# FCAI App 🚀

![GitHub repo size](https://img.shields.io/github/repo-size/your-username/FCAI-app)
![GitHub issues](https://img.shields.io/github/issues/your-username/FCAI-app)
![GitHub stars](https://img.shields.io/github/stars/your-username/FCAI-app?style=social)
![License](https://img.shields.io/github/license/your-username/FCAI-app)

---

## 📖 Introduction

Welcome to the **FCAI App**! This project is a modern, cross-platform application designed for the Faculty of Computers and Artificial Intelligence community. Built with Flutter, it provides a seamless experience for students, staff, and visitors to access essential services and information.

---

## ✨ Features

- 🔐 User Authentication (Login, Register, Profile Management)
- 🏪 Store & Restaurant Listings
- 📦 Product Catalog
- 📍 Location & Distance Calculation
- 🗺️ Google Maps Integration (view locations on map)
- 🧭 Directions & Navigation (get directions to stores/restaurants)
- 🖼️ Image Uploads & Avatars
- 🌐 Offline Support (with local caching)

---

## 🗂️ Project Structure

```
lib/
  core/           # Core utilities, widgets, and helpers
  features/       # Main app features (authentication, products, user profile, etc.)
  main.dart       # App entry point
assets/           # Images, fonts, lotties, etc.
android/          # Android platform code
ios/              # iOS platform code
web/              # Web platform code
windows/          # Windows platform code
macos/            # macOS platform code
linux/            # Linux platform code
```

---

## ⚙️ Installation

### Prerequisites
- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Dart SDK](https://dart.dev/get-dart) (usually included with Flutter)
- Git

### Steps
1. **Clone the repository:**
   ```bash
   git clone https://github.com/your-username/FCAI-app.git
   cd FCAI-app
   ```
2. **Install dependencies:**
   ```bash
   flutter pub get
   ```
3. **Run the app:**
   ```bash
   flutter run
   ```
   > You can specify a device or platform using `-d` (e.g., `flutter run -d chrome` for web).

---

## 🚀 Usage

- **Login/Register:** Start the app and sign in or create a new account.
- **Browse Stores & Products:** Explore available stores, restaurants, and products.
- **View on Map:** Tap the map icon to view a store or restaurant location on Google Maps.
- **Get Directions:** Use the directions feature to navigate from your location to any store or restaurant.
- **Edit Profile:** Update your personal information and avatar.
- **Logout:** Securely sign out from your account.

### Example
```dart
// Entry point
void main() => runApp(const FCAIApp());
```

---

## 🤝 Contributing

Contributions are welcome! To get started:
1. Fork the repository
2. Create a new branch (`git checkout -b feature/your-feature`)
3. Commit your changes (`git commit -m 'Add new feature'`)
4. Push to the branch (`git push origin feature/your-feature`)
5. Open a Pull Request

Please read the [contributing guidelines](CONTRIBUTING.md) for more details.

---

## 📄 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

- Thanks to the FCAI community for inspiration and feedback.
- Built with [Flutter](https://flutter.dev/) and [Dart](https://dart.dev/).
- Special thanks to all contributors and open-source libraries used in this project.

---

> Made with ❤️ for the FCAI community.
