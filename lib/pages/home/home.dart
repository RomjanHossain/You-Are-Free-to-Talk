import 'package:flutter/material.dart';
import 'package:youarefreetotalk/pages/chat/chat.dart';
import 'package:youarefreetotalk/pages/home/mainhome.dart';
import 'package:youarefreetotalk/pages/profile/profile.dart';
import 'package:youarefreetotalk/widgets/bottombar/bottom.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BottomData _currentPage = BottomData.Home;
  PageController _controller = PageController();
  String _appBarText = 'Home';

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(_appBarText),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            PageView(
              controller: _controller,
              physics: NeverScrollableScrollPhysics(),
              children: [
                MainHomePage(),
                ChatPage(),
                ProfilePage(),
              ],
            ),
            Positioned(
              child: BottomBar(
                currentPage: _currentPage,
                onBtnClicked: (BottomData tab) {
                  setState(
                    () {
                      if (tab == BottomData.Home) {
                        _appBarText = 'Home';
                      } else if (tab == BottomData.Chat) {
                        _appBarText = 'Chat';
                      } else {
                        _appBarText = 'Profile';
                      }
                      _currentPage = tab;
                      _controller.animateToPage(
                        tab.index,
                        duration: Duration(milliseconds: 400),
                        curve: Curves.decelerate,
                      );
                    },
                  );
                },
              ),
              bottom: 0,
              left: 0,
              right: 0,
            ),
          ],
        ),
      ),
    );
  }
}
