# 📱 PocketVault - Your Personal Life Organizer

![PocketVault Logo](https://i.postimg.cc/T1TQGkwQ/App-Icon-Logo.png)

**PocketVault** is a versatile and elegant Flutter application designed to help you organize your
daily life efficiently. Whether it's managing your shopping needs, tracking your favorite media (
Movies, Books, Series), or keeping your important web links handy, PocketVault serves as your secure
personal digital assistant.

---

## ✨ Features

### 🛒 Shopping List

- Add and manage items you need to buy.
- Categorize items (e.g., Groceries, Electronics).
- Mark items as "Bought" with a strike-through effect.
- Persistent storage using SQLite.

### 🎬 Media Tracker

- Track your progress on Movies, Books, and TV Series.
- Set statuses like "Plan to Watch", "Watching", or "Completed".
- Rate your experience with a 5-star rating system.
- Visual categorization with intuitive icons.

### 🔖 Bookmarks Manager

- Save important URLs with titles and categories.
- One-tap to open links in your default browser using `url_launcher`.
- Clean UI to manage all your web resources in one place.

### 🌓 Theme Customization

- Dynamic Dark and Light mode support.
- Modern UI with Google Fonts (Poppins).
- System-based theme switching.

### 🎨 Smooth UX/UI

- Staggered animations for list items.
- Custom dialogs and input fields.
- Empty state illustrations for a better user experience.

---

## 📸 Screenshots

| Splash Screen                                       | Shopping List                                          | Media Tracker                                            |
|-----------------------------------------------------|--------------------------------------------------------|----------------------------------------------------------|
| ![Splash](https://i.postimg.cc/fLc5G4wv/splash.jpg) | ![Shopping](https://i.postimg.cc/Y9685cpW/shoping.jpg) | ![Media](https://i.postimg.cc/JnNKfw1H/Media-Screen.jpg) |

| Add Media Dialog                                                 | Bookmark Screen                                                |
|------------------------------------------------------------------|----------------------------------------------------------------|
| ![Add Media](https://i.postimg.cc/zBCpsmJh/add-Media-Screen.jpg) | ![Bookmark](https://i.postimg.cc/Y9685cpY/Bookmark-Screen.jpg) |

---

## 🛠️ Tech Stack & Architecture

- **Frontend:** Flutter (Dart)
- **State Management:** Provider (Multi-Provider approach)
- **Database:** SQLite (`sqflite`) for local persistence
- **Animations:** `flutter_staggered_animations`
- **UI Components:** Material 3, Google Fonts
- **External Integration:** `url_launcher` for bookmark links

### 📁 Project Structure

The project follows a modular feature-based architecture:

- `core/`: Database helpers, themes, and global providers.
- `data/`: Data models and serialization logic.
- `features/`: Divided into `shopping`, `media`, and `bookmarks` modules, each containing its own
  Screens, Providers, and Widgets.
- `widgets/`: Reusable custom UI components.

---

---

##  Future Roadmap (Backend Integration)

Currently, **PocketVault** uses **SQLite** for local data storage. To make it a production-ready scalable application, I have planned the following updates:

- **Django REST Framework (DRF) Backend:** Transitioning from local storage to a centralized cloud database for data synchronization across devices.
- **User Authentication:** Implementing Secure JWT-based login/signup using Django.
- **REST API Integration:** Connecting the Flutter frontend with the Django backend using the `http` or `dio` package.
- **Real-time Sync:** Ensuring user data is backed up and accessible from anywhere.

---

## 🤝 Contributing
Contributions are welcome! If you'd like to improve this project, feel free to fork the repository and submit a pull request.

---

## 📄 License
This project is licensed under the MIT License.

---

**Developed with ❤️ by [Saidur Rahman]**
   