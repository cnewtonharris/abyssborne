import 'dart:math';

class EnemyData {
  final String name;
  final int health;
  final int attack;
  final int defense;
  final int goldDrop;
  final int xpDrop;

  EnemyData(this.name, this.health, this.attack, this.defense, this.goldDrop, this.xpDrop);
}

List<EnemyData> enemyPool = [
  EnemyData('Goblin', 5, 5, 2, 1, 1),
  EnemyData('Orc', 10, 8, 3, 2, 2),
  EnemyData('Troll', 15, 12, 5, 3, 3),
  EnemyData('Dragon', 20, 15, 8, 4, 4),
  EnemyData('Boss', 25, 20, 10, 5, 5),
];

final EnemyData randomEnemy = enemyPool[Random().nextInt(enemyPool.length)];