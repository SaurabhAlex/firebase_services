import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_services/view/screens/sign_in_with_phone.dart';
import 'package:firebase_services/view/screens/sign_up.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> getInitialMessage() async {
    RemoteMessage? message =
        await FirebaseMessaging.instance.getInitialMessage();
    if (message != null) {
      if (message.data["page"] == "email") {
        Navigator.push(
            context, CupertinoPageRoute(builder: (context) => SignUp()));
      } else if (message.data["page"] == "phone") {
        Navigator.push(context,
            CupertinoPageRoute(builder: (context) => SignInWithPhone()));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid page'),
          duration: Duration(seconds: 5),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void initState() {
    getInitialMessage();
    FirebaseMessaging.onMessage.listen((message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message.data['name'].toString()),
          duration: Duration(seconds: 12),
          backgroundColor: Colors.green,
        ),
      );
      log("Notification received! ${message.notification!.title}");
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message.notification!.title.toString()),
          duration: Duration(seconds: 12),
          backgroundColor: Colors.green,
        ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
