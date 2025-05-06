import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/character.dart';
import '../providers/character_provider.dart';
import 'references/character_list.dart';
import 'widgets/char_selection_screen_bg.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CharacterProvider(),
      child: MaterialApp(home: CharacterSelectionScreen()),
    ),
  );
}

class CharacterSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final selectedCharacter =
        context.watch<CharacterProvider>().selectedCharacter;

    return Scaffold(
      appBar: AppBar(title: Text('Character Selector')),
      body: Column(
        children: [
          // Some background or header widget
          Container(
            height: 50,
            color: Colors.blueAccent,
            child: Center(
              child: Text('Choose Your Character!', style: TextStyle(color: Colors.white)),
            ),
          ),
          // Your core widget is here
          Expanded(
            child: CharacterGrid(characters: characters),
          ),
          if (selectedCharacter != null)
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Selected: ${selectedCharacter.specialty}\n${selectedCharacter.characteristics}',
                style: TextStyle(fontSize: 16),
              ),
            ),
        ],
      ),
    );
  }
}

class CharacterGrid extends StatelessWidget {
  final List<Character> characters;

  CharacterGrid({required this.characters});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: characters.length,
      itemBuilder: (context, index) {
        final character = characters[index];
        return GestureDetector(
          onTap: () {
            // Save the selected character in provider
            context.read<CharacterProvider>().selectCharacter(character);
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Image.asset(character.imagePath, fit: BoxFit.cover),
          ),
        );
      },
    );
  }
}