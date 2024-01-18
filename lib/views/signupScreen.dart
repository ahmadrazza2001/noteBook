import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:umer_hotani/views/loginScreen.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Signup'),
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
                  controller: nameController,
                  decoration: const InputDecoration(
                      hintText: 'Name', enabledBorder: OutlineInputBorder()),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                      hintText: 'Phone', enabledBorder: OutlineInputBorder()),
                ),
              ),
              const SizedBox(
                height: 10,
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
                  var name = nameController.text.trim();
                  var phone = phoneController.text.trim();
                  var email = emailController.text.trim();
                  var password = passwordController.text.trim();
                  await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: email, password: password)
                      .then((value) => {
                            FirebaseFirestore.instance
                                .collection("users")
                                .doc(currentUser!.uid)
                                .set({
                              'name': name,
                              'phone': phone,
                              'email': email,
                              'createdAt': DateTime.now(),
                              'userId': currentUser!.uid
                            })
                          });
                  await Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => const Login()));
                },
                child: const Text("Signup"),
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const Login()));
                },
                child: Container(
                  child: Card(child: Text("Already have an account? Login")),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
