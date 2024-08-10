import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:t168/src/app/app.dart';
import 'package:t168/src/providers/add_task_provider/add_task_provider.dart';
import 'package:t168/src/providers/note_provider/note_provider.dart';
import 'package:t168/src/providers/partner_provider/partner_provider.dart';
import 'package:t168/src/providers/profile_provider/profile_provider.dart';

void main(List<String> args) {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AddTaskProvider>(
          create: (_) => AddTaskProvider(),
        ),
        ChangeNotifierProvider<PartnerProvider>(
          create: (_) => PartnerProvider(),
        ),
        ChangeNotifierProvider<ProfileProvider>(
          create: (_) => ProfileProvider(),
        ),
        ChangeNotifierProvider<NoteProvider>(
          create: (_) => NoteProvider(),
        ),
      ],
      child: const T168(),
    ),
  );
}
