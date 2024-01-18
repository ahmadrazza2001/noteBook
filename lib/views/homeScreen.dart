// ignore_for_file: unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:umer_hotani/views/createNotesScreen.dart';
import 'package:umer_hotani/views/editNoteScreen.dart';
import 'package:umer_hotani/views/loginScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? userId = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My NoteBook"),
        actions: [
          GestureDetector(
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => const Login()));
              },
              child: Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10),
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("notes")
                  .where("userId", isEqualTo: userId?.uid)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text("Something went wrong!");
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CupertinoActivityIndicator());
                }
                if (snapshot.data!.docs.isEmpty) {
                  return Center(child: Text("No data found!"));
                }
                if (snapshot != null && snapshot.data != null) {
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        // var noteTitle = snapshot.data!.docs
                        return Card(
                          child: ListTile(
                            title:
                                Text(snapshot.data!.docs[index]['noteTitle']),
                            subtitle:
                                Text(snapshot.data!.docs[index]['userId']),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => EditNoteScreen(
                                          noteTitle: snapshot.data!.docs[index]
                                              ['noteTitle'],
                                          noteBody: snapshot.data!.docs[index]
                                              ['noteBody'],
                                          docId: snapshot.data!.docs[index].id,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Icon(Icons.edit),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                    onTap: () async {
                                      await FirebaseFirestore.instance
                                          .collection("notes")
                                          .doc(snapshot.data!.docs[index].id)
                                          .delete();
                                    },
                                    child: Icon(Icons.delete)),
                              ],
                            ),
                          ),
                        );
                      });
                }
                return Container();
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const CreateNotesScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
