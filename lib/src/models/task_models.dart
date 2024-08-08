class TaskModels {
  final String title;
  final String description;
  final String date;
  final int priority;

  TaskModels({
    required this.title,
    required this.description,
    required this.date,
    required this.priority,
  });

  // Convert a TaskModels object into a Map object
  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'date': date,
        'priority': priority,
      };

  // Create a TaskModels object from a Map object
  factory TaskModels.fromJson(Map<String, dynamic> json) => TaskModels(
        title: json['title'],
        description: json['description'],
        date: json['date'],
        priority: json['priority'],
      );
}
