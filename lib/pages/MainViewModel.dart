import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainViewModel extends ChangeNotifier{
  TextEditingController _textEditingController = TextEditingController();
  List<String> _notes = [];
  MainViewModel(){
    _loadNotes();
  }

  List<String> get notes => _notes;

  void _loadNotes() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _notes = prefs.getStringList('notes') ?? [];
    notifyListeners();
  }
  void _saveNotes() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('notes', _notes);
    notifyListeners();
  }

  void addNote(){
    String note = _textEditingController.text;
    if(note.isNotEmpty){
      _notes.add(note);
      _textEditingController.clear();
      _saveNotes();
    }
  }

  void deleteNote(int index){
      _notes.removeAt(index);
      _saveNotes();
  }

  void updateTextField(String text) {
    notifyListeners();
  }

  TextEditingController get textEditingController => _textEditingController;
}