import 'package:notesriver_mobile/models/readlist.model.dart';

class NotesModel {
  String id;
  String title;
  String desc;
  List<String> tags;
  List<String> filePath;
  List<String> likedBy;
  List<String> dislikedBy;
  String createAt;
  ReadList readList;

  NotesModel({
    required this.id,
    required this.readList,
    required this.title,
    required this.desc,
    required this.tags,
    required this.filePath,
    required this.likedBy,
    required this.dislikedBy,
    required this.createAt,
  });

  NotesModel.fromJSON(Map<String, dynamic> json)
      : id = json["_id"],
        title = json["title"],
        desc = json["desc"],
        tags = List.from(json["tags"]),
        filePath = List.from(json["filePath"]),
        likedBy = List.from(json["likedBy"]),
        dislikedBy = List.from(json["dislikedBy"]),
        createAt = json["createdAt"],
        readList = ReadList.fromJSON(json["readList"]);
}
