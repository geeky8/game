import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:game/model/game_response.dart';
import 'package:http/http.dart' as http;

class GameRepository{
  static String mainUrl = "https://api.igdb.com/v4";
  var gameListUrl = '$mainUrl/games';
  final String apiKey = "xhj7xbv1bncgc6w9gticvdxazqx24w";
  final Dio _dio = Dio();

  Future<GameResponse> getGames(int platformId) async{
    var response = await _dio.post(
      gameListUrl,
        options: Options(
          headers: {
          "accept" : "application/json",
          "client-ID" : "$apiKey",
          "authorization":"Bearer psep7l2plb5fv7y9ehx8v10d2m1xij",
        },),
        data: "fields age_ratings,aggregated_rating,aggregated_rating_count,alternative_names,artworks,bundles,category,checksum,collection,cover,created_at,dlcs,expanded_games,expansions,external_games,first_release_date,follows,forks,franchise,franchises,game_engines,game_modes,genres,hypes,involved_companies,keywords,multiplayer_modes,name,parent_game,platforms,player_perspectives,ports,rating,rating_count,release_dates,remakes,remasters,screenshots,similar_games,slug,standalone_expansions,status,storyline,summary,tags,themes,total_rating,total_rating_count,updated_at,url,version_parent,version_title,videos,websites;"
    );
    print("${response.statusCode}");
    GameResponse.fromJSON(response.data);
  }

  Future<GameResponse> getSlider(int platformId) async{
    var response = await _dio.post(
        gameListUrl,
        options: Options(
          headers: {
            "accept" : "application/json",
            "client-ID" : "$apiKey",
            "authorization":"Bearer psep7l2plb5fv7y9ehx8v10d2m1xij",
          },),
        data: "fields age_ratings,aggregated_rating,aggregated_rating_count,alternative_names,artworks,bundles,category,checksum,collection,cover,created_at,dlcs,expanded_games,expansions,external_games,first_release_date,follows,forks,franchise,franchises,game_engines,game_modes,genres,hypes,involved_companies,keywords,multiplayer_modes,name,parent_game,platforms,player_perspectives,ports,rating,rating_count,release_dates,remakes,remasters,screenshots,similar_games,slug,standalone_expansions,status,storyline,summary,tags,themes,total_rating,total_rating_count,updated_at,url,version_parent,version_title,videos,websites;"
    );
    print("${response.statusCode}");
    print(response.data);
    // GameResponse.fromJSON(response.data);
  }
}