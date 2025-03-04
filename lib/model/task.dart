class Task {
  String content;
  DateTime timeStamp;
  bool isDone;

  Task({required this.content, required this.timeStamp, required this.isDone});

  factory Task.fromMap(Map task) {
    return Task(
      content: task["content"],
      timeStamp: task["timeStamp"],
      isDone: task["isDone"],
    );
  }

  Map toMap() {
    return {"content": content, "timeStamp": timeStamp, "isDone": isDone};
  }
}
