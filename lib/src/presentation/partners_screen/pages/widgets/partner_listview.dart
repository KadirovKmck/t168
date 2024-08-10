import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:t168/src/models/partners_models.dart';
import 'package:t168/src/presentation/partners_screen/pages/custom_partner/costom_partners.dart';
import 'package:t168/src/presentation/partners_screen/pages/edit/partner_edit.dart';
import 'package:t168/src/providers/partner_provider/partner_provider.dart';

class PartnerListView extends StatelessWidget {
  final List<PartnersModels> partners;

  const PartnerListView({
    super.key,
    required this.partners,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: partners.length,
      itemBuilder: (context, index) {
        final partner = partners[index];
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 1.h),
          child: Slidable(
            key: ValueKey(partner.companyName),
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SizedBox(
                  width: 2.5.w,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 10.w,
                        height: 5.h,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFC9271E),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(11.0),
                          child: SvgPicture.asset(
                            'assets/icons/good.svg',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PartnerEdit(partner: partner),
                          ),
                        );
                      },
                      child: Container(
                        width: 10.w,
                        height: 5.h,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFFF7A00),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SvgPicture.asset(
                            'assets/icons/edit.svg',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        context.read<PartnerProvider>().removePartner(index);
                      },
                      child: Container(
                        width: 10.w,
                        height: 5.h,
                        decoration: ShapeDecoration(
                          color: const Color(0xFF4D4D4D),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SvgPicture.asset(
                            'assets/icons/del.svg',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            child: IntrinsicHeight(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CostomPartners(
                        partners: partner,
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: ShapeDecoration(
                    color: const Color(0xFF121212),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                        color: Colors.white.withOpacity(0.05),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
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
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  partner.companyName,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w900,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _getStatusText(partner.status),
                                  style: const TextStyle(
                                    color: Color(0xFF34C565),
                                    fontSize: 10,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        partner.description,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Text(
                            '0 Notes',
                            style: TextStyle(
                              color: Color(0xFF34C565),
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            'since ${partner.startDate}',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  String _getStatusText(int status) {
    switch (status) {
      case 0:
        return 'PROCESS';
      case 1:
        return 'ACTIVELY';
      case 2:
        return 'SUSPENDED';
      case 3:
        return 'COMPLETED';
      default:
        return 'UNKNOWN';
    }
  }
}
