# school_erp

An offline-first app for comprehensive school management

Setup Guide:
1. Env setup
    Create a copy of the .env file from .env.example:
   
    ```shell
   cp .env.example .env
    ```

2. Install project dependencies
    ```shell
   flutter pub get
    ```

3. Generate schema / model serialization related boilerplate from freezed:
    ```shell
    dart run build_runner build --build-filter="**/*.freezed.dart" --build-filter="**/*.g.dart"
    ```

4. Run the App
    For default device:
    ```shell
    flutter run
    ```
    
    For a specific device:
    ```shell
    flutter run -d <device_name>`
    ```

   For Web with CORS disabled:
    ```shell
    flutter run -d chrome --web-browser-flag "--disable-web-security"
    ```
