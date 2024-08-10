import 'package:flutter/material.dart';
import 'package:t168/src/models/partners_models.dart';

class PartnerProvider extends ChangeNotifier {
  final List<PartnersModels> _partners = [];

  List<PartnersModels> get partners => List.unmodifiable(_partners);

  void addPartner(PartnersModels partner) {
    _partners.add(partner);
    notifyListeners();
  }

  void removePartner(int index) {
    _partners.removeAt(index);
    notifyListeners();
  }

  void updatePartner(PartnersModels oldTask, PartnersModels newTask) {
    int index = _partners.indexOf(oldTask);
    if (index != -1) {
      _partners[index] = newTask;
      notifyListeners();
    }
  }
}
