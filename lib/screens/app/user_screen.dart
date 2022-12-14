import 'package:flutter/material.dart';
import 'package:secand_in_firebase/firebase/fb_auth_controller.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Screen'),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text('Are you sour? '),
                      actions: [
                        TextButton(onPressed: (){
                          FbAuthController().signOut();
                          Navigator.pushReplacementNamed(context, '/login_screen');
                        }, child: Text('Yas')),
                        TextButton(onPressed: (){Navigator.pop(context);}, child: Text('No')),
                      ],
                    );
                  },
                );
              },
              icon: Icon(Icons.logout))
        ],
      ),
    );
  }
}
