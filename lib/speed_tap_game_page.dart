import 'dart:async';
import 'package:flutter/material.dart';
import 'package:demo_app/thank_you_page.dart';

class SpeedTapGamePage extends StatefulWidget {
  final String schoolName;

  const SpeedTapGamePage({super.key, required this.schoolName});

  @override
  State<SpeedTapGamePage> createState() => _SpeedTapGamePageState();
}

class _SpeedTapGamePageState extends State<SpeedTapGamePage> {
  // =================================================================
  // TODO: KID CODER TASK - HACK THE GAME RULES!
  // 1. Change "gameDurationSeconds" to 5 to make the game shorter and faster!
  // 2. Change "pointsPerTap" to 10 or 100 to get a super high score in one tap!
  // Press Save (Ctrl + S) to see your hacks instantly applied!
  // =================================================================
  static const int gameDurationSeconds = 10;
  static const int pointsPerTap = 1;

  int _score = 0;
  int _highScore = 0;
  int _timeLeft = gameDurationSeconds;
  bool _isGameActive = false;
  bool _hasGameStartedOnce = false;
  Timer? _timer;

  void _startGame() {
    setState(() {
      _score = 0;
      _timeLeft = gameDurationSeconds;
      _isGameActive = true;
      _hasGameStartedOnce = true;
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 1) {
        setState(() {
          _timeLeft--;
        });
      } else {
        _endGame();
      }
    });
  }

  void _endGame() {
    _timer?.cancel();
    setState(() {
      _timeLeft = 0;
      _isGameActive = false;
      if (_score > _highScore) {
        _highScore = _score;
      }
    });
  }

  void _incrementScore() {
    if (!_isGameActive) return;
    setState(() {
      _score += pointsPerTap;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final amberColor = Colors.amber.shade800;

    return Scaffold(
      appBar: AppBar(
        title: const Text("⚡ Speed Tap Game"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top Banner info (edge-to-edge)
            Container(
              color: amberColor.withOpacity(0.15),
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              width: double.infinity,
              child: Text(
                "Player from: ${widget.schoolName}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber.shade300,
                ),
              ),
            ),
            // Padded content area
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Scoreboard Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildScoreDisplay("CURRENT", _score, Colors.white),
                        _buildScoreDisplay("HIGH SCORE", _highScore, Colors.amberAccent),
                      ],
                    ),
                    const SizedBox(height: 36),

                    // Timer Widget
                    Center(
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: _isGameActive ? Colors.redAccent : Colors.grey,
                            width: 4,
                          ),
                          color: _isGameActive
                              ? Colors.redAccent.withOpacity(0.1)
                              : Colors.transparent,
                        ),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "TIME LEFT",
                              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey),
                            ),
                            Text(
                              "$_timeLeft",
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: _isGameActive ? Colors.redAccent : Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),

                    // Game Button / Start Button Area
                    Center(
                      child: AnimatedScale(
                        scale: _isGameActive ? 1.1 : 1.0,
                        duration: const Duration(milliseconds: 100),
                        child: ElevatedButton(
                          onPressed: _isGameActive
                              ? _incrementScore
                              : (_hasGameStartedOnce ? null : _startGame),
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(64),
                            backgroundColor: _isGameActive ? amberColor : theme.colorScheme.primary,
                            foregroundColor: Colors.white,
                            elevation: 8,
                            shadowColor: _isGameActive ? amberColor : theme.colorScheme.primary,
                          ),
                          child: Text(
                            _isGameActive
                                ? "TAP TAP!"
                                : (_hasGameStartedOnce ? "SUBMIT 👇" : "START"),
                            style: TextStyle(
                              fontSize: (_hasGameStartedOnce && !_isGameActive) ? 18 : 24,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),

                    // Navigation Page Links
                    if (_hasGameStartedOnce && !_isGameActive) ...[
                      ElevatedButton(
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ThankYouPage(
                                bgColor: amberColor,
                                customMessage: "${widget.schoolName} set a high score of $_highScore!",
                              ),
                            ),
                          );
                          if (mounted) {
                            setState(() {
                              _score = 0;
                              _timeLeft = gameDurationSeconds;
                              _hasGameStartedOnce = false;
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: Colors.amber.shade900,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Submit High Score & Celebrate 🚀",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ] else ...[
                      const Center(
                        child: Text(
                          "Tap START to begin the challenge!",
                          style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreDisplay(String label, int value, Color textColor) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Colors.grey),
        ),
        const SizedBox(height: 4),
        Text(
          "$value",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ],
    );
  }
}
