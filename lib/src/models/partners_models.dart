class PartnersModels {
  final String companyName;
  final String description;
  final String startDate;
  final String photo;
  final int status;

  PartnersModels({
    required this.companyName,
    required this.status,
    required this.description,
    required this.startDate,
    required this.photo,
  });

  Map<String, dynamic> toJson() {
    return {
      'companyName': companyName,
      'description': description,
      'startDate': startDate,
      'photo': photo,
      'status': status,
    };
  }

  factory PartnersModels.fromJson(Map<String, dynamic> json) {
    return PartnersModels(
      companyName: json['companyName'],
      description: json['description'],
      startDate: json['startDate'],
      photo: json['photo'],
      status: json['status'],
    );
  }

  PartnersModels copyWith({
    String? companyName,
    String? description,
    String? startDate,
    String? photo,
    int? status,
  }) {
    return PartnersModels(
      companyName: companyName ?? this.companyName,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      photo: photo ?? this.photo,
      status: status ?? this.status,
    );
  }
}
