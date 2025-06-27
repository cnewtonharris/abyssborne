class CharacterData {
  final String name;
  final String classType  ;
  final int health;
  final int maxHealth;
  final int mana;
  final int maxMana;
  final int attack;
  final int defense;
  final int xp;
  final int level;
  final int gold;

  CharacterData({
    this.name = '',
    this.classType = '',
    this.health = 100,
    this.maxHealth = 100,
    this.mana = 50,
    this.maxMana = 50,
    this.attack = 10,
    this.defense = 5,
    this.xp = 0,
    this.level = 1,
    this.gold = 0,
  });
}