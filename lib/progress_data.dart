
class ProgressData {
  static final ProgressData _instance = ProgressData._internal();
  factory ProgressData({required progress}) => _instance;

  ProgressData._internal();

  int totalXP = 0;

  int get coins => totalXP ~/ 5;

  void addXP(int xp) {
    totalXP += xp;
  }

  bool spendCoins(int cost) {
    if (coins >= cost) {
      totalXP -= cost * 5;
      return true;
    }
    return false;
  }
}