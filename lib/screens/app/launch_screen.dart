import 'package:flutter/material.dart';
import 'package:secand_in_firebase/firebase/fb_auth_controller.dart';
class LaunchScreen extends StatefulWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 3),(){
      String route=FbAuthController().signedIn? '/notes_screen':'/login_screen';
      Navigator.pushReplacementNamed(context, route);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.pink.shade100,
              Colors.blue.shade100
            ],
          )
        ),
        child: const Text('Firebase Training',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.redAccent),),
      ),
    );
  }
}
