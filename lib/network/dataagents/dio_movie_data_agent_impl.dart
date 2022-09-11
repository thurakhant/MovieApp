import 'package:flutter/material.dart';
import '../api_constants.dart';
import 'package:dio/dio.dart';

import 'movie_data_agent.dart';

// class DioMovieDateAgentImpl extends MovieDataAgent {
//   @override
//   void getNowPlayingMovies(int page) {
//     Map<String, String> queryParameters = {
//       PARAM_API_KEY: API_KEY,
//       PARAM_LANGUAGE: LANGUAGE_EN_US,
//       PARAM_PAGE: page.toString(),
//     };
//     Dio().get('$BASE_URL_DIO$ENDPOINT_GET_NOW_PLAYING', queryParameters: queryParameters).then((value) {
//       debugPrint('NowPlayingMovies ===> ${value.toString()}');
//     }).catchError((error) {
//       debugPrint('error ===> ${error.toString()}');
//     });
//   }
// }
