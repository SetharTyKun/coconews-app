// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleModel _$ArticleModelFromJson(Map<String, dynamic> json) => ArticleModel(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  content: json['content'] as String,
  url: json['url'] as String,
  image: json['image'] as String,
  publishedAt: DateTime.parse(json['publishedAt'] as String),
  lang: json['lang'] as String,
  source: Source.fromJson(json['source'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ArticleModelToJson(ArticleModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'content': instance.content,
      'url': instance.url,
      'image': instance.image,
      'publishedAt': instance.publishedAt.toIso8601String(),
      'lang': instance.lang,
      'source': instance.source.toJson(),
    };

Source _$SourceFromJson(Map<String, dynamic> json) => Source(
  id: json['id'] as String,
  name: json['name'] as String,
  url: json['url'] as String,
);

Map<String, dynamic> _$SourceToJson(Source instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'url': instance.url,
};
