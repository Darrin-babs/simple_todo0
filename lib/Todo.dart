class Todo {
  final String title;
  final String description;
  final bool done;

  const Todo(this.title, this.description, this.done);
  
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