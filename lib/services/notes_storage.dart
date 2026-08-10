import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/note.dart';

class NotesStorage {
  static const String _key = 'notes_list';

  // Read all notes
  Future<List<Note>> getNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString(_key);
    if (data == null || data.isEmpty) return [];
    final List<dynamic> decoded = jsonDecode(data);
    return decoded.map((e) => Note.fromJson(e)).toList()
      ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
  }

  // Save the entire notes list (private helper used by add/update/delete)
  Future<void> _saveNotes(List<Note> notes) async {
    final prefs = await SharedPreferences.getInstance();
    final String encoded =
        jsonEncode(notes.map((n) => n.toJson()).toList());
    await prefs.setString(_key, encoded);
  }

  // Add a new note
  Future<void> addNote(Note note) async {
    final notes = await getNotes();
    notes.add(note);
    await _saveNotes(notes);
  }

  // Edit / update an existing note
  Future<void> updateNote(Note updatedNote) async {
    final notes = await getNotes();
    final index = notes.indexWhere((n) => n.id == updatedNote.id);
    if (index != -1) {
      notes[index] = updatedNote;
      await _saveNotes(notes);
    }
  }

  // Delete a note by id
  Future<void> deleteNote(String id) async {
    final notes = await getNotes();
    notes.removeWhere((n) => n.id == id);
    await _saveNotes(notes);
  }

  // Optional: clear all notes
  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
