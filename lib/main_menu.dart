import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;

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
                  MenuButton(label: 'New Game', onTap: () {}),
                  MenuButton(label: 'Continue', onTap: () {}),
                  MenuButton(label: 'Settings', onTap: () {}),
                  MenuButton(label: 'Exit', onTap: () {}),
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
        onTap: onTap,
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
