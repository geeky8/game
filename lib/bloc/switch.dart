import 'dart:async';

enum SwitchItem{LIST,GRID}

class SwitchBloc{
  final StreamController<SwitchItem> _controller = StreamController<SwitchItem>.broadcast();

  SwitchItem defaultItem = SwitchItem.LIST;

  Stream<SwitchItem> get itemStream => _controller.stream;

  void showList(){
    _controller.sink.add(SwitchItem.LIST);
  }

  void showGrid(){
    _controller.sink.add(SwitchItem.GRID);
  }

  close(){
    _controller?.close();
  }

}
final switchBloc = SwitchBloc();