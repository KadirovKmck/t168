import 'package:flutter/material.dart';

class ImageDeepUi extends StatelessWidget {
  const ImageDeepUi({
    super.key,
    required this.child,
    required this.imageas,
  });

  final Widget child;
  final String imageas;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imageas),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
