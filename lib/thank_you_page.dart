import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ThankYouPage extends StatefulWidget {
  const ThankYouPage({
    super.key,
    required this.bgColor,
    this.customMessage = 'Thank you, Accra Tech Kids!',
  });

  final Color bgColor;
  final String customMessage;

  @override
  State<ThankYouPage> createState() => _ThankYouPageState();
}

class _ThankYouPageState extends State<ThankYouPage>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  bool _showAnimation = false;

  void _startAnimation() async {
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    setState(() => _showAnimation = true);
    _controller.forward(from: 0);
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 1500), () {
          if (mounted) {
            Navigator.pop(context);
          }
        });
      }
    });

    _startAnimation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.bgColor,
      body: Stack(
        children: [
          // Background Confetti Animation
          Positioned.fill(
            child: IgnorePointer(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: FittedBox(
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 500,
                    width: 500,
                    child: AnimatedOpacity(
                      opacity: _showAnimation ? 1 : 0,
                      duration: const Duration(milliseconds: 300),
                      child: Lottie.asset(
                        'assets/balloon_confetti.json',
                        controller: _controller,
                        repeat: false,
                        onLoaded: (composition) {
                          _controller.duration = composition.duration * 1.65;
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Central Messaging Card
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Card(
                color: Colors.black.withOpacity(0.4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 36.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.verified_user_rounded,
                        color: Colors.white,
                        size: 64,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        widget.customMessage,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "TeenTechFest Accra 2026",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
