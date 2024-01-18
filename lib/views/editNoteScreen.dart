import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:umer_hotani/views/homeScreen.dart';

class EditNoteScreen extends StatefulWidget {
  final String noteTitle;
  final String noteBody;
  final String docId;

  const EditNoteScreen({
    required this.noteTitle,
    required this.noteBody,
    required this.docId,
    Key? key,
  }) : super(key: key);

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  TextEditingController noteTitleController = TextEditingController();
  TextEditingController noteBodyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    noteTitleController.text = widget.noteTitle;
    noteBodyController.text = widget.noteBody;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Note"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: noteTitleController,
              decoration: InputDecoration(labelText: 'Note Title'),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: noteBodyController,
              decoration: InputDecoration(labelText: 'Note Body'),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection("notes")
                    .doc(widget.docId)
                    .update({
                  'noteTitle': noteTitleController.text.trim(),
                  'noteBody': noteBodyController.text.trim(),
                }).then((value) => Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => const HomeScreen())));
              },
              child: Text("Update"),
            )
          ],
        ),
      ),
    );
  }
}
