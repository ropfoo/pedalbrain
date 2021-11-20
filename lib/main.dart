import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pedalbrain/screens/pedal_list_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pedalbrain',
      theme: ThemeData(
        brightness: Brightness.dark,
        textTheme: const TextTheme(
          headline1: TextStyle(
            fontSize: 45.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          headline4: TextStyle(
            fontSize: 24.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: Scaffold(
        backgroundColor: Colors.black87,
        appBar: AppBar(
          backgroundColor: const Color(0xFF05001A),
        ),
        body: FutureBuilder(
          future: _initialization,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("INIT: ${snapshot.error.toString()}");
            }

            // Once complete, show your application
            if (snapshot.connectionState == ConnectionState.done) {
              return const PedalListScreen();
            }

            return const Text('loading');
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'test',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'test',
            ),
          ],
        ),
      ),
    );
  }
}
