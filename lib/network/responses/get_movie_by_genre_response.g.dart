// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_movie_by_genre_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetMoviesByGenreResponse _$GetMoviesByGenreResponseFromJson(
        Map<String, dynamic> json) =>
    GetMoviesByGenreResponse(
      (json['items'] as List<dynamic>)
          .map((e) => MovieVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetMoviesByGenreResponseToJson(
        GetMoviesByGenreResponse instance) =>
    <String, dynamic>{
      'items': instance.items,
    };
