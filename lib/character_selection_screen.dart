import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Character model
class Character {
  final int id;
  final String specialty;
  final String imagePath;
  final String characteristics;

  Character({
    required this.id,
    required this.specialty,
    required this.imagePath,
    required this.characteristics,
  });
}

// CharacterProvider
class CharacterProvider extends ChangeNotifier {
  // Initialize with some characters
  final List<Character> characters = [
    Character(
      id: 1,
      specialty: 'Assassin',
      imagePath: 'assets/characters/1.jpeg',
      characteristics: 'Stealthy and deadly, striking from the shadows.',
    ),
    Character(
      id: 2,
      specialty: 'Assassin',
      imagePath: 'assets/characters/2.png',
      characteristics: 'Stealthy and deadly, striking from the shadows.',
    ),
    Character(
      id: 3,
      specialty: 'Knight',
      imagePath: 'assets/characters/3.png',
      characteristics: 'Honorable warrior, protector of the realm.',
    ),
    Character(
      id: 4,
      specialty: 'Knight',
      imagePath: 'assets/characters/4.png',
      characteristics: 'Honorable warrior, protector of the realm.',
    ),
    Character(
      id: 5,
      specialty: 'Mage',
      imagePath: 'assets/characters/5.png',
      characteristics: 'Master of the arcane, wielding powerful spells.',
    ),
    Character(
      id: 6,
      specialty: 'Mage',
      imagePath: 'assets/characters/6.png',
      characteristics: 'Master of the arcane, wielding powerful spells.',
    ),
    Character(
      id: 7,
      specialty: 'Siren',
      imagePath: 'assets/characters/7.png',
      characteristics: 'Enchanting being who lure and beguile with her songs.',
    ),
    Character(
      id: 8,
      specialty: 'Siren',
      imagePath: 'assets/characters/8.png',
      characteristics: 'Enchanting being who lure and beguile with his songs.',
    ),
    Character(
      id: 9,
      specialty: 'Fairy',
      imagePath: 'assets/characters/9.png',
      characteristics:
          'Mischievous and playful, often granting wishes or causing trouble.',
    ),
    Character(
      id: 10,
      specialty: 'Fairy',
      imagePath: 'assets/characters/10.png',
      characteristics:
          'Mischievous and playful, often granting wishes or causing trouble.',
    ),
    Character(
      id: 11,
      specialty: 'Necromancer',
      imagePath: 'assets/characters/11.png',
      characteristics: 'Commander of the undead, master of dark arts.',
    ),
    Character(
      id: 12,
      specialty: 'Necromancer',
      imagePath: 'assets/characters/12.png',
      characteristics: 'Commander of the undead, master of dark arts.',
    ),
    Character(
      id: 13,
      specialty: 'Dragon',
      imagePath: 'assets/characters/13.png',
      characteristics:
          'Majestic and powerful, hoarding treasure and guarding ancient secrets.',
    ),
    Character(
      id: 14,
      specialty: 'Dragon',
      imagePath: 'assets/characters/14.png',
      characteristics:
          'Majestic and powerful, hoarding treasure and guarding ancient secrets.',
    ),
    Character(
      id: 15,
      specialty: 'Shapeshifter',
      imagePath: 'assets/characters/15.png',
      characteristics: 'Master of disguise, able to take on any form.',
    ),
    Character(
      id: 16,
      specialty: 'Shapeshifter',
      imagePath: 'assets/characters/16.png',
      characteristics: 'Master of disguise, able to take on any form.',
    ),
  ];

  Character? selectedCharacter;

  void selectCharacter(Character character) {
    selectedCharacter = character;
    notifyListeners();
  }
}

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
    final characters = context.watch<CharacterProvider>().characters;
    final selectedCharacter =
        context.watch<CharacterProvider>().selectedCharacter;

    return Scaffold(
      body: Stack(
        children: [
          CharSelectionScreenBg(),
          Positioned(top: 40, left: 8, right: 8, child: WarriorCard()),
          Positioned(
            top: 40 + 152,
            left: 8,
            right: 8,
            child: CharacterGrid(characters: characters),
          ),
          Positioned(
            top: 40 + 152 + 392,
            left: 8,
            right: 8,
            child: CharacterViewCard(),
          ),

          if (selectedCharacter != null)
            Positioned(bottom: 20, left: 20, right: 20, child: CharacterView()),
        ],
      ),
    );
  }
}

class WarriorCard extends StatelessWidget {
  const WarriorCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset('assets/character_card.jpg', fit: BoxFit.fitWidth),
      ),
    );
  }
}

class CharSelectionScreenBg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/profile_screen_setup_bg.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class CharacterGrid extends StatelessWidget {
  final List<Character> characters;

  CharacterGrid({required this.characters});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 415,
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'assets/character_group_card.jpg',
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        Positioned(
          top: 70,
          left: 40,
          right: 40,
          child: SizedBox(
            height: 300,
            child: GridView.builder(
              padding: EdgeInsets.all(8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 15,
                mainAxisSpacing: 9,
              ),
              itemCount: characters.length,
              itemBuilder: (context, index) {
                final character = characters[index];
                return GestureDetector(
                  onTap: () {
                    // Save the selected character in provider
                    context.read<CharacterProvider>().selectCharacter(
                      character,
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 237, 103, 30),
                        width: 3,
                      ),
                    ),
                    child: Image.asset(character.imagePath, fit: BoxFit.cover),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class CharacterViewCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          'assets/character_description_card.jpg',
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}

class CharacterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final selectedCharacter =
        context.watch<CharacterProvider>().selectedCharacter;

    if (selectedCharacter == null) {
      return Container(
        padding: const EdgeInsets.all(8),
        child: Text(
          'No character selected.',
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    return Stack(
      children: [
        Positioned(
          top: 10,
          left: 10,
          child: Container(
            height: 170,
            width: 170,
            padding: const EdgeInsets.all(16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                selectedCharacter.imagePath,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
