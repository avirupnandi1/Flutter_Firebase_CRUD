import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: ((context, snapshot) {
        if (snapshot.hasError) {
          print("something went wrong");
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'Firebase CRUD',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: MyHomePage(),
          );
        }
        return CircularProgressIndicator();
      }),
    );
  }
}
