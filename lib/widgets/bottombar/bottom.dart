import 'package:flutter/material.dart';

enum BottomData {
  Home,
  Chat,
  Profile,
}

class BottomBar extends StatelessWidget {
  BottomBar({this.onBtnClicked, this.currentPage});
  final Function onBtnClicked;
  final BottomData currentPage;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CustomNavItem(
            type: BottomData.Home,
            isActive: currentPage == BottomData.Home,
            onClicked: onBtnClicked,
          ),
          CustomNavItem(
            type: BottomData.Chat,
            onClicked: onBtnClicked,
            isActive: currentPage == BottomData.Chat,
          ),
          CustomNavItem(
            type: BottomData.Profile,
            isActive: currentPage == BottomData.Profile,
            onClicked: onBtnClicked,
          ),
        ],
      ),
    );
  }
}

class CustomNavItem extends StatelessWidget {
  CustomNavItem({this.type, this.isActive, this.onClicked});
  final BottomData type;
  final bool isActive;
  final Function onClicked;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: getTooltip(),
      icon: Icon(
        getIcon(),
        color: isActive ? Colors.black : Colors.black26,
      ),
      onPressed: () => onClicked(type),
    );
  }

  // ignore: missing_return
  IconData getIcon() {
    switch (type) {
      case BottomData.Home:
        return Icons.home;
      case BottomData.Chat:
        return Icons.message;
      case BottomData.Profile:
        return Icons.person;
    }
  }

  // ignore: missing_return
  String getTooltip() {
    switch (type) {
      case BottomData.Home:
        return 'Home';
      case BottomData.Chat:
        return 'Chat';
      case BottomData.Profile:
        return 'Profile';
    }
  }
}
