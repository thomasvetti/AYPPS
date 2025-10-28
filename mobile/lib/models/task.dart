class Task {
  final int id;
  String title;
  String? description;
  bool completed;

  Task({
    required this.id,
    required this.title,
    this.description,
    this.completed = false,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      completed: json['completed'],
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
    'completed': completed,
  };
}
