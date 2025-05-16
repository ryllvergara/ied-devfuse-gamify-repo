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
  final int currentXP = 1563;
  final int maxXP = 8880;
  final int coinCount = 487;

  bool _showSidebar = false;

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

          // Main Content
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _showSidebar = true;
                        });
                      },
                      child: const Icon(Icons.grid_view, color: Colors.white, size: 36),
                    ),
                    Text(
                      today,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Times New Romance',
                        color: Colors.white,
                      ),
                    ),
                    Image.asset('asset/images/foxlogo.png', height: 60),
                  ],
                ),
                const SizedBox(height: 20),

<<<<<<< HEAD
                // Character Card
                _buildCharacterCard(xpProgress),
=======
                // Character Card with custom background
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
                                    color: Colors.white,
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
                                // ignore: deprecated_member_use
                                backgroundColor: Colors.white.withOpacity(0.3),
                                valueColor: const AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 255, 210, 75)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
>>>>>>> bdd93c0c67040bae3f1eb7cc7dc21d2d86302b01

                const SizedBox(height: 30),
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
                        MaterialPageRoute(builder: (context) => const AddRewardScreen()),
                      );
                    },
                    icon: const Icon(Icons.add, color: Colors.white),
                    label: const Text('ADD REWARD'),
                    style: ElevatedButton.styleFrom(
                      // ignore: deprecated_member_use
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
                          // ignore: deprecated_member_use
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

          // Sidebar Overlay
          if (_showSidebar)
            GestureDetector(
              onTap: () {
                setState(() {
                  _showSidebar = false;
                });
              },
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 60,
                    height: double.infinity,
                    color: Colors.black.withOpacity(0.8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.white),
                          onPressed: () {
                            setState(() {
                              _showSidebar = false;
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        const Icon(Icons.settings, color: Colors.white),
                        const SizedBox(height: 20),
                        const Icon(Icons.person, color: Colors.white),
                        const SizedBox(height: 20),
                        const Icon(Icons.info, color: Colors.white),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 3),
    );
  }

  Widget _buildCharacterCard(double xpProgress) {
    return Container(
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
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: LinearProgressIndicator(
                    value: xpProgress,
                    minHeight: 8,
                    backgroundColor: Colors.white.withOpacity(0.3),
                    valueColor: const AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 255, 210, 75)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRewardTile(Map<String, String> reward) {
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
