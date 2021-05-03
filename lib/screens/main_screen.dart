import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:game/bloc/switch.dart';
import 'package:game/style/theme.dart' as Style;
import 'package:game/widgets/home_slider.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  PageController _pageController;
  SwitchBloc _switchBloc;
  GlobalKey bottomNavigationKey = GlobalKey();

  @override
  void initState() {
    _pageController = PageController();
    _switchBloc = SwitchBloc();
    super.initState();
  }
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _showGrid(){
    _switchBloc.showGrid();
  }

  void_showList(){
    _switchBloc.showList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF20232a),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: Container(),
      ),
      body: SizedBox.expand(
        child: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: (index){
            setState(() {
              currentIndex = index;
            });
          },
          children: [
            SizedBox(
              height: 700,
              child: Column(
                children: [
                  HomeSlider(),
                ],
              ),
            ),
            Container(
              child: Center(child: Text("Screen 2")),
            ),
            Container(
              child: Center(child: Text("Screen 3")),
            ),
            Container(
              child: Center(child: Text("Screen 4")),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        child: BottomNavyBar(
          containerHeight: 56,
          backgroundColor: Style.Colors.backgroundColor,
          selectedIndex: currentIndex,
          onItemSelected: (index){
            setState(() {
              currentIndex =index;
            });
            _pageController.jumpToPage(index);
          },
          items: [
            BottomNavyBarItem(
                activeColor: Color(0xFF010101),
                title: Text(
                  "Discover",
                  style: TextStyle(
                    color: Style.Colors.mainColor,
                    fontSize: 13,
                  ),
                ),
              icon: Padding(
                padding: EdgeInsets.only(left: 5,),
                child: Icon(
                  SimpleLineIcons.game_controller,
                  size: 18,
                  color: currentIndex==0?Style.Colors.mainColor:Colors.white,
                ),
              )
            ),
            BottomNavyBarItem(
                activeColor: Color(0xFF010101),
                title: Text(
                  "Search",
                  style: TextStyle(
                    color: Style.Colors.mainColor,
                    fontSize: 13,
                  ),
                ),
                icon: Padding(
                  padding: EdgeInsets.only(left: 5,),
                  child: Icon(
                    SimpleLineIcons.magnifier,
                    size: 18,
                    color: currentIndex==1?Style.Colors.mainColor:Colors.white,
                  ),
                )
            ),
            BottomNavyBarItem(
                activeColor: Color(0xFF010101),
                title: Text(
                  "Consoles",
                  style: TextStyle(
                    color: Style.Colors.mainColor,
                    fontSize: 13,
                  ),
                ),
                icon: Padding(
                  padding: EdgeInsets.only(left: 5,),
                  child: Icon(
                    SimpleLineIcons.layers,
                    size: 18,
                    color: currentIndex==2?Style.Colors.mainColor:Colors.white,
                  ),
                )
            ),
            BottomNavyBarItem(
                activeColor: Color(0xFF010101),
                title: Text(
                  "Profile",
                  style: TextStyle(
                    color: Style.Colors.mainColor,
                    fontSize: 13,
                  ),
                ),
                icon: Padding(
                  padding: EdgeInsets.only(left: 5,),
                  child: Icon(
                    SimpleLineIcons.user,
                    size: 18,
                    color: currentIndex==4?Style.Colors.mainColor:Colors.white,
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}
