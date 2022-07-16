class ReadList {
  List<String> notes;
  List<String> likedBy;
  List<String> disklikedBy;
  List<String> tags;
  List<String> join;
  String id;
  String title;
  String user;
  String logo;

  ReadList({
    required this.notes,
    required this.likedBy,
    required this.disklikedBy,
    required this.tags,
    required this.join,
    required this.id,
    required this.title,
    required this.logo,
    required this.user,
  });

  ReadList.fromJSON(Map<String, dynamic> json)
      : notes = List.from(json['notes']),
        likedBy = List.from(json['likedBy']),
        disklikedBy = List.from(json['dislikedBy']),
        tags = List.from(json['tags']),
        join = List.from(json['join']),
        id = json['_id'],
        title = json['title'],
        user = json['user'],
        logo = json['logo'] ?? 'N/A';
}
