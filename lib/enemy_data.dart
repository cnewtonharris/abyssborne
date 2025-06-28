import 'dart:math';

class EnemyData {
  final String name;
  int health;
  final int maxHealth;
  final int attack;
  final int defense;
  final int goldDrop;
  final int xpDrop;

  EnemyData({
    required this.name,
    required this.health,
    required this.maxHealth,
    required this.attack,
    required this.defense,
    required this.goldDrop,
    required this.xpDrop,
  });

  bool get isAlive => health > 0;

  void takeDamage(int amount) {
    health -= amount;
    if (health < 0) health = 0;
  }

  static EnemyData generate(String type) {
    switch (type) {
      case 'Goblin':
        return EnemyData(
          name: 'Goblin',
          health: 5,
          maxHealth: 5,
          attack: 5,
          defense: 2,
          goldDrop: 1,
          xpDrop: 1,
        );
      case 'Orc':
        return EnemyData(
          name: 'Orc',
          health: 10,
          maxHealth: 10,
          attack: 8,
          defense: 3,
          goldDrop: 2,
          xpDrop: 2,
        );
        case 'Troll':
        return EnemyData(
          name: 'Troll',
          health: 15,
          maxHealth: 15,
          attack: 12,
          defense: 4,
          goldDrop: 3,
          xpDrop: 3,
        );
        case 'Dragon':
        return EnemyData(
          name: 'Dragon',
          health: 20,
          maxHealth: 20,
          attack: 15,
          defense: 5,
          goldDrop: 4,
          xpDrop: 4,
        );
        case 'Boss':
        return EnemyData(
          name: 'Boss',
          health: 25,
          maxHealth: 25,
          attack: 20,
          defense: 6,
          goldDrop: 5,
          xpDrop: 5,
        );
    // Add more as needed
      default:
        return EnemyData(
          name: 'Slime',
          health: 3,
          maxHealth: 3,
          attack: 2,
          defense: 1,
          goldDrop: 1,
          xpDrop: 1,
        );
    }
  }
}

List<String> enemyTypes = ['Goblin', 'Orc', 'Troll', 'Dragon', 'Boss'];
EnemyData randomEnemy = EnemyData.generate(
  enemyTypes[Random().nextInt(enemyTypes.length)],
);
