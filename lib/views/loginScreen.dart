// ignore_for_file: unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:umer_hotani/views/homeScreen.dart';
import 'package:umer_hotani/views/signupScreen.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                child: Image.asset("img1.png"),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                      hintText: 'Email', enabledBorder: OutlineInputBorder()),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                      hintText: 'Password',
                      enabledBorder: OutlineInputBorder()),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () async {
                  var loginEmail = emailController.text.trim();
                  var loginPassword = passwordController.text.trim();
                  try {
                    final User? firebaseUser = (await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: loginEmail, password: loginPassword))
                        .user;
                    if (firebaseUser != null) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const HomeScreen()));
                    } else {
                      print("Wrong Email or Password!");
                    }
                  } on FirebaseAuthException catch (e) {
                    print("Error: $e");
                  }
                },
                child: const Text("Login"),
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const Signup()));
                },
                child: Container(
                  child: Card(child: Text("Don't have an account? Create one")),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
