import 'package:json_annotation/json_annotation.dart';
import '../../data/vos/credit_vo.dart';

part 'get_credits_by_movies_response.g.dart';

@JsonSerializable()
class GetCreditsByMovieResponse{
  @JsonKey(name: 'id')
  int code;

  @JsonKey(name: 'cast')
  List<CreditVO> cast;


  GetCreditsByMovieResponse(this.code, this.cast);

  factory GetCreditsByMovieResponse.fromJson(Map<String,dynamic> json) => _$GetCreditsByMovieResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetCreditsByMovieResponseToJson(this);
}