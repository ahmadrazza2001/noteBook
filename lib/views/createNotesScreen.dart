// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:umer_hotani/views/homeScreen.dart';

class CreateNotesScreen extends StatefulWidget {
  const CreateNotesScreen({super.key});

  @override
  State<CreateNotesScreen> createState() => _CreateNotesScreenState();
}

class _CreateNotesScreenState extends State<CreateNotesScreen> {
  TextEditingController noteTitle = TextEditingController();
  TextEditingController noteBody = TextEditingController();

  User? userId = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Notes"),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              child: TextFormField(
                controller: noteTitle,
                maxLines: 1,
                decoration: InputDecoration(hintText: "Title here"),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              child: TextFormField(
                controller: noteBody,
                maxLines: null,
                decoration: InputDecoration(hintText: "Write from here.."),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
                onPressed: () async {
                  var noteTitleText = noteTitle.text.trim();
                  var noteBodyText = noteBody.text.trim();

                  if (noteTitleText != "" && noteBodyText != "") {
                    try {
                      await FirebaseFirestore.instance
                          .collection("notes")
                          .doc()
                          .set({
                        'noteTitle': noteTitleText,
                        'noteBody': noteBodyText,
                        'createdAt': DateTime.now(),
                        'userId': userId?.uid
                      }).then((value) => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const HomeScreen())));
                    } catch (e) {
                      print("Error: $e");
                    }
                  } else {
                    print('Note Title or Body cannot be NULL');
                  }
                },
                child: Text("Add to notes"))
          ],
        ),
      ),
    );
  }
}
