import 'package:auth_restfull/core/constants/constants.dart';
import 'package:auth_restfull/models/note.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoteController extends GetxController {
  final Dio dio = Dio();

  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  RxList<NoteModel> notes = <NoteModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getNotes(); // Fetch notes when the controller is initialized
  }

  Future<void> getNotes() async {
    try {
      final response = await dio.get('$baseUrl/notes');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        notes.assignAll(data.map((json) => NoteModel.fromJson(json)).toList());
      } else {
        throw "Failed to get notes: ${response.data['message'] ?? 'Unknown error'}";
      }
    } catch (e) {
      throw "Error getting notes: $e";
    }
  }

  Future<void> addNote() async {
    try {
      final String title = titleController.text;
      final String note = noteController.text;

      final response = await dio.post(
        '$baseUrl/notes',
        data: {'title': title, 'note': note},
      );

      if (response.statusCode == 201) {
        titleController.clear();
        noteController.clear();
        getNotes(); // Refresh the notes list after adding a new note
      } else {
        throw "Failed to add note: ${response.data['message'] ?? 'Unknown error'}";
      }
    } catch (e) {
      throw "Error adding note: $e";
    }
  }

  Future<void> updateNote({
    required String id,
    required String title,
    required String note,
  }) async {
    try {
      final response = await dio.put(
        '$baseUrl/notes/$id',
        data: {'title': title, 'note': note},
      );

      if (response.statusCode == 200) {
        getNotes(); // Refresh the notes list after updating a note
      } else {
        throw "Failed to update note: ${response.data['message'] ?? 'Unknown error'}";
      }
    } catch (e) {
      throw "Error updating note: $e";
    }
  }

  Future<void> deleteNote(String noteId) async {
    try {
      await dio.delete('$baseUrl/notes/$noteId');
      notes.removeWhere((note) => note.id == noteId);
      update(); // This will trigger a rebuild of the UI
    } catch (e) {
      throw "Error deleting note: $e";
    }
  }
}
