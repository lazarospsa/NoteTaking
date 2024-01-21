import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lara_fl/providers/auth.dart';
import 'package:lara_fl/screen/home.dart';
import 'package:lara_fl/screen/login_screen.dart';
import 'package:lara_fl/screen/onboarding_screen/onboarding.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: ((context) => Auth()),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
// class MyApp extends StatelessWidget {
//   final storage = FlutterSecureStorage();

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Your App',
//       home: FutureBuilder<bool>(
//         future: checkAuthenticationStatus(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             if (snapshot.data == true) {
//               // User is authenticated, show the home screen
//               return HomePage();
//             } else {
//               // User is not authenticated, show the login screen
//               return LoginScreen();
//             }
//           } else {
//             // Still checking authentication status, show a loading indicator or splash screen
//             return CircularProgressIndicator();
//           }
//         },
//       ),
//     );
//   }

//   Future<bool> checkAuthenticationStatus() async {
//     final token = await storage.read(key: 'auth');
//     // Check if the token is not null or empty
//     return token != null && token.isNotEmpty;
//   }
// }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final storage = FlutterSecureStorage();

  void _attemptAuthentication() async {
    String? key = await storage.read(key: 'auth');
    // ignore: use_build_context_synchronously
    Provider.of<Auth>(context, listen: false).attempt(key);
  }

  @override
  void initState() {
    super.initState();
    _attemptAuthentication();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer<Auth>(
          builder: (context, value, child) {
            if (value.authenticated) {
              return Home();
            } else {
              return OnboardingScreen();
            }
          },
        ),
      ),
    );
  }
}
