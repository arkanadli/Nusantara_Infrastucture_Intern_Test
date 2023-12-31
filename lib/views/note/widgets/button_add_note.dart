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
        showDialog(
            context: context,
            builder: (context) {
              noteController.titleController.text = '';
              noteController.noteController.text = '';
              return AlertDialog(
                title: const Text('Add Note'),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: double.maxFinite,
                      child: TextField(
                        controller: noteController.titleController,
                        decoration: const InputDecoration(labelText: 'Title'),
                      ),
                    ),
                    SizedBox(
                      width: double.maxFinite,
                      child: TextField(
                        controller: noteController.noteController,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration(labelText: 'Note'),
                      ),
                    ),
                  ],
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      noteController.addNote();
                      Navigator.of(context).pop();
                    },
                    child: const Text('Add'),
                  ),
                ],
              );
            });
      },
      child: const Icon(Icons.add),
    );
  }
}
