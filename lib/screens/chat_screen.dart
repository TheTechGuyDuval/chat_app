import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_chat_app/widget/chat/messages.dart';
import 'package:my_chat_app/widget/chat/new_messages.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  //ask permissions fo ios push notifications
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  final fbm = FirebaseMessaging.instance;
  fbm.requestPermission();
  //any notification sent to this topic reaches devices
  fbm.subscribeToTopic('chat');
  fbm.getInitialMessage().then((RemoteMessage? message) {
     if (message != null) {
      print(message);
       
      }

  });
//foreground
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //  RemoteNotification notification = message.notification!;
    // AndroidNotification android = message.notification!.android!;
    // if(notification != null && android != null){
      
    // }
    print(message);
    return;
   });
// background
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      return;
      
    });
  // background or terminated
  //  FirebaseMessaging.onBackgroundMessage((RemoteMessage message) {
  //   print(message);
  //   return;
  // });
  
  
  
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyChatApp'),
        actions: [
          DropdownButton(
            items: [
              DropdownMenuItem(
                  child: Row(
                children: [
                  Icon(Icons.exit_to_app),
                  SizedBox(
                    width: 8,
                  ),
                  Text('Log Out')
                ],
              ))
            ],
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            onChanged: (val) {
              if (val == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
            value: 'logout',
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Messages(),
            ),
            NewMessage()
          ],
        ),
      ),
      
    );
  }
}
