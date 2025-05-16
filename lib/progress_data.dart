class ProgressData {
  // This is the one and only instance (singleton)
  static final ProgressData _instance = ProgressData._internal();

  // This factory always returns the same instance
  factory ProgressData({required progress}) => _instance;

  // Private constructor
  ProgressData._internal();

  // Total XP the user has earned so far
  int totalXP = 0;

  // Coins are calculated from XP (5 XP = 1 coin)
  int get coins => totalXP ~/ 5;

  // Adds XP to the total
  void addXP(int xp) {
    totalXP += xp;
  }

  // Tries to spend coins. Returns true if successful, false if not enough.
  bool spendCoins(int cost) {
    if (coins >= cost) {
      totalXP -= cost * 5; // Subtract the XP equivalent of the coins spent
      return true;
    }
    return false;
  }
}
