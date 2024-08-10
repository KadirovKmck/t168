import 'package:t168/src/models/note_model.dart';

class PartnersModels {
  final String companyName;
  final String description;
  final String startDate;
  final String photo;
  final int status;
  final List<NoteModel> notes; // Добавляем список заметок

  PartnersModels({
    required this.companyName,
    required this.status,
    required this.description,
    required this.startDate,
    required this.photo,
    this.notes = const [], // Инициализируем пустым списком
  });

  Map<String, dynamic> toJson() {
    return {
      'companyName': companyName,
      'description': description,
      'startDate': startDate,
      'photo': photo,
      'status': status,
      'notes': notes
          .map((note) => note.toJson())
          .toList(), // Преобразование заметок в JSON
    };
  }

  factory PartnersModels.fromJson(Map<String, dynamic> json) {
    return PartnersModels(
      companyName: json['companyName'],
      description: json['description'],
      startDate: json['startDate'],
      photo: json['photo'],
      status: json['status'],
      notes: (json['notes'] as List)
          .map((noteJson) => NoteModel.fromJson(noteJson))
          .toList(),
    );
  }

  PartnersModels copyWith({
    String? companyName,
    String? description,
    String? startDate,
    String? photo,
    int? status,
    List<NoteModel>? notes,
  }) {
    return PartnersModels(
      companyName: companyName ?? this.companyName,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      photo: photo ?? this.photo,
      status: status ?? this.status,
      notes: notes ?? this.notes,
    );
  }
}
