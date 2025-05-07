import 'package:flutter/material.dart';
import 'progress_data.dart';



class Reward {
  final String rewardname;
  final int cost;

  Reward({required this.rewardname, required this.cost});
}

class RewardApp extends StatefulWidget {
  const RewardApp({super.key});

  @override
  State<RewardApp> createState() => _RewardAppState();
}

class _RewardAppState extends State<RewardApp> {
  final ProgressData progressData = ProgressData(); // singleton instance
  final List<Reward> rewards = [];
  final nameController = TextEditingController();
  final costController = TextEditingController();

  void addReward() {
    if (nameController.text.isEmpty || costController.text.isEmpty) return;
    final rewardname = nameController.text;
    final cost = int.tryParse(costController.text) ?? 0;
    setState(() {
      rewards.add(Reward(rewardname: rewardname, cost: cost));
      nameController.clear();
      costController.clear();
    });
  }

  void redeemReward(int index) {
    final cost = rewards[index].cost;
    if (progressData.spendCoins(cost)) {
      setState(() {}); // refresh to update coin count
    }
  }

  @override
  Widget build(BuildContext context) {
    final int xp = progressData.totalXP;
    final int coins = progressData.coins;

    return Scaffold(
      appBar: AppBar(title: Text('S-Rank Necromancer')),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('asset/images/reward screen.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(width: 10),
                    Text(
                      'XP: $xp | Coins: $coins',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Reward Name'),
                ),
                TextField(
                  controller: costController,
                  decoration: InputDecoration(labelText: 'Reward Cost'),
                  keyboardType: TextInputType.number,
                ),
                ElevatedButton(
                  onPressed: addReward,
                  child: Text('Add Reward'),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: rewards.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(rewards[index].rewardname),
                        subtitle: Text('Cost: ${rewards[index].cost}'),
                        trailing: ElevatedButton(
                          onPressed: () => redeemReward(index),
                          child: Text('Redeem'),
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
    );
  }
}
