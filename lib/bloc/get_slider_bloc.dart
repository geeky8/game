import 'package:game/model/game_response.dart';
import 'package:game/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class SliderBloc{
  final GameRepository _repository = GameRepository();
  final BehaviorSubject<GameResponse> _subject = BehaviorSubject<GameResponse>();

  getslider(int id) async{
    GameResponse response = await _repository.getSlider(id);
    _subject.sink.add(response);
  }
  dispose(){
    _subject.close();
  }

  BehaviorSubject<GameResponse> get subject => _subject;
}
final getSliderBloc = SliderBloc();