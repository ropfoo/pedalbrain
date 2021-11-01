import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pedalbrain/modules/board/board.dart';
import 'package:pedalbrain/services/get_user.dart';

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
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: const Text('Pedalbrain'),
          ),
          body: FutureBuilder(
            future: _initialization,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text("INIT: ${snapshot.error.toString()}");
              }

              // Once complete, show your application
              if (snapshot.connectionState == ConnectionState.done) {
                return Column(
                  children: [
                    GetUser(),
                    // Board(),
                  ],
                );
              }

              return const Text('lel');
            },
          )),
    );
  }
}
