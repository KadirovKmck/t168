import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:t168/src/core/components/costom_container_color.dart';
import 'package:t168/src/presentation/partners_screen/widget/add_priority_tabbar.dart';

class CostomPartners extends StatefulWidget {
  const CostomPartners({super.key});

  @override
  State<CostomPartners> createState() => _CostomPartnersState();
}

class _CostomPartnersState extends State<CostomPartners> {
  @override
  Widget build(BuildContext context) {
    int selectedPriorityIndex = 1;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xFF272727),
        leading: const SizedBox(),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close, color: Colors.white),
          ),
        ],
        title: Text(
          'Add Partner',
          style: TextStyle(
            color: const Color(0xFFFBFBFB),
            fontSize: 18.sp,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: ContainerColor(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'since 12/01/2022',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.3499999940395355),
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                const Text(
                  'IN THE PROCESS',
                  style: TextStyle(
                    color: Color(0xFFFF9900),
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            Row(
              children: [
                Container(
                  width: 12.w,
                  height: 6.h,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://via.placeholder.com/40x40"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
                const Text(
                  'HOOPS HEALTH NUTRITION',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            Text(
              'Manufacturer of specialty sports supplements and nutritional products designed for basketball players and athletes. Collaboration may include promotional campaigns, joint events and supporting healthy lifestyles among fans.',
              style: TextStyle(
                color: Colors.white.withOpacity(0.6000000238418579),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            const SizedBox(
              width: double.infinity,
              child: Text(
                'STATUS:',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            AddPriorityTabBar(
              selectedIndex: selectedPriorityIndex,
              onChanged: (int index) {
                setState(() {
                  selectedPriorityIndex = index;
                });
              },
            ),
            SizedBox(
              height: 1.5.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 45.w,
                  height: 44,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFC9271E),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                  ),
                  child: const Center(
                    child: Text(
                      'Notes',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 45.w,
                  height: 44,
                  decoration: ShapeDecoration(
                    color: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                  ),
                  child: const Center(
                    child: Text(
                      'Notes',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            const SizedBox(
              width: double.infinity,
              child: Text(
                'NOTES:',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Slidable(
              key: const ValueKey(0),
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SizedBox(
                    width: 3.w,
                  ),
                  Container(
                    width: 10.w,
                    height: 5.h,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF4D4D4D),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(11.0),
                      child: SvgPicture.asset(
                        'assets/icons/del.svg',
                      ),
                    ),
                  ),
                ],
              ),
              child: Container(
                height: 15.h,
                decoration: ShapeDecoration(
                  color: const Color(0xFF121212),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1,
                      color: Colors.white.withOpacity(0.05000000074505806),
                    ),
                  ),
                ),
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Develop a marketing strategy to attract fans to our basketball team's games. Use data analysis to identify the target audience and come up with creative ways to attract new viewers through promotions, special offers and advertising campaigns.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
