import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dogwalker/app_widget.dart';

Future<void> main() async {
  await dotenv.load(fileName: "assets/.env");
  runApp(AppFirebase());
}

class AppFirebase extends StatefulWidget {
  @override
  _AppFirebaseState createState() => _AppFirebaseState();
}

class _AppFirebaseState extends State<AppFirebase> {
  final Future<FirebaseApp> _inicialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _inicialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Material(
            child: Center(
              child: Text(
                "Não foi possível inicializar o Firebase",
                textDirection: TextDirection.ltr,
              ),
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          return AppWdiget();
        } else {
          return Material(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
