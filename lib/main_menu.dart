import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'audio_manager.dart';
import 'character_creation_screen.dart';


class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _fadeIn = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background layer
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/main_menu_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Overlay for dim effect
          Container(
            color: Colors.black.withOpacity(0.6),
          ),

          // Main menu content with fade-in
          Center(
            child: FadeTransition(
              opacity: _fadeIn,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'ABYSSBORNE',
                    style: GoogleFonts.medievalSharp(
                      fontSize: 48,
                      color: Colors.white,
                      letterSpacing: 4,
                      shadows: [
                        Shadow(
                          offset: Offset(2, 2),
                          blurRadius: 4,
                          color: Colors.black87,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  MenuButton(
                      label: 'New Game',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CharacterCreationScreen()),
                        );
                      }),
                  MenuButton(label: 'Continue', onTap: () {}),
                  MenuButton(
                    label: 'Settings',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SettingsScreen()),
                      );
                    },
                  ),
                  MenuButton(
                    label: 'Exit',
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          backgroundColor: Colors.black87,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          title: Text(
                            'Exit Game',
                            style: GoogleFonts.cinzel(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          content: Text(
                            'Are you sure you want to leave the Abyss?',
                            style: GoogleFonts.cinzel(color: Colors.white70),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('Cancel', style: TextStyle(color: Colors.white)),
                            ),
                            TextButton(
                              onPressed: () => SystemNavigator.pop(),
                              child: const Text('Exit Game', style: TextStyle(color: Colors.redAccent)),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const MenuButton({required this.label, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: () async {
          await AudioManager().playSfx('tap.mp3');
          onTap();
        },
        child: Container(
          width: 200,
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade900.withOpacity(0.8),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.deepPurpleAccent, width: 2),
          ),
          child: Center(
            child: Text(
              label,
              style: GoogleFonts.cinzel(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}



  class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool musicOn = true;
  bool soundOn = true;
  double musicVolume = 0.5; // 50% by default
  double sfxVolume = 1.0;



  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      musicOn = prefs.getBool('musicOn') ?? true;
      soundOn = prefs.getBool('soundOn') ?? true;
      musicVolume = prefs.getDouble('musicVolume') ?? 0.5;
      sfxVolume = prefs.getDouble('sfxVolume') ?? 1.0;

    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Settings',
          style: GoogleFonts.cinzel(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SwitchListTile(
              title: Text(
                'Music',
                style: GoogleFonts.cinzel(color: Colors.white),
              ),
              value: musicOn,
              activeColor: Colors.deepPurpleAccent,
              onChanged: (val) async {
                setState(() {
                  musicOn = val;
                });
                final prefs = await SharedPreferences.getInstance();
                await prefs.setBool('musicOn', musicOn);

                if (musicOn) {
                  await AudioManager().playMusic();
                } else {
                  await AudioManager().stopMusic();
                }
              },
            ),
            if (musicOn)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      'Volume',
                      style: GoogleFonts.cinzel(color: Colors.white),
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.volume_mute, color: Colors.white),
                      Expanded(
                        child: Slider(
                          value: musicVolume,
                          min: 0,
                          max: 1,
                          divisions: 10,
                          activeColor: Colors.deepPurpleAccent,
                          onChanged: (val) async {
                            setState(() {
                              musicVolume = val;
                            });
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setDouble('musicVolume', musicVolume);
                            await AudioManager().setVolume(musicVolume);
                          },
                        ),
                      ),
                      const Icon(Icons.volume_up, color: Colors.white),
                    ],
                  ),
                ],
              ),
            SwitchListTile(
              title: Text(
                'Sound FX',
                style: GoogleFonts.cinzel(color: Colors.white),
              ),
              value: soundOn,
              activeColor: Colors.deepPurpleAccent,
              onChanged: (val) async {
                setState(() {
                  soundOn = val;
                });
                final prefs = await SharedPreferences.getInstance();
                await prefs.setBool('soundOn', soundOn);
                await prefs.setDouble('sfxVolume', sfxVolume);
              },
            ),
            if (soundOn)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      'SFX Volume',
                      style: GoogleFonts.cinzel(color: Colors.white),
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.volume_mute, color: Colors.white),
                      Expanded(
                        child: Slider(
                          value: sfxVolume,
                          min: 0,
                          max: 1,
                          divisions: 10,
                          activeColor: Colors.deepPurpleAccent,
                          onChanged: (val) async {
                            setState(() {
                              sfxVolume = val;
                            });
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setDouble('sfxVolume', sfxVolume);
                          },
                        ),
                      ),
                      const Icon(Icons.volume_up, color: Colors.white),
                    ],
                  ),
                ],
              ),

          ],
        ),
      ),
    );
  }
}
