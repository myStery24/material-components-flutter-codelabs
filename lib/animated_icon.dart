import 'package:flutter/material.dart';

import 'colors.dart';

/// Animated icon: home->menu, menu->home
class AnimatedBrandedIcon extends StatefulWidget {
  const AnimatedBrandedIcon({Key? key}) : super(key: key);

  @override
  _AnimatedBrandedIconState createState() => _AnimatedBrandedIconState();
}

class _AnimatedBrandedIconState extends State<AnimatedBrandedIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController iconController;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();

    // Create an instance of Controller and define a duration of 3 second
    iconController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )
      // Perform forward animation, then after 1 sec reverse the animation transition
      ..forward().then((_) async {
        await Future.delayed(
          const Duration(seconds: 1),
        );
        // Perform reverse animation
        reverseIcon();
      })
      // Repeat the animation
      ..addListener(() {
        if (iconController.isCompleted) {
          iconController.repeat();
        }
      });
  }

  // Dispose the controller when not in use
  @override
  void dispose() {
    super.dispose();
    iconController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            toggleIcon();
          },
          child: AnimatedIcon(
            // Start with home icon, end with menu icon
            icon: AnimatedIcons.home_menu,
            color: kShrineBrown900,
            size: 24,
            progress: iconController,
          ),
        ),
      ],
    );
  }

  // Method called to perform reverse animation
  void reverseIcon() => setState(() {
        // Set the state of isPlaying to true
        isPlaying = !isPlaying;
        isPlaying ? iconController.forward() : iconController.reverse();
      });

  // Method called when user taps on the icon
  void toggleIcon() => setState(() {
        isPlaying = !isPlaying;
        isPlaying ? iconController.forward() : iconController.stop();
      });
}
