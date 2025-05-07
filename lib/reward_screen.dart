import 'package:flutter/material.dart';
import 'package:gamify/add_reward_screen.dart'; // Import AddRewardScreen
import 'package:gamify/bottom_nav_bar.dart';
import 'package:intl/intl.dart'; // For date formatting

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String today = DateFormat(
      'EEE, MMM d',
    ).format(DateTime.now()); // Date format

    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/reward screen.png', // Replace with your actual background image path
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
            child: Column(
              children: [
                // Upper Navigation with Date and Fox logo
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.grid_view,
                          color: Colors.white,
                          size: 36,
                        ),
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
                    Image.asset(
                      'assets/images/foxlogo.png',
                      height: 60,
                    ), // Your fox logo
                  ],
                ),
                const SizedBox(height: 10),

                // XP Bar (Icon)
                Row(
                  children: [
                    Icon(
                      Icons.star, // Example icon for XP
                      color: Colors.yellow[700],
                      size: 40,
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      '1555 / 8880 XP',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // Title of the screen
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
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddRewardScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 10,
                      ),
                    ),
                    child: const Text(
                      'ADD REWARD',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Rewards Showcase (without RewardBox)
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Two columns for rewards
                          crossAxisSpacing: 16.0,
                          mainAxisSpacing: 16.0,
                        ),
                    itemCount: rewards.length, // Number of rewards
                    itemBuilder: (context, index) {
                      final reward = rewards[index];

                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              // ignore: deprecated_member_use
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Coin Image
                            Image.asset(
                              reward['imagePath']!,
                              height: 40,
                              width: 40,
                            ),
                            const SizedBox(height: 10),

                            // Title of the reward
                            Text(
                              reward['title']!,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 5),

                            // Cost in yellow text
                            Text(
                              '${reward['points']} XP', // Cost (points)
                              style: TextStyle(
                                fontSize: 14,
                                color:
                                    Colors.yellow[700], // Yellow color for cost
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
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
      bottomNavigationBar: const BottomNavBar(
        selectedIndex: 1,
      ), // Bottom nav bar
    );
  }
}

// Sample rewards data
final List<Map<String, String>> rewards = [
  {
    'imagePath': 'assets/images/coin.png', // Replace with actual coin asset path
    'title': 'BUY MYSELF COFFEE',
    'points': '10',
  },
  {
    'imagePath': 'assets/images/coin.png', // Replace with actual coin asset path
    'title': 'PLAY ML',
    'points': '80',
  },
  {
    'imagePath': 'assets/images/coin.png', // Replace with actual coin asset path
    'title': 'GO SHOPPING',
    'points': '80',
  },
];
