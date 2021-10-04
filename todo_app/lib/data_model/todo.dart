const String tableTodos = 'todos';

class ToDoFields {
  static final List<String> values = [
    id,
    title,
    text,
    category,
    createdAt,
    isCompleted,
    isImportant,
  ];

  static const String id = "_id";
  static const String title = "Title";
  static const String text = "Text";
  static const String category = "Category";
  static const String createdAt = "CreatedAt";
  static const String isCompleted = "IsCompleted";
  static const String isImportant = "IsImportant";
}

class ToDo {
  final int? id;
  final String title;
  final String text;
  final String category;
  final String createdAt;
  final int isImportant;
  final int isCompleted;

  const ToDo({
    this.id,
    required this.title,
    required this.text,
    required this.category,
    required this.createdAt,
    required this.isImportant,
    required this.isCompleted,
  });

  ToDo copy({
    int? id,
    String? title,
    String? text,
    String? category,
    String? createdAt,
    int? isImportant,
    int? isCompleted,
  }) =>
      ToDo(
          id: id ?? this.id,
          category: category ?? this.category,
          createdAt: createdAt ?? this.createdAt,
          isCompleted: isCompleted ?? this.isCompleted,
          isImportant: isImportant ?? this.isImportant,
          text: text ?? this.text,
          title: title ?? this.title);

  static ToDo fromJson(Map<String, Object?> json) => ToDo(
      id: json[ToDoFields.id] as int?,
      category: json[ToDoFields.category] as String,
      createdAt: json[ToDoFields.createdAt] as String,
      isCompleted: json[ToDoFields.isCompleted] as int,
      isImportant: json[ToDoFields.isImportant] as int,
      text: json[ToDoFields.text] as String,
      title: json[ToDoFields.title] as String);

  Map<String, Object?> toJson() => {
        ToDoFields.id: id,
        ToDoFields.title: title,
        ToDoFields.text: text,
        ToDoFields.category: category,
        ToDoFields.createdAt: createdAt,
        ToDoFields.isCompleted: isCompleted,
        ToDoFields.isImportant: isImportant,
      };
}
