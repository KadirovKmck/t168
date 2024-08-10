import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:t168/src/app/main_screens/widgets/create_task_containner.dart';
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
            return const CreateTaskContainner();
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
