class Task {
  late String id = "";
  late String title;
  late bool reminder;
  late String date;
  late bool isDone;
  late String icon;
  late String color;
  late String user;
  late int v;

  Task();

  Task.newTask({
    required this.title,
    required this.reminder,
    required this.date,
    required this.isDone,
    required this.icon,
    required this.color,
  });

  Task.fromJson(Map json) {
    this.id = json['_id'];
    this.title = json['title'];
    this.reminder = json['reminder'];
    this.date = json['date'];
    this.isDone = json['isDone'];
    this.icon = json['icon'];
    this.color = json['color'];
    this.user = json['user'];
    this.v = json['__v'];
  }

  Map toJson() => {
        'title': title,
        'reminder': reminder,
        'date': date,
        'isDone': isDone,
        'icon': icon,
        'color': color,
      };
}
