import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:game/bloc/get_games_bloc.dart';
import 'package:game/elements/build_error.dart';
import 'package:game/elements/build_loading.dart';
import 'package:game/model/game.dart';
import 'package:game/model/game_response.dart';
import 'package:game/style/theme.dart' as Style;

class DiscoverScreensList extends StatefulWidget {
  @override
  _DiscoverScreensListState createState() => _DiscoverScreensListState();
}

class _DiscoverScreensListState extends State<DiscoverScreensList> {

  @override
  void initState() {
    getgamesBloc..getGames(48);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<GameResponse>(
        stream: getgamesBloc.subject.stream,
        builder: (context, AsyncSnapshot<GameResponse> snapshot){
          if(snapshot.hasData){
            if(snapshot.data.error !=null && snapshot.data.error.length>0){
              return buildError(snapshot.data.error);
            }
            return buildGamesList(snapshot.data);
          }
          else if(snapshot.error){
            return buildError(snapshot.error);
          }
          else{
            buildLoading();
          }
        }
    );
  }
  Widget buildGamesList(GameResponse data){
    List<GameModel> games = data.games;
    if(games.length==0){
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Text(
              "NO GAMES",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
      );
    }
    else{
      return AnimationLimiter(
          child: ListView.builder(
              itemBuilder: (BuildContext context, int index){
                return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: Duration(
                      milliseconds: 400,
                    ),
                    child: SlideAnimation(
                      verticalOffset: 50,
                      child: FadeInAnimation(
                        child: GestureDetector(
                          onTap: (){},
                          child: Container(
                            padding: EdgeInsets.only(top: 15,left: 10,right: 10,),
                            height: 150,
                            child: Row(
                              children: [
                                Hero(
                                  tag: games[index].id,
                                  child: AspectRatio(
                                    aspectRatio: 3/4,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(5)),
                                        image: DecorationImage(image: NetworkImage("https://images.igdb.com/igdb/image/upload/t_cover_big/${games[index].cover.imageId}.jpg"),fit: BoxFit.cover),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              games[index].name,
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: false,
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 5,),
                                            Text(
                                              games[index].summary,
                                              maxLines: 4,
                                              style: TextStyle(
                                                color: Colors.white.withOpacity(0.2),
                                                fontSize: 12,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                RatingBar.builder(
                                                    itemSize: 6,
                                                    initialRating: games[index].rating/20,
                                                    minRating: 1,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    itemPadding: EdgeInsets.symmetric(horizontal: 1,),
                                                    itemBuilder: (context,_)=>Icon(
                                                      EvaIcons.star,
                                                      color: Style.Colors.secondaryColor,
                                                    ),
                                                    onRatingUpdate: (rating){
                                                      print(rating);
                                                    }
                                                ),
                                                SizedBox(width: 3,),
                                                Text(
                                                  (games[index].rating/20).toString().substring(0,3),
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                );
              }
          ),
      );
    }
  }
}
