// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoteModel _$NoteModelFromJson(Map<String, dynamic> json) => NoteModel(
      title: json['title'] as String,
      note: json['note'] as String,
      createdAt: json['created_at'] as String,
      id: json['id'] as String,
    );

Map<String, dynamic> _$NoteModelToJson(NoteModel instance) => <String, dynamic>{
      'title': instance.title,
      'note': instance.note,
      'created_at': instance.createdAt,
      'id': instance.id,
    };
