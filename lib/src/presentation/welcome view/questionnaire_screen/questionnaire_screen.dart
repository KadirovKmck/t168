import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:t168/src/core/components/costom_container_color.dart';
import 'package:t168/src/core/components/navbar.dart';
import 'package:t168/src/presentation/welcome%20view/questionnaire_screen/constants/quasions_text.dart';
import 'package:t168/src/presentation/welcome%20view/questionnaire_screen/widget/frosted_glass_button.dart';

class QuestionnaireScreen extends StatefulWidget {
  const QuestionnaireScreen({super.key});

  @override
  State<QuestionnaireScreen> createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
  int selectedIndex = -1;
  final PageController _pageController = PageController();
  int currentPageIndex = 0;

  void onSelect(int index) {
    setState(() {
      selectedIndex = index;
      if (currentPageIndex < QuestionsText.questionPartsA.length - 1) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NavbarView()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ContainerColor(
      child: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(seconds: 5),
            curve: Curves.easeInOut,
            color: Colors.black.withOpacity(0.7),
            child: PageView.builder(
              controller: _pageController,
              itemCount: QuestionsText.questionPartsA.length,
              onPageChanged: (index) {
                setState(() {
                  currentPageIndex = index;
                  selectedIndex = -1;
                });
              },
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: QuestionsText.questionPartsA[index],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: QuestionsText.questionPartsB[index],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      FrostedGlassButton(
                        text: QuestionsText.answersA[index],
                        onTap: () => onSelect(0),
                      ),
                      SizedBox(height: 1.h),
                      FrostedGlassButton(
                        text: QuestionsText.answersB[index],
                        onTap: () => onSelect(1),
                      ),
                      SizedBox(height: 1.h),
                      FrostedGlassButton(
                        text: QuestionsText.answersC[index],
                        onTap: () => onSelect(2),
                      ),
                      SizedBox(height: 1.h),
                      FrostedGlassButton(
                        text: QuestionsText.answersD[index],
                        onTap: () => onSelect(3),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
