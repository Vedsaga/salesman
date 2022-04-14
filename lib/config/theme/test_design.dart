

// Flutter imports:
import 'package:flutter/material.dart';

class TestDesign extends StatelessWidget {
  const TestDesign({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFF15A24),
                      Color(0xFFF68F1F),
                      Color(0xFFF68F1F),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(13),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
