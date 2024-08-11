import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:t168/src/models/partners_models.dart';
import 'package:t168/src/providers/partner_provider/partner_provider.dart';

class Notes extends StatefulWidget {
  final PartnersModels partner;

  const Notes({
    super.key,
    required this.partner,
  });

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<PartnerProvider>(
        builder: (context, partnerProvider, child) {
          final partner = widget.partner;
          return ListView.builder(
            itemCount: partner.notes.length,
            itemBuilder: (context, index) {
              final note = partner.notes[index];
              return IntrinsicHeight(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.h),
                  child: Slidable(
                    key: ValueKey('$index-${note.note}'),
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SizedBox(width: 3.w),
                        GestureDetector(
                          onTap: () {
                            partnerProvider.removeNoteFromPartner(
                                partner, index);
                          },
                          child: Container(
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
                        ),
                      ],
                    ),
                    child: Center(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(5),
                        height: 15.h,
                        decoration: ShapeDecoration(
                          color: const Color(0xFF121212),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 1,
                              color: Colors.white.withOpacity(0.05),
                            ),
                          ),
                        ),
                        child: Text(
                          note.note,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
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
