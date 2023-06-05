class TodoDataModel {
  final int? id;
  String title;
  String description;

  TodoDataModel({this.id, required this.title, required this.description});

  factory TodoDataModel.fromJson(Map<String, dynamic> json) {
    return TodoDataModel(
        id: json['id'], title: json['title'], description: json['description']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'todoDataModel{id: $id, title: $title, description: $description}';
  }

  // @override
  // String toString() {
  //   return 'todoDataModel{id: $id, title: $title, description: $description}';
  // }
}
