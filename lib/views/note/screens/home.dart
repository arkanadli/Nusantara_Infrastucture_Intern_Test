// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:auth_restfull/controllers/note_controller.dart';
import 'package:auth_restfull/core/constants/constants.dart';
import 'package:auth_restfull/models/note.dart';
import 'package:auth_restfull/views/auth/screens/signin_page.dart';
import 'package:auth_restfull/views/auth/screens/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/button_add_note.dart';
import '../widgets/display_notes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final NoteController noteController = Get.put(NoteController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        TextButton(
            onPressed: () async {
              final SharedPreferences prefs = await _prefs;
              prefs.clear();
              Get.offAll(() => const WelcomePage());
              // Show a SnackBar when the user logs out
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Successfully logged out'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: const Icon(
              Icons.logout,
              color: Colors.white,
            ))
      ]),
      floatingActionButton: ButtonAddNote(noteController: noteController),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: RefreshIndicator(
          onRefresh: () async {
            await noteController.getNotes();
          },
          child: Column(
            children: [
              const Text(
                'Catatan Ku',
                style: tBodyText2,
                textAlign: TextAlign.center,
              ),
              FutureBuilder(
                future: noteController.getNotes(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Card(
                              color: Colors.black,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                  snapshot.error.toString(),
                                  style: tBodyText,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  noteController.getNotes();
                                });
                              },
                              child: const Icon(
                                Icons.refresh,
                                color: Colors.white,
                                size: 40,
                              ),
                            ),
                            const Text(
                              'Tap to restart',
                              style: tBodyText,
                            )
                          ],
                        ),
                      ),
                    );
                  }
                  final listNotes = noteController.notes;

                  return DisplayNotes(noteController: noteController);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
