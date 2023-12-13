# login_flutter

A new Flutter project.

## Installation

Instructions on how to install the project, for example:

```sh
git clone  git@github.com:ebobo/dart_ffi_password_flutter.git
cd dart_ffi_password_flutter
flutter pub get
```

# Run the project

```sh
flutter run
```

## Building a Release for Linux

Before building a release for Linux, ensure you have set up your development environment for Linux desktop support. You can follow the instructions on the Flutter website [here](https://flutter.dev/desktop#linux).

Once your environment is set up, you can build a release using the following steps:

1. From the root of your project, run `flutter build linux`.
2. The release bundle will be created at `/build/linux/x64/release/bundle`.

To run your application, navigate to the release bundle directory and execute your app:

```sh
cd build/linux/x64/release/bundle
./your_app_name
```

# Build on Mac

build the application

```sh
flutter build macos
```

To run your application, navigate to the release bundle directory and execute your app:

```sh
 ~/projects/flutter/flutter_ffi/dart_ffi_password_flutter/build/macos/Build/Products/Release/login_flutter.app/Contents/MacOS % ./login_flutter
```

# add command line arguments in flutter app

develop

```sh
flutter run -d macos -a 2 -a 3
```

release

```sh
./login_flutter 2 3
```
