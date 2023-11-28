import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:imagine_swe/screens/auth.dart';
import 'package:imagine_swe/screens/home.dart';
import 'package:imagine_swe/screens/loading.dart';
import 'firebase_options.dart';

import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Imagine',
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme:
            ColorScheme.fromSeed(seedColor: const Color.fromARGB(0, 0, 3, 7)),
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingScreen(); //Loading.
          }

          if (snapshot.hasData) {
            //Logged in
            return const HomeScreen();
          }
          //Logged out
          return const AuthScreen();
        },
      ),
    );
  }
}
