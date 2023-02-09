import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:my_chat_app/screens/auth_screen.dart';
import 'package:my_chat_app/screens/chat_screen.dart';


void main()async{
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());

}

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   debugPrint("Firebase Messaging firebase is initialized");
//   await Firebase.initializeApp();
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    
     return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, appSnapshot) {
        return MaterialApp(
      title: 'FlutterChat',
      theme: ThemeData( 
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Colors.pink,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
        ),
        primarySwatch: Colors.pink,
        backgroundColor: Colors.pink,
        colorScheme: ColorScheme.light(
          secondary: Colors.deepPurple,
          primary: Colors.pink,
         // brightness: Brightness.dark,
          
          
        )
      ),
      home: StreamBuilder( stream: FirebaseAuth.instance.authStateChanges() , builder: (context,userSnapshot){
        if(userSnapshot.hasData){
          return ChatScreen();
        }
        return AuthScreen();
      } ),
    );

      });

    
  }
}
