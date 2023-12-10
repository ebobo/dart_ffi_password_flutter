import 'dart:ffi' as ffi;
import 'package:ffi/ffi.dart';
import 'dart:io' show Platform;
import 'package:path/path.dart' as path;

typedef GetUserLevelC = ffi.Int32 Function(
    ffi.Pointer<Utf8> username, ffi.Pointer<Utf8> password);
typedef GetUserLevelDart = int Function(
    ffi.Pointer<Utf8> username, ffi.Pointer<Utf8> password);

class LoginService {
  int login(String name, String pass) {
    // Load the library
    // Determine the path based on the platform
    var libraryPath = '';
    if (Platform.isLinux) {
      libraryPath = 'lib/linux/libuserauth.so';
    } else if (Platform.isMacOS) {
      libraryPath = 'lib/macos/libuserauth.dylib';
    } else if (Platform.isWindows) {
      libraryPath = 'lib/windows/userauth.dll';
    } else {
      print('Unsupported platform');
      return 0;
    }

    try {
      final dylib = ffi.DynamicLibrary.open(libraryPath);

      // Look up the function
      final GetUserLevelDart getUserLevel = dylib
          .lookupFunction<GetUserLevelC, GetUserLevelDart>('get_user_level');

      // Call the function
      final username = name.toNativeUtf8();
      final password = pass.toNativeUtf8();
      final level = getUserLevel(username, password);

      // Free the memory
      calloc.free(username);
      calloc.free(password);
      return level;
    } catch (e) {
      print(e);
      return 0;
    }
  }
}

final loginService = LoginService();
