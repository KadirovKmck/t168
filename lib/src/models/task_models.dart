class TaskModels {
  String title;
  String description;
  final String date;
  final int priority;

  TaskModels({
    required this.title,
    required this.description,
    required this.date,
    required this.priority,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'date': date,
        'priority': priority,
      };

  factory TaskModels.fromJson(Map<String, dynamic> json) => TaskModels(
        title: json['title'],
        description: json['description'],
        date: json['date'],
        priority: json['priority'],
      );
}
