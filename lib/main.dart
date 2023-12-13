import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import 'package:login_flutter/widgets/colors.dart';
import 'package:login_flutter/widgets/parameters.dart';
import 'package:login_flutter/service/user_auth.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  // Must add this line.

  print(args);

  await windowManager.ensureInitialized();
  WindowOptions windowOptions = const WindowOptions(
    size: AppParameters.windowSize,
    maximumSize: AppParameters.windowSize,
    minimumSize: AppParameters.windowSize,
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login',
      home: LoginPage(title: 'AutroMaster Login'),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Define TextEditingController for username and password
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscureText = true;
  int _level = 0;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _login() {
    String username = _userController.text;
    String password = _passwordController.text;
    // Load the library
    int level = loginService.login(username, password);

    setState(() {
      _level = level;
    });

    print('User level: $level');
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: AppColors.cardBackgroundWhite,
      appBar: AppBar(
          // TRY THIS: Try changing the color here to a specific color (to
          // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
          // change color while the other colors stay the same.
          backgroundColor: AppColors.topbarGrey,
          centerTitle: true, // This is needed to center the title

          title: GestureDetector(
            onPanUpdate: (details) {
              windowManager.startDragging();
            },
            child: Image.asset('assets/images/autronica_logo_dark.png',
                height: 32),
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
          )),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20.0),
            const Text(
              'User',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textGray),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: TextFormField(
                controller: _userController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: UnderlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 20),
              child: TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: const UnderlineInputBorder(),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: AppColors.textGray,
                        size: 20.0,
                      ),
                      onPressed: _togglePasswordVisibility,
                    ),
                  ),
                ),
                obscureText: _obscureText,
              ),
            ),
            const SizedBox(height: 20.0),
            // ElevatedButton(
            //   style: ElevatedButton.styleFrom(
            //     minimumSize: const Size(100, 45),
            //     backgroundColor: AppColors.buttonGrey,
            //     foregroundColor: Colors.white,
            //     shape: const RoundedRectangleBorder(
            //       borderRadius: BorderRadius.all(Radius.circular(10)),
            //     ),
            //   ),
            //   child: const Text('Sign in'),
            //   onPressed: () {
            //     // Implement sign-in logic
            //   },
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    minimumSize: const Size(180, 45),
                    backgroundColor:
                        Colors.red, // Change this to your desired color
                    foregroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  child: const Text("I'm panic, let me in !"),
                  onPressed: () {
                    // Implement panic logic
                  },
                ),
                const SizedBox(width: 50.0),
                TextButton(
                  style: TextButton.styleFrom(
                    minimumSize: const Size(100, 45),
                    backgroundColor: AppColors.buttonGrey,
                    foregroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  onPressed: _login,
                  child: const Text('Sign in'),
                ),
              ],
            ),
            const SizedBox(height: 40.0),
            const Divider(color: AppColors.topbarGrey),
            // Add a divider
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.account_circle,
                    color: AppColors.textGray,
                    size: 28,
                  ),
                  const SizedBox(width: 10), // Add a user icon
                  const Text(
                    'Manage account',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 15.0, color: AppColors.textGray),
                  ),
                  const SizedBox(width: 10),
                  Text('level: ${_level.toString()}',
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          fontSize: 15.0, color: AppColors.textGray))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose controllers when the widget is disposed
    _userController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
