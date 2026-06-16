import 'package:flutter/material.dart';
import 'package:demo_app/civic_dashboard_page.dart';
import 'package:demo_app/speed_tap_game_page.dart';
import 'package:demo_app/art_studio_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _schoolController = TextEditingController();
  String _schoolName = "";

  @override
  void initState() {
    super.initState();
    _schoolController.addListener(() {
      setState(() {
        _schoolName = _schoolController.text.trim();
      });
    });
  }

  @override
  void dispose() {
    _schoolController.dispose();
    super.dispose();
  }

  // Helper method to get school display name
  String get _displaySchool =>
      _schoolName.isEmpty ? "Future Leaders" : _schoolName;

  @override
  Widget build(BuildContext context) {
    // =================================================================
    // TODO: KID CODER TASK - CHANGE THE WELCOME TEXT!
    // Edit the text inside the quotes below. Add emojis or your names!
    // Save (Ctrl + S) to see the title change on the screen.
    // =================================================================
    const String welcomeTitle = "Welcome to TeenTech Hub 🚀";
    const String welcomeSubtitle = "Accra Edition 2026";

    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.opaque,
        child: SafeArea(
          child: SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Event Header Banner
                Column(
                  children: [
                    const Text(
                      welcomeTitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      welcomeSubtitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 36),

                // School Input Area
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Who are we coding with?",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _schoolController,
                          decoration: InputDecoration(
                            hintText: "Enter your school name...",
                            prefixIcon: const Icon(Icons.school_outlined),
                            suffixIcon: _schoolName.isNotEmpty
                                ? IconButton(
                                    icon: const Icon(Icons.clear_rounded),
                                    onPressed: () {
                                      _schoolController.clear();
                                    },
                                  )
                                : null,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            filled: true,
                            fillColor: Theme.of(context).colorScheme.surface,
                          ),
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 16),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: Text(
                            "Welcome, $_displaySchool! Select a project below:",
                            key: ValueKey(_displaySchool),
                            style: TextStyle(
                              fontSize: 15,
                              fontStyle: FontStyle.italic,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 36),

                // Apps Grid (Visual Cards)
                const Text(
                  "App Micro-Projects",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                // Micro-App Cards List
                _buildAppCard(
                  context,
                  title: "🗳️ CivicVoice Teshie",
                  subtitle: "Politics & Leadership",
                  description:
                      "Voice community issues and vote on local solutions in Accra.",
                  color: Colors.teal,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CivicDashboardPage(schoolName: _displaySchool),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),

                _buildAppCard(
                  context,
                  title: "⚡ Speed Tap Game",
                  subtitle: "STEM & Logic Test",
                  description:
                      "Tap as fast as you can. Change variables to hack the speed!",
                  color: Colors.amber.shade800,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SpeedTapGamePage(schoolName: _displaySchool),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),

                _buildAppCard(
                  context,
                  title: "🎨 Pixel Art Studio",
                  subtitle: "Arts & Creative Design",
                  description:
                      "Design pixel grids and reload custom code palettes live.",
                  color: Colors.indigoAccent,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ArtStudioPage(schoolName: _displaySchool),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required String description,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(20),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.15),
              color.withOpacity(0.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(
            color: color.withOpacity(0.4),
            width: 1.5,
          ),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        subtitle.toUpperCase(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: color,
                          letterSpacing: 1.0,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Icon(
                    Icons.arrow_forward_rounded,
                    color: color,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
