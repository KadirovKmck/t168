import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:t168/src/app/welcome%20view/fillin_Information/fillin_Information.dart';
import 'package:t168/src/app/welcome%20view/onbording_sreen/constants/text_constants.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_pageController.page! < TextConst.content.length - 1) {
      _pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FillinInformation(),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveSizer(
        builder: (context, orientation, screenType) {
          return PageView.builder(
            controller: _pageController,
            itemCount: TextConst.content.length,
            itemBuilder: (context, index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/box${index + 1}.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(4.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 3.h),
                      SmoothPageIndicator(
                        controller: _pageController,
                        count: TextConst.content.length,
                        effect: ExpandingDotsEffect(
                          expansionFactor: 2.0,
                          dotWidth: 9.0,
                          dotHeight: 9.0,
                          spacing: 4.0,
                          dotColor: Colors.grey.shade300,
                          activeDotColor: Colors.red.shade700,
                        ),
                      ),
                      const Spacer(),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  '${TextConst.content[index]['title']!.split(' ').take(TextConst.content[index]['title']!.split(' ').length - 1).join(' ')} ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            TextSpan(
                              text: TextConst.content[index]['title']!
                                  .split(' ')
                                  .last,
                              style: TextStyle(
                                color: const Color(0xFFCB0A05),
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        TextConst.content[index]['description']!,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      GestureDetector(
                        onTap: _nextPage,
                        child: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          height: 7.h,
                          color: const Color(0xFF5B0604),
                          child: Text(
                            TextConst.content[index]['button']!,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(height: 3.h),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
