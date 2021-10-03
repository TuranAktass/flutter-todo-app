class ToDo {
  int? id;
  String? title;
  String? text;
  DateTime? createdAt;
  bool? isImportant;
  bool? isCompleted;

  ToDo(this.title, this.text, this.isImportant) {
    createdAt = DateTime.now();
    isCompleted = false;
  }

  ToDo.completed(this.title, this.text, this.isImportant, this.isCompleted) {
    createdAt = DateTime.now();
  }
}
