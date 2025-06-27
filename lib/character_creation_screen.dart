import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'game_screen.dart';


import 'hub_menu_screen.dart';
import 'main_menu.dart';

class CharacterCreationScreen extends StatefulWidget {
  const CharacterCreationScreen({super.key});

  @override
  State<CharacterCreationScreen> createState() => _CharacterCreationScreenState();
}

class _CharacterCreationScreenState extends State<CharacterCreationScreen> {
  String selectedClass = 'Knight';
  final TextEditingController nameController = TextEditingController();


  final List<Map<String, dynamic>> classes = [
    {
      'name': 'Knight',
      'description': 'A strong warrior with high defense.',
      'iconPath': 'assets/images/classes/knight_icon.png',
      'stats': {
        'Health': 120,
        'Mana': 30,
        'Attack': 60,
        'Speed': 40,
      },
    },
    {
      'name': 'Mage',
      'description': 'A master of arcane spells and ranged attacks.',
      'iconPath': 'assets/images/classes/mage_icon.png',
      'stats': {
        'Health': 70,
        'Mana': 120,
        'Attack': 90,
        'Speed': 50,
      },
    },
    {
      'name': 'Rogue',
      'description': 'A stealthy assassin with swift strikes.',
      'iconPath': 'assets/images/classes/rogue_icon.png',
      'stats': {
        'Health': 80,
        'Mana': 40,
        'Attack': 75,
        'Speed': 90,
      },
    },
  ];




  @override
  Widget build(BuildContext context) {
    final selectedClassData = classes.firstWhere((cls) => cls['name'] == selectedClass);
    final stats = selectedClassData['stats'] as Map<String, int>;
    const int maxStatValue = 150; // Adjust as needed based on your classes


    return Scaffold(
    backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Choose Your Class', style: GoogleFonts.cinzel(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => HubMenuScreen()),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ...classes.map((cls) {
              bool isSelected = selectedClass == cls['name'];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedClass = cls['name']!;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.deepPurple.shade900 : Colors.grey.shade900,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? Colors.deepPurpleAccent : Colors.grey,
                      width: 2,
                    ),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        cls['iconPath']!,
                        width: 32,
                        height: 32,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cls['name']!,
                              style: GoogleFonts.cinzel(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              cls['description']!,
                              style: GoogleFonts.cinzel(color: Colors.white70, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  'Enter Your Name',
                  style: GoogleFonts.cinzel(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: nameController,
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.deepPurpleAccent,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade900,
                    hintText: 'Your character name...',
                    hintStyle: const TextStyle(color: Colors.white38),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.deepPurpleAccent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.deepPurpleAccent),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Stats',
                  style: GoogleFonts.cinzel(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                ...stats.entries.map((entry) {
                  final label = entry.key;
                  final value = entry.value;
                  final double percent = value / maxStatValue;

                  // Assign color based on stat name
                  Color getBarColor(String stat) {
                    switch (stat) {
                      case 'Health':
                        return Colors.redAccent;
                      case 'Mana':
                        return Colors.blueAccent;
                      case 'Attack':
                        return Colors.orangeAccent;
                      case 'Speed':
                        return Colors.greenAccent;
                      default:
                        return Colors.grey;
                    }
                  }

                  IconData getStatIcon(String stat) {
                    switch (stat) {
                      case 'Health':
                        return Icons.favorite;
                      case 'Mana':
                        return Icons.auto_fix_high;
                      case 'Attack':
                        return Icons.gavel; // like a weapon hit
                      case 'Speed':
                        return Icons.directions_run;
                      default:
                        return Icons.brightness_low;
                    }
                  }

                  final barColor = getBarColor(label);

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(getStatIcon(label), color: barColor, size: 18),
                            const SizedBox(width: 8),
                            Text(
                              '$label: $value',
                              style: GoogleFonts.cinzel(color: Colors.white70),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: TweenAnimationBuilder<double>(
                            tween: Tween<double>(begin: 0, end: percent),
                            duration: const Duration(milliseconds: 400),
                            builder: (context, animatedValue, child) {
                              return LinearProgressIndicator(
                                value: animatedValue,
                                minHeight: 10,
                                backgroundColor: Colors.grey.shade800,
                                valueColor: AlwaysStoppedAnimation<Color>(barColor),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),

            const Spacer(),
            ElevatedButton(
              onPressed: () {
                final playerName = nameController.text.trim();
                if (playerName.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter a name!')),
                  );
                  return;
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => HubMenuScreen(
                    ),
                  ),
                );

              },

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurpleAccent,
              ),
              child: Text(
                'Continue as $selectedClass',
                style: GoogleFonts.cinzel(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
