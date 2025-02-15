# Explore: Mobile App for Country Info with Theme Customization

## Overview

**Explore** is a Flutter-based mobile application designed to provide users with detailed information about countries worldwide. The app fetches data from a REST API (Country API) and allows users to view a list of countries, explore detailed information about each country, and customize the app's theme (light/dark mode). The app is designed to be responsive and works seamlessly on both Android and iOS devices.

## Key Features

### Country List

- **Fetch and Display**: Fetches a list of countries from a REST API and displays it in a scrollable list.
- **Search Bar**: Allows users to filter countries by name using a search bar at the top of the screen.
- **Theme Toggle**: Includes a toggle button to switch between light and dark themes.

### Country Details

- **Detailed Information**: Displays detailed information about a selected country, including:
  - Name
  - State/Provinces (if available)
  - Flag (image)
  - Population
  - Capital city
  - Current President (if available)
  - Continent
  - Country code
- **Back Button**: Includes a "Back" button to return to the country list.

### Theme Customization

- **Light/Dark Mode**: Allows users to switch between light and dark theme styles. The theme applies across the entire app, including background colors, text, and UI components.

### UI Design

- **Responsive Design**: Ensures the app is responsive to different screen sizes, with content adjusting to fit various devices.
- **Figma Reference**: The UI design is based on the sample designs provided in the Figma link.

## Getting Started

### Prerequisites

- **Flutter SDK**: Ensure you have Flutter installed on your machine. If not, follow the official [Flutter installation guide](https://flutter.dev/docs/get-started/install).
- **IDE**: Use Android Studio, IntelliJ IDEA, or Visual Studio Code with the Flutter and Dart plugins installed.

### Installation

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/shado-w-alker/explore.git
   cd explore
   ```
2. **Install Dependencies**:
   ```bash
   flutter pub get
   ```
3. **Run the App**:
   ```bash
   flutter run
   ```
   - Use an Android emulator, iOS simulator, or a physical device to run the app.

### Building the App

- **Android**:
  ```bash
  flutter build apk
  ```
- **iOS**:
  ```bash
  flutter build ios
  ```

## Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature/YourFeatureName`).
3. Commit your changes (`git commit -m 'Add some feature'`).
4. Push to the branch (`git push origin feature/YourFeatureName`).
5. Open a pull request.

## Acknowledgments

- **Country API**: Thanks to the Country API for providing the data used in this app.
- **Figma Community**: For the UI design inspiration and resources.

## Contact

For any questions or feedback, please reach out to [Your Name] at [mecdiebere@gmail.com](mailto:mecdiebere@gmail.com).

```

---

```
