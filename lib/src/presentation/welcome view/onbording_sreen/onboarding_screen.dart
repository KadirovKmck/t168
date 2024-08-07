import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:t168/src/core/components/image_deep_ui.dart';
import 'package:t168/src/presentation/welcome%20view/onbording_sreen/constants/text_constants.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  void _nextPage() {
    if (_pageController.page! < TextConst.content.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Navigation to next screen logic here
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return PageView.builder(
          controller: _pageController,
          itemCount: TextConst.content.length,
          itemBuilder: (context, index) {
            return ImageDeepUi(
              imageas: 'assets/images/box1.png',
              child: Padding(
                padding: EdgeInsets.all(4.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SmoothPageIndicator(
                      controller: _pageController,
                      count: TextConst.content.length,
                      effect: WormEffect(
                        dotWidth: 9.0,
                        dotHeight: 9.0,
                        spacing: 4.0,
                        dotColor: Colors.grey[300]!,
                        activeDotColor: const Color(0xFFCB0A05),
                      ),
                    ),
                    const Spacer(),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'OPTIMIZE YOUR ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          TextSpan(
                            text: 'TIME',
                            style: TextStyle(
                              color: const Color(0xFFCB0A05),
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 1.5.h),
                    Text(
                      TextConst.content[index]['description']!,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    GestureDetector(
                      onTap: _nextPage,
                      child: Container(
                        height: 8.h,
                        color: const Color(0xFF5B0604),
                        child: Center(
                          child: Text(
                            'CONTINUE',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
