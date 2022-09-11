import 'package:json_annotation/json_annotation.dart';
import '../../data/vos/movie_vo.dart';

part 'get_movie_by_genre_response.g.dart';

@JsonSerializable()
class GetMoviesByGenreResponse{
  @JsonKey(name: 'items')
  List<MovieVO> items;

  GetMoviesByGenreResponse(this.items);

  factory GetMoviesByGenreResponse.fromJson(Map<String,dynamic> json) => _$GetMoviesByGenreResponseFromJson(json);

  Map<String,dynamic> toJson() => _$GetMoviesByGenreResponseToJson(this);


}