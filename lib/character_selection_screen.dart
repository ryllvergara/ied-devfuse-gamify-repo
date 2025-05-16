import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_screen.dart';

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
  const CharacterSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final characters = context.watch<CharacterProvider>().characters;
    final selectedCharacter = context.watch<CharacterProvider>().selectedCharacter;

    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          const CharSelectionScreenBg(),
          Positioned(
            top: screenHeight * 0.03,
            left: 8,
            right: 8,
            child: const WarriorCard(),
          ),
          Positioned(
            top: screenHeight * 0.22,
            left: 8,
            right: 8,
            child: CharacterGrid(characters: characters),
          ),
          Positioned(
            top: screenHeight * 0.67,
            left: 8,
            right: 8,
            child: const CharacterViewCard(),
          ),
          if (selectedCharacter != null)
            CharacterView(screenHeight: screenHeight),
          Positioned(
            bottom: screenHeight * 0.05,
            left: 0,
            right: 0,
            child: const Center(child: StartButton()),
          ),
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
  const CharSelectionScreenBg({super.key});
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

  const CharacterGrid({super.key, required this.characters});

  @override
  Widget build(BuildContext context) {
    final selectedCharacterId = context.watch<CharacterProvider>().selectedCharacter?.id;

    return Stack(
      children: [
        Container(
          height: 415,
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset('assets/character_group_card.jpg', fit: BoxFit.fitWidth),
          ),
        ),
        const Positioned(
          top: 40,
          left: 0,
          right: 0,
          child: Center(
            child: Text(
              'CHOOSE YOUR WARRIOR!',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'Times New Romance',
              ),
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
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 15,
                mainAxisSpacing: 9,
              ),
              itemCount: characters.length,
              itemBuilder: (context, index) {
                final character = characters[index];
                final isSelected = character.id == selectedCharacterId;

                return GestureDetector(
                  onTap: () => context.read<CharacterProvider>().selectCharacter(character),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isSelected ? Colors.green : Colors.orange,
                        width: 3,
                      ),
                    ),
                    child: Image.asset(
                      character.imagePath,
                      fit: BoxFit.cover,
                      frameBuilder: (context, child, frame, _) {
                        if (frame == null) return const Center(child: CircularProgressIndicator());
                        return child;
                      },
                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                    ),
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
  const CharacterViewCard({super.key});
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
  final double screenHeight;

  const CharacterView({super.key, required this.screenHeight});

  @override
  Widget build(BuildContext context) {
    final selectedCharacter = context.watch<CharacterProvider>().selectedCharacter;
    if (selectedCharacter == null) return const SizedBox.shrink();

    return Stack(
      children: [
        Positioned(
          top: screenHeight * 0.76,
          left: 35,
          child: SizedBox(
            height: 120,
            width: 120,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                selectedCharacter.imagePath,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
        ),
        Positioned(
          top: screenHeight * 0.76,
          left: 160,
          child: Text(
            'Specialty: ${selectedCharacter.specialty}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.bold,
              fontFamily: 'Times New Romance',
            ),
          ),
        ),
        Positioned(
          top: screenHeight * 0.80,
          left: 160,
          child: const Text(
            'Characteristics:',
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.bold,
              fontFamily: 'Times New Romance',
            ),
          ),
        ),
        Positioned(
          top: screenHeight * 0.83,
          left: 160,
          right: 16,
          child: SingleChildScrollView(
            child: Text(
              selectedCharacter.characteristics,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold,
                fontFamily: 'Times New Romance',
              ),
            ),
          ),
        ),
      ],
    );
  }
}


class StartButton extends StatelessWidget {
  const StartButton({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedCharacter = context.read<CharacterProvider>().selectedCharacter;

    return ElevatedButton(
      onPressed: () {
        if (selectedCharacter != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please select a character first!')),
          );
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 183, 102, 58),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 10,
      ),
      child: const Text(
        'Start!',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: 'Times New Romance',
        ),
      ),
    );
  }
}

