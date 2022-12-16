import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanalira_test/cores/firebase_services/authentication_service.dart';
import 'package:sanalira_test/features/authentication_pages/authentication_control.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return Provider<AuthenticationService>(
          create: (_) => AuthenticationService(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Sanalira',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: AuthenticationControl(),
          ),
        );
      },
    );
  }
}
