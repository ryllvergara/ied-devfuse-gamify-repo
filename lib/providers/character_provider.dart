import 'package:flutter/material.dart';
import '../models/character.dart';

class CharacterProvider extends ChangeNotifier {
  Character? _selectedCharacter;

  Character? get selectedCharacter => _selectedCharacter;

  void selectCharacter(Character character) {
    _selectedCharacter = character;
    notifyListeners();
  }
}
