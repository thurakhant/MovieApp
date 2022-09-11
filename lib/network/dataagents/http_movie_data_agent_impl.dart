import 'package:flutter/material.dart';
import 'package:movieapp/network/api_constants.dart';
import 'package:http/http.dart' as http;

import 'movie_data_agent.dart';

// class HttpMovieDataAgentImpl extends MovieDataAgent {
//   @override
//   void getNowPlayingMovies(int page) {
//     Map<String, String> queryParameters = {
//       PARAM_API_KEY: API_KEY,
//       PARAM_LANGUAGE: LANGUAGE_EN_US,
//       PARAM_PAGE: page.toString(),
//     };
//     var url = Uri.https(BASE_URL_HTTP, ENDPOINT_GET_NOW_PLAYING, queryParameters);
//     http.get(url).then((value) {
//       debugPrint('NowPlayingMovies ===> ${value.body.toString()}');
//     }).catchError((error) {
//       debugPrint('error ===> ${error.toString()}');
//     });
//   }
// }
