import 'package:json_annotation/json_annotation.dart';

part 'note.g.dart';

@JsonSerializable()
class NoteModel {
  @JsonKey(name: "title")
  String title;
  @JsonKey(name: "note")
  String note;
  @JsonKey(name: "created_at")
  String createdAt;
  @JsonKey(name: "id")
  String id;

  NoteModel({
    required this.title,
    required this.note,
    required this.createdAt,
    required this.id,
  });

  NoteModel copyWith({
    String? title,
    String? note,
    String? createdAt,
    String? id,
  }) =>
      NoteModel(
        title: title ?? this.title,
        note: note ?? this.note,
        createdAt: createdAt ?? this.createdAt,
        id: id ?? this.id,
      );

  factory NoteModel.fromJson(Map<String, dynamic> json) =>
      _$NoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$NoteModelToJson(this);
}
