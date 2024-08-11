import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:t168/src/core/components/costom_container_color.dart';
import 'package:t168/src/core/components/custom_scaffold.dart';
import 'package:t168/src/models/partners_models.dart';
import 'package:t168/src/presentation/partners_screen/pages/custom_partner/views/add_note/add_note.dart';
import 'package:t168/src/presentation/partners_screen/pages/custom_partner/views/notes.dart';
import 'package:t168/src/presentation/partners_screen/pages/edit/partner_edit.dart';
import 'package:t168/src/providers/partner_provider/partner_provider.dart';
import 'package:t168/src/presentation/partners_screen/pages/widgets/add_priority_tabbar.dart';

class CostomPartners extends StatefulWidget {
  const CostomPartners({super.key, required this.partners});
  final PartnersModels partners;

  @override
  State<CostomPartners> createState() => _CostomPartnersState();
}

class _CostomPartnersState extends State<CostomPartners> {
  String getStatusText(int index) {
    switch (index) {
      case 0:
        return 'PROCESS';
      case 1:
        return 'ACTIVELY';
      case 2:
        return 'SUSPENDED';
      case 3:
        return 'COMPLETED';
      default:
        return 'UNKNOWN STATUS';
    }
  }

  int selectedPriorityIndex = 1;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return CustomScaffold(
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
      body: Consumer<PartnerProvider>(
        builder: (context, partnerProvider, child) {
          // Ensure we're working with the correct partner instance
          final partner = widget.partners;
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'since ${partner.startDate}',
                      style: TextStyle(
                        color:
                            theme.textTheme.titleLarge?.color ?? Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'IN THE ${getStatusText(partner.status)}',
                      style: const TextStyle(
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 12.w,
                      height: 6.h,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: partner.photo.isNotEmpty
                              ? FileImage(File(partner.photo))
                              : const AssetImage(
                                  "assets/images/default_image.png",
                                ) as ImageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          partner.companyName,
                          style: TextStyle(
                            color: theme.textTheme.titleLarge?.color ??
                                Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        SizedBox(
                          width: 67.w,
                          child: Text(
                            partner.description,
                            style: TextStyle(
                              color: theme.textTheme.titleLarge?.color ??
                                  Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            softWrap: true,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 4.h,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    'STATUS:',
                    style: TextStyle(
                      color: theme.textTheme.titleLarge?.color ?? Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                AddPriorityTabBar(
                  selectedIndex: partner.status,
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
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddNote(partner: partner),
                          ),
                        );
                      },
                      child: Container(
                        width: 35.w,
                        height: 44,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFC9271E),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
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
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PartnerEdit(
                              partner: partner,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: 35.w,
                        height: 44,
                        decoration: ShapeDecoration(
                          color: Colors.green,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                        ),
                        child: const Center(
                          child: Text(
                            'Edit info',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    'NOTES:',
                    style: TextStyle(
                      color: theme.textTheme.titleLarge?.color ?? Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Notes(
                  partner: partner, // Use the correct partner instance
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
