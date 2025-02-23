import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo.freezed.dart';
part 'todo.g.dart';

@freezed
class Todo with _$Todo {
  const factory Todo({
    int? id,
    required String text,
    required bool done,
  }) = _Todo;

  // json形式の変換
  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
}
