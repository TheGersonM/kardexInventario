import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_auth_buttons/res/buttons/google_auth_button.dart';



Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

class Home_Page extends StatefulWidget {
   Home_Page({
    super.key,
  });
  bool visible = false;
  @override
  State<Home_Page> createState() => _HomePageState();
}

class _HomePageState extends State<Home_Page> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio de sesión', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ), body:    StreamBuilder(
        stream: null,
        builder: (context, snapshot) {
          return Center(child: 
          Padding(
            padding: const EdgeInsets.all(48.0),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 60,
                      child: Icon(Icons.person, size: 60, color: Colors.white),
                    ),
                    const SizedBox(height: 70),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Correo',
                        icon: Icon(Icons.email),
                      ),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Contraseña',
                        icon: Icon(Icons.lock),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, 'start');
                      },
                      child: const Text('Iniciar sesión', style: TextStyle(fontSize: 20, color: Colors.blue)),
                    ),
                
                
                    const SizedBox(height: 60),
                
                    Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: GoogleAuthButton(
                        darkMode: true,
                        onPressed: () async {
                          await signInWithGoogle();
                          if (FirebaseAuth.instance.currentUser != null) {
                            Navigator.pushReplacementNamed(context, 'start');
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
              );
        }
      )
    );
  }
}
