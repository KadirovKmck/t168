import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:t168/src/models/note_model.dart';
import 'package:t168/src/models/partners_models.dart';

class PartnerProvider extends ChangeNotifier {
  final List<PartnersModels> _partners = [];
  final List<NoteModel> _notes = [];

  List<NoteModel> get notes => List.unmodifiable(_notes);
  List<PartnersModels> get partners => List.unmodifiable(_partners);

  PartnerProvider() {
    _loadPartnersFromCache();
  }

  void addPartner(PartnersModels partner) {
    _partners.add(partner);
    _savePartnersToCache();
    notifyListeners();
  }

  void addNoteToPartner(PartnersModels partner, NoteModel note) {
    int index = _partners.indexOf(partner);
    if (index != -1) {
      _partners[index] = _partners[index].copyWith(
        notes: [..._partners[index].notes, note],
      );
      _savePartnersToCache();
      notifyListeners();
    }
  }

  void removeNoteFromPartner(PartnersModels partner, int noteIndex) {
    int index = _partners.indexOf(partner);
    if (index != -1 && noteIndex < _partners[index].notes.length) {
      final updatedNotes = List<NoteModel>.from(_partners[index].notes)
        ..removeAt(noteIndex);
      _partners[index] = _partners[index].copyWith(
        notes: updatedNotes,
      );
      _savePartnersToCache();
      notifyListeners();
    }
  }

  void removePartner(int index) {
    _partners.removeAt(index);
    _savePartnersToCache();
    notifyListeners();
  }

  void updatePartner(PartnersModels oldTask, PartnersModels newTask) {
    int index = _partners.indexOf(oldTask);
    if (index != -1) {
      _partners[index] = newTask;
      _savePartnersToCache();
      notifyListeners();
    }
  }

  void _savePartnersToCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String encodedData = jsonEncode(
        _partners.map((partner) => partner.toJson()).toList(),
      );
      await prefs.setString('partners', encodedData);
    } catch (e) {
      print("Error saving partners to cache: $e");
    }
  }

  void _loadPartnersFromCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? partnersString = prefs.getString('partners');
      if (partnersString != null) {
        final List<dynamic> decodedData = jsonDecode(partnersString);
        _partners.clear();
        _partners
            .addAll(decodedData.map((json) => PartnersModels.fromJson(json)));
        notifyListeners();
      }
    } catch (e) {
      print("Error loading partners from cache: $e");
    }
  }
}
