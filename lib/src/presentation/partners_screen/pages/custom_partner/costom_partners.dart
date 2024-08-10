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

  @override
  void didChangeDependencies() {
    Provider.of<PartnerProvider>(context, listen: false);
    super.didChangeDependencies();
  }

  int selectedPriorityIndex = 1;

  @override
  Widget build(BuildContext context) {
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
          builder: (context, partnerProvider, child) => ContainerColor(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'since ${widget.partners.startDate}',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.3499999940395355),
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'IN THE ${getStatusText(widget.partners.status)}',
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
                    children: [
                      Container(
                        width: 12.w,
                        height: 6.h,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: widget.partners.photo.isNotEmpty
                                ? FileImage(File(widget.partners.photo))
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
                      Text(
                        widget.partners.companyName,
                        style: const TextStyle(
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
                    widget.partners.description,
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
                    selectedIndex: widget.partners.status,
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AddNote(),
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PartnerEdit(
                                partner: widget.partners,
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
                  const Notes(),
                ],
              ),
            ),
          ),
        ));
  }
}
