import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class Reward {
  final String rewardname;
  final int cost;

  Reward({required this.rewardname, required this.cost});
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final int xp = 0;
  int coins = 20;
  final int xpLimit = 2000;

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
    if (coins >= cost) {
      setState(() {
        coins -= cost;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reward App',
      home: Scaffold(
        appBar: AppBar(title: Text('S-Rank Necromancer')),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  // Avatar (Can be replaced with a picker later)
                  Image.asset('asset/images/reward screen.png', height: 50),
                  SizedBox(width: 10),
                  Text('XP: $xp / $xpLimit | Coins: $coins'),
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
              ElevatedButton(onPressed: addReward, child: Text('Add Reward')),
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
      ),
    );
  }
}
