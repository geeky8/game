import 'package:game/model/game_model/cover.dart';
import 'package:game/model/game_model/genre.dart';
import 'package:game/model/game_model/mode.dart';
import 'package:game/model/game_model/player_perspective.dart';
import 'package:game/model/game_model/screenshot.dart';
import 'package:game/model/game_model/video.dart';

class GameModel{
  final int id;
  final CoverModel cover;
  final int createdAt;
  final int firstrelease;
  final List<ModeModel> modes;
  final List<GenreModel> genres;
  final List<PlayerPerspectiveModel> perspectives;
  final double popularity;
  final List<ScreenShotModel> screenshots;
  final String summary;
  final List<VideoModel> videos;
  final String name;
  final double rating;

  GameModel(this.id,this.name,this.videos,this.genres,this.rating,this.popularity,this.cover,this.createdAt,this.firstrelease,this.modes,this.perspectives,this.screenshots,this.summary);

  GameModel.fromJSON(Map<String,dynamic> json):
      id = json["id"],
      cover = json["cover"],
      createdAt = json["created_at"],
      firstrelease = json["first_release_date"],
      modes = json["game_modes"] == null ? null :(json["game_modes"] as List).map((e) => ModeModel.fromJSON(e)).toList(),
      genres = json["genres"] == null ? null :(json["genres"] as List).map((e) => GenreModel.fromJSON(e)).toList(),
      perspectives = json["player_perspectives"] == null ? null :(json["player_perspectives"] as List).map((e) => PlayerPerspectiveModel.fromJSON(e)).toList(),
      popularity = json["popularity"],
      screenshots = json["game_modes"] == null ? null :(json["screenshots"] as List).map((e) => ScreenShotModel.fromJSON(e)).toList(),
      summary = json["summary"],
      videos = json["videos"] == null ? null :(json["videos"] as List).map((e) => VideoModel.fromJSON(e)).toList(),
      name = json["name"],
      rating = json["total_rating"];
}