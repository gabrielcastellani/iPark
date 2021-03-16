import 'package:flutter/cupertino.dart';

class PageProvider {
  PageController _pageController;
  int _page = 0;

  PageProvider(this._pageController);

  void setPage(int value) {
    if (value == _page) return;

    _page = value;
    _pageController.jumpToPage(value);
  }

  int get currentPage => _page;
}
