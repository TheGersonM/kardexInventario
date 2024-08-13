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

class HomePage extends StatefulWidget {
   const HomePage({
    super.key,
  });
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
       body:    StreamBuilder(
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
                      backgroundColor: Colors.white,
                      radius: 60,
                      child: Icon(Icons.person, size: 60, color: Colors.blue),
                    ),
                    const SizedBox(height: 70),
                    TextFormField(
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        disabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        labelText: 'Correo',
                        labelStyle: TextStyle(color: Colors.white, fontSize: 20),
                        icon: Icon(Icons.email, color: Colors.white),
                      ),
                    ),
                    TextFormField(
                      obscureText: true,
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                      decoration: const InputDecoration(
                        
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        disabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        labelText: 'Contraseña',
                        labelStyle: TextStyle(color: Colors.white, fontSize: 20),
                        icon: Icon(Icons.lock, color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        minimumSize: const Size(200, 50),
                      ),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, 'start');
                      },
                      child: const Text('Iniciar sesión', style: TextStyle(fontSize: 20, color: Colors.blue)),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        
                        backgroundColor:const  Color.fromARGB(255, 43, 194, 192),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          
                        ),
                        minimumSize: const Size(150, 50),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, 'register');
                      },
                      child: const Text('Registrarme', style: TextStyle(fontSize: 20, color: Colors.white)),
                    ),
                
                
                    const SizedBox(height: 60),
                
                    Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: GoogleAuthButton(
                        darkMode: false,
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
