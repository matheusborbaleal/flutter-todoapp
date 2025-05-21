import 'geo_point.dart';

class ToDoItem {
  final String title;
  final String taskDate;
  final GeoPoint? location;

  ToDoItem({required this.title, required this.taskDate, this.location});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'taskDate': taskDate,
      'location': location?.toMap(),
    };
  }

  factory ToDoItem.fromMap(Map<String, dynamic> map) {
    return ToDoItem(
      title: map['title'],
      taskDate: map['taskDate'],
      location:
          map['location'] != null ? GeoPoint.fromMap(map['location']) : null,
    );
  }
}
