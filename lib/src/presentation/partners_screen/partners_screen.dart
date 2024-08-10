import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:t168/src/presentation/main_screens/widgets/create_task_containner.dart';
import 'package:t168/src/core/components/custom_scaffold.dart';
import 'package:t168/src/presentation/partners_screen/pages/add_partner/add_partner.dart';
import 'package:t168/src/providers/partner_provider/partner_provider.dart';
import 'package:t168/src/presentation/partners_screen/pages/widgets/partner_listview.dart';

class PartnersScreen extends StatefulWidget {
  const PartnersScreen({super.key});

  @override
  State<PartnersScreen> createState() => _PartnersScreenState();
}

class _PartnersScreenState extends State<PartnersScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF272727),
        leading: IconButton(
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddPartner(),
              ),
            );
          },
        ),
        title: Text(
          'Partners',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: const Color(0xFFFBFBFB),
            fontSize: 18.sp,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: Consumer<PartnerProvider>(
        builder: (context, partnerProvider, child) {
          final partners = partnerProvider.partners;
          if (partners.isEmpty) {
            return const CreatePartnerContainner();
          } else {
            return PartnerListView(
              partners: partners,
            );
          }
        },
      ),
    );
  }
}

class CreatePartnerContainner extends StatelessWidget {
  const CreatePartnerContainner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 15.h,
          ),
          SizedBox(
            width: 80.w,
            height: 42.h,
            child: Column(
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'YOU HAVE  ',
                        style: TextStyle(
                          color:
                              theme.textTheme.titleLarge?.color ?? Colors.white,
                          fontSize: 16.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text: 'NO PARTNERS',
                        style: TextStyle(
                          color:
                              theme.textTheme.titleLarge?.color ?? Colors.white,
                          fontSize: 16.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 3.h),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddPartner(),
                      ),
                    );
                  },
                  child: Container(
                    width: 50.w,
                    height: 7.5.h,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    decoration: const BoxDecoration(
                      color: Color(0xFFC9271E),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Center(
                      child: Text(
                        'ADD A PARTNER',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
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
