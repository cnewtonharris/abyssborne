class CharacterData {
  final String name;
  final String classType  ;
  int health;
  int maxHealth;
  int mana;
  int maxMana;
  int attack;
  int defense;
  int xp;
  int xpToNextLevel;
  int level;
  int gold;

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
    this.xpToNextLevel = 100,
    this.level = 1,
    this.gold = 0,
  });

  //methods
  bool get isAlive => health > 0;

  double get healthPercentage => (health / maxHealth).clamp(0.0, 1.0);

  void takeDamage(int damage) {
    health -= damage;
    if (health < 0) {
      health = 0;
    }
  }

  void spendMana(int amount) {
    mana -= amount;
    if (mana < 0) {
      mana = 0;
    }
  }

  void restoreMana(int amount) {
    mana += amount;
    if (mana > maxMana) {
      mana = maxMana;
    }
  }

  void gainXp(int amount) {
    xp += amount;
    if (xp >= 100) {
      level += 1;
      xp -= 100;
    }
  }

  void nextXpLevelIncrease() {
    xpToNextLevel = xpToNextLevel * 120 % 100;
  }

  factory CharacterData.warrior(String name) => CharacterData(
    name: name,
    classType: 'Warrior',
    health: 100,
    maxHealth: 100,
    mana: 50,
    maxMana: 50,
    attack: 10,
    defense: 5,
    xp: 0,
    xpToNextLevel: 100,
    level: 1,
    gold: 0,
  );

  factory CharacterData.wizard(String name) => CharacterData(
    name: name,
    classType: 'Wizard',
    health: 100,
    maxHealth: 100,
    mana: 50,
    maxMana: 50,
    attack: 10,
    defense: 5,
    xp: 0,
    xpToNextLevel: 100,
    level: 1,
    gold: 0,
  );

  factory CharacterData.archer(String name) => CharacterData(
    name: name,
    classType: 'Archer',
    health: 100,
    maxHealth: 100,
    mana: 50,
    maxMana: 50,
    attack: 10,
    defense: 5,
    xp: 0,
    xpToNextLevel: 100,
    level: 1,
    gold: 0,
  );
}



