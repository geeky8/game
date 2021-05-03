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

class DiscoverScreenGrid extends StatefulWidget {
  @override
  _DiscoverScreenGridState createState() => _DiscoverScreenGridState();
}

class _DiscoverScreenGridState extends State<DiscoverScreenGrid> {

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
            return buildGamesGrid(snapshot.data);
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
  Widget buildGamesGrid(GameResponse data){
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
          child: AnimationLimiter(
            child: Padding(
              padding: EdgeInsets.only(top: 10,left: 10,right: 10,),
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.75,
                children: List.generate(
                    games.length,
                    (int index){
                      return AnimationConfiguration.staggeredGrid(
                          position: index,
                          columnCount: 3,
                          duration: Duration(
                            milliseconds: 370,
                          ),
                          child: ScaleAnimation(
                            child: FadeInAnimation(
                              child: GestureDetector(
                                onTap: (){},
                                child: Stack(
                                  children: [
                                    Hero(
                                        tag: games[index],
                                        child: AspectRatio(
                                          aspectRatio: 3/4,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(5),),
                                              image: DecorationImage(
                                                image: NetworkImage("https://images.igdb.com/igdb/image/upload/t_cover_big/${games[index].cover.imageId}.jpg"),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                    ),
                                    AspectRatio(
                                        aspectRatio: 3/4,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(5),),
                                            gradient: LinearGradient(
                                                begin: Alignment.bottomCenter,
                                                end: Alignment.topCenter,
                                                colors: [
                                                  Colors.black.withOpacity(0.9),
                                                  Colors.black.withOpacity(0.0),
                                                ],
                                                stops:[
                                                  0.0,
                                                  0.5,
                                                ]
                                            ),
                                          ),
                                        ),
                                    ),
                                    Positioned(
                                        bottom: 20,
                                        left: 5,
                                        child: Container(
                                          width: 90,
                                          child: Text(
                                            games[index].name,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                    ),
                                    Positioned(
                                        bottom: 5,
                                        left: 5,
                                        child: Row(
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
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                      );
                    }
                ),
              ),
            ),
          ),
      );
    }
  }
}
