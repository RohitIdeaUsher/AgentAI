# Virtual Agent App

This is a Flutter-based Virtual Agent app that utilizes the Gemini API for AI-powered interactions.

## Prerequisites

- Flutter SDK version **3.24.0** (Ensure you have it installed before running the project)
- A valid Gemini API key

## Setup Instructions

1. **Clone the Repository**
   ```sh
   git clone <repository-url>
   cd <project-directory>
   ```

2. **Install Flutter Dependencies**
   ```sh
   flutter pub get
   ```

3. **Create an `.env` File**
   Inside the root directory, create a `.env` file and add the following:
   ```sh
   API_KEY='your-gemini-api-key'
   ```

4. **Run the App**
   ```sh
   flutter run
   ```

## Features
- Virtual agent powered by Gemini API
- Floating Action Button to create new chat sessions
- Chat history stored locally
- Multi-session support

## Dependencies
Make sure to have the necessary dependencies in your `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_dotenv: ^5.1.0  # For environment variables
  hive: ^2.2.3            # Local storage
  hive_flutter: ^1.1.0    # Hive integration for Flutter
  get_storage: ^2.1.1     # Alternative local storage option
  http: ^1.3.0            # API requests
  lottie: ^3.2.0          # To play animations
  http: ^1.3.0            # API requests
```

## Additional Notes
- If you face any issues, ensure that the `.env` file is correctly configured.
- For iOS users, run:
  ```sh
  cd ios && pod install
  ```
  before running the app.

## License
This project is licensed under the MIT License.

