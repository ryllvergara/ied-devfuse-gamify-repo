import 'package:flutter/material.dart';
import 'package:gamify/add_reward_screen.dart';
import 'package:gamify/bottom_nav_bar.dart';
import 'package:intl/intl.dart';

class RewardScreen extends StatefulWidget {
  const RewardScreen({super.key});

  @override
  State<RewardScreen> createState() => _RewardScreenState();
}

class _RewardScreenState extends State<RewardScreen> {
  int currentXP = 1563;
  int maxXP = 8880;
  int coinCount = 487;

  @override
  Widget build(BuildContext context) {
    String today = DateFormat('EEE, MMM d').format(DateTime.now());
    double xpProgress = currentXP / maxXP;

    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'asset/images/reward screen.png',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.grid_view, color: Colors.white, size: 36),
                        const SizedBox(width: 10),
                        Text(
                          today,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Times New Romance',
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Image.asset('asset/images/foxlogo.png', height: 60),
                  ],
                ),
                const SizedBox(height: 20),

                // Character Card
                Container(
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('assets/character_card.jpg'),
                      fit: BoxFit.cover,
                    ),
                    border: Border.all(color: Colors.orange, width: 3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      // Character Image
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.red, width: 2),
                        ),
                        child: Image.asset(
                          'assets/characters/15.png',
                          height: 64,
                          width: 64,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),

                      // Character Info + XP + Coins
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'S-RANK SHAPESHIFTER',
                              style: TextStyle(
                                fontFamily: 'Pixeled',
                                fontSize: 14,
                                color: Color.fromRGBO(5, 154, 82, 1),
                              ),
                            ),
                            const SizedBox(height: 6),

                            // XP Text
                            Row(
                              children: [
                                const Text(
                                  'XP',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 255, 210, 75),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Icon(Icons.monetization_on, color: Colors.amber[600], size: 18),
                                Text(
                                  ' $coinCount',
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 255, 210, 75),
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  '$currentXP / $maxXP',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 255, 210, 75),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),

                            // XP Bar
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: LinearProgressIndicator(
                                value: xpProgress,
                                minHeight: 8,
                                backgroundColor: Colors.white.withOpacity(0.3),
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                  Color.fromARGB(255, 255, 210, 75),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // Title
                const Center(
                  child: Text(
                    'REWARDS',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Add Reward Button
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddRewardScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.add, color: Colors.white),
                    label: const Text('ADD REWARD'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black.withOpacity(0.3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Reward List
                Expanded(
                  child: ListView.builder(
                    itemCount: rewards.length,
                    itemBuilder: (context, index) {
                      final reward = rewards[index];

                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.white24),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              reward['imagePath']!,
                              height: 32,
                              width: 32,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    reward['title']!,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    '${reward['points']} XP',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.yellow[700],
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 3),
    );
  }
}

// Sample rewards
final List<Map<String, String>> rewards = [
  {
    'imagePath': 'asset/images/coin.png',
    'title': 'BUY MYSELF COFFEE',
    'points': '10',
  },
  {
    'imagePath': 'asset/images/coin.png',
    'title': 'PLAY ML',
    'points': '20',
  },
  {
    'imagePath': 'asset/images/coin.png',
    'title': 'GO SHOPPING',
    'points': '30',
  },
];
