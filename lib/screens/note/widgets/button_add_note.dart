// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:auth_restfull/controllers/note_controller.dart';
import 'package:flutter/material.dart';

class ButtonAddNote extends StatelessWidget {
  const ButtonAddNote({
    super.key,
    required this.noteController,
  });

  final NoteController noteController;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        // Show a dialog or navigate to a new screen for adding a note
        // For simplicity, I'll show a dialog here
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Add Note'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: double.maxFinite, // Make the text field wider
                  child: TextField(
                    controller: noteController.titleController,
                    decoration: const InputDecoration(labelText: 'Title'),
                  ),
                ),
                SizedBox(
                  width: double.maxFinite, // Make the text field wider
                  child: TextField(
                    controller: noteController.noteController,
                    maxLines: null, // Allow multiple lines
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(labelText: 'Note'),
                  ),
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Add the note using your NoteController
                  noteController.addNote();
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text('Add'),
              ),
            ],
          ),
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
