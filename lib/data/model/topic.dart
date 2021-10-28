import 'package:json_annotation/json_annotation.dart';

part 'topic.g.dart';

@JsonSerializable()
class Topic {
  final String name;
  final String image;

  Topic({
    required this.name,
    required this.image,
  });

  factory Topic.fromJson(Map<String, dynamic> json) =>
      _$TopicFromJson(json);

  Map<String, dynamic> toJson() => _$TopicToJson(this);
}
