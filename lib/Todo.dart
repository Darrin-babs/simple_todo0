class Todo {
  final String title;
  final String description;
  final bool done;

  const Todo({
    required this.title,
    required this.description,
    required this.done, required String id,
  });

  Todo.fromJson(Map<String, dynamic> json)
      : title = json["title"],
        description = json["description"],
        done = json["done"];

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "done": done,
      };
}
