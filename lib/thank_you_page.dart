import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ThankYouPage extends StatefulWidget {
  const ThankYouPage({super.key, required this.bgColor});

  final Color bgColor;

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
        Future.delayed(const Duration(milliseconds: 500), () {
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
                    )),
              ),
            ),
          ),
          const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //
                SizedBox(height: 16),

                //
                Text(
                  'Thank you Yongdal Academy!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
