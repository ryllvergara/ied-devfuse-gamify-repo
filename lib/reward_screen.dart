import 'package:flutter/material.dart';
import 'progress_data.dart';

void main() => runApp(MyApp());

class Reward {
  final String rewardname;
  final int cost;
  final ProgressData progressData;

  Reward({required this.rewardname, required this.cost});
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.progressData});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  int get xp => widget.progressData.totalXP;
  int get coins => widget.progressData.coins;
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
    if (widget.progressData.spendCoins(cost)) {
      setState(() {}); // update UI
      }
  }
    
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reward App',
      home: Scaffold(
        appBar: AppBar(title: Text('S-Rank Necromancer')),
<<<<<<< HEAD
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('asset/images/reward screen.png'),
                  fit: BoxFit.cover,
=======
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  // Avatar (Can be replaced with a picker later)
                  Image.asset(
                    'asset/images/reward screen.png',
                    fit: BoxedFit.cover,
                  )
                  ),
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
>>>>>>> be88a677ed509f22ea2121f64f45f0acb23f36b1
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
                        'XP: $xp / $xpLimit | Coins: $coins',
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
      ),
    );
  }
}
