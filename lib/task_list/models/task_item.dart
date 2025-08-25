class TaskItem {
  String id;
  String title;
  String description;

  TaskItem({
    this.id = "",
    required this.title,
    required this.description,
  });

  /// Empty constructor (all values empty)
  TaskItem.empty()
      : id = "",
        title = "",
        description = "";

  /// Convert object → JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }

  /// Convert JSON → object
  factory TaskItem.fromJson(Map<String, dynamic> json) {
    return TaskItem(
      id: json['id'] ?? "",
      title: json['title'] ?? "",
      description: json['description'] ?? "",
    );
  }

  /// Copy with new values
  TaskItem copyWith({
    String? id,
    String? title,
    String? description,
  }) {
    return TaskItem(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  /// Check if task is empty
  bool get isEmpty => id.isEmpty && title.isEmpty && description.isEmpty;

  /// Check if task has some content
  bool get isNotEmpty => !isEmpty;
}
