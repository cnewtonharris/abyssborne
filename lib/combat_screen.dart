import 'dart:math';
import 'package:abyssborne/enemy_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CombatScreen extends StatefulWidget {
  final String playerName;
  final int health;
  final int mana;
  final int attack;
  final int defense;
  final int xp;
  final int level;
  final int gold;
  final EnemyData enemyData;

  const CombatScreen({
    required this.enemyData,
    required this.playerName,
    required this.health,
    required this.mana,
    required this.attack,
    required this.defense,
    required this.xp,
    required this.level,
    required this.gold,
    super.key,
  });

  @override
  State<CombatScreen> createState() => _CombatScreenState();
}

class _CombatScreenState extends State<CombatScreen> {
  late int playerHealth;
  late int playerMana;
  late int playerLevel;
  EnemyData enemyData = randomEnemy;
  late int enemyHealth;
  late String enemyName;

  List<String> combatLog = [];
  final Random rng = Random();

  @override
  void initState() {
    super.initState();
    playerHealth = widget.health;
    playerMana = widget.mana;
    playerLevel = widget.level;
    enemyName = enemyData.name;
    enemyHealth = enemyData.health;
  }

  void _log(String message) {
    setState(() {
      combatLog.insert(0, message);
    });
  }

  void _playerAttack() {
    if (_isBattleOver()) return;

    int damage = rng.nextInt(15) + 5;
    enemyHealth -= damage;
    _log("${widget.playerName} hits $enemyName for $damage damage.");

    if (enemyHealth <= 0) {
      enemyHealth = 0;
      _log("$enemyName has been defeated!");
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pop(context, 'victory');
      });
      return;
    }


    _enemyTurn();
  }

  void _defend() {
    if (_isBattleOver()) return;

    _log("You brace for the enemy's attack.");
    _enemyTurn(defending: true);
  }

  void _enemyTurn({bool defending = false}) {
    if (_isBattleOver()) return;

    Future.delayed(const Duration(milliseconds: 500), () {
      int damage = rng.nextInt(10) + 5;
      if (defending) {
        damage = (damage / 2).round();
        _log("You reduce the incoming damage.");
      }
      playerHealth -= damage;
      _log("$enemyName strikes you for $damage damage.");

      if (playerHealth <= 0) {
        playerHealth = 0;
        _log("${widget.playerName} has fallen in battle...");
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pop(context, 'defeat');
        });
      }


      setState(() {});
    });
  }

  bool _isBattleOver() => playerHealth <= 0 || enemyHealth <= 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Combat', style: GoogleFonts.cinzel(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatBox(widget.playerName, playerHealth, widget.health, playerMana, widget.mana),
                _buildStatBox(enemyName, enemyHealth, enemyData.health, 0, 0),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  border: Border.all(color: Colors.deepPurpleAccent),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(12),
                child: ListView(
                  reverse: true,
                  children: combatLog
                      .map((log) => Text(log, style: GoogleFonts.cinzel(color: Colors.white70)))
                      .toList(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                ElevatedButton(
                  onPressed: !_isBattleOver() ? _playerAttack : null,
                  child: const Text('Attack'),
                ),
                ElevatedButton(
                  onPressed: !_isBattleOver() ? _defend : null,
                  child: const Text('Defend'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Run'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatBox(String label, int currentHp, int maxHp, int currentMana, int maxMana) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.cinzel(color: Colors.white)),
        const SizedBox(height: 4),
        Container(
          width: 120,
          height: 10,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white70),
            borderRadius: BorderRadius.circular(6),
            color: Colors.grey.shade800,
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: (currentHp / maxHp).clamp(0.0, 1.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text('HP: $currentHp', style: GoogleFonts.cinzel(color: Colors.white70, fontSize: 12)),
        Container(
          width: 120,
          height: 10,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white70),
            borderRadius: BorderRadius.circular(6),
            color: Colors.grey.shade800,
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: (currentMana / maxMana).clamp(0.0, 1.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text('Mana: $currentMana', style: GoogleFonts.cinzel(color: Colors.white70, fontSize: 12)),

      ],
    );
  }
}