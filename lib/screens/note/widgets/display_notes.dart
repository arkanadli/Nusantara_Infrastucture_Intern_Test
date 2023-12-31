// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:auth_restfull/controllers/note_controller.dart';
import 'package:auth_restfull/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DisplayNotes extends StatelessWidget {
  const DisplayNotes({
    super.key,
    required this.noteController,
  });

  final NoteController noteController;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final listNotes = noteController.notes;
      return Flexible(
        child: ListView.builder(
          itemCount: listNotes.length,
          itemBuilder: (context, index) {
            final note = listNotes[index];

            return Card(
              color: Colors.amber[200],
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(
                    note.title,
                    style: tNotesTextTitle,
                  ),
                  subtitle: Text(
                    note.note,
                    style: tNotesTextBody,
                  ),
                  onTap: () {
                    // Show a dialog for editing
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        noteController.titleController.text = note.title;
                        noteController.noteController.text = note.note;
                        return AlertDialog(
                          title: const Text('Edit Note'),
                          content: Column(
                            children: [
                              SizedBox(
                                width: double
                                    .maxFinite, // Make the text field wider
                                child: TextField(
                                  controller: noteController.titleController,
                                  decoration:
                                      const InputDecoration(labelText: 'Title'),
                                ),
                              ),
                              SizedBox(
                                width: double
                                    .maxFinite, // Make the text field wider
                                child: TextField(
                                  controller: noteController.noteController,
                                  maxLines: null, // Allow multiple lines
                                  keyboardType: TextInputType.multiline,
                                  decoration:
                                      const InputDecoration(labelText: 'Note'),
                                ),
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                // Implement updateNote functionality
                                noteController.updateNote(
                                  id: note.id,
                                  title: noteController.titleController.text,
                                  note: noteController.noteController.text,
                                );
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              child: const Text('Update'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      // Show a confirmation dialog for deletion
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Delete Note'),
                            content: const Text(
                                'Are you sure you want to delete this note?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                },
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  // Implement deleteNote functionality
                                  noteController.deleteNote(note.id);
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                },
                                child: const Text('Delete'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
