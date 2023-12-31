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
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        noteController.titleController.text = note.title;
                        noteController.noteController.text = note.note;
                        return AlertDialog(
                          title: Text(noteController.titleController.text),
                          content: SizedBox(
                            height: 200,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: double.maxFinite,
                                    child: TextField(
                                      controller:
                                          noteController.titleController,
                                      decoration: const InputDecoration(
                                          labelText: 'Title'),
                                    ),
                                  ),
                                  SizedBox(
                                    width: double.maxFinite,
                                    child: TextField(
                                      controller: noteController.noteController,
                                      maxLines: null,
                                      keyboardType: TextInputType.multiline,
                                      decoration: const InputDecoration(
                                          labelText: 'Note'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                noteController.updateNote(
                                  id: note.id,
                                  title: noteController.titleController.text,
                                  note: noteController.noteController.text,
                                );
                                Navigator.of(context).pop();
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
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  noteController.deleteNote(note.id);
                                  Navigator.of(context).pop();
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
