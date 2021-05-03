import 'package:game/model/game.dart';

class GameResponse{
  final List<GameModel> games;
  final String error;

  GameResponse(this.error,this.games);

  GameResponse.fromJSON(Map<String,dynamic> json):
      games = (json["results"] as List).map((e) => GameModel.fromJSON(e)).toList(),
      error = "";
  GameResponse.withError(String errorValue):
      games = [],
      error = errorValue;
}