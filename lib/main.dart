import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secand_in_firebase/bloc/bloc/images_bloc.dart';
import 'package:secand_in_firebase/bloc/states/crud_state.dart';
import 'package:secand_in_firebase/firebase/fb_notifications.dart';
import 'package:secand_in_firebase/images/upload_image.dart';
import 'package:secand_in_firebase/screens/app/add_note.dart';
import 'package:secand_in_firebase/images/images_screen.dart';
import 'package:secand_in_firebase/screens/app/launch_screen.dart';
import 'package:secand_in_firebase/screens/app/notes_screen.dart';
import 'package:secand_in_firebase/screens/app/user_screen.dart';
import 'package:secand_in_firebase/screens/auth/forget_password_screen.dart';
import 'package:secand_in_firebase/screens/auth/login_screen.dart';
import 'package:secand_in_firebase/screens/auth/register_screen.dart';
import 'package:secand_in_firebase/screens/auth/reset_password_screen.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FbNotifications.initNotifications();

  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ImagesBloc>(create: (context) => ImagesBloc(LoadingState()),),
      ],
      child: MaterialApp(
        initialRoute: '/lunch_screen',
        debugShowCheckedModeBanner: false,
        routes: {
          '/lunch_screen':(context)=>const LaunchScreen(),
          '/login_screen':(context)=>const LoginScreen(),
          '/register_screen':(context)=>const RegisterScreen(),
          '/forget_password_screen':(context)=>const ForgetPasswordScreen(),
          // '/reset_password_screen':(context)=>const ResetPasswordScreen(),
          '/user_screen':(context)=> const UserScreen(),
          '/notes_screen':(context)=> const NotesScreen(),
          '/add_screen':(context)=> const AddNote(),
          '/images_screen':(context)=> const ImagesScreen(),
          '/upload_images':(context)=> const UploadImage(),
        },
      ),
    );
  }
}
