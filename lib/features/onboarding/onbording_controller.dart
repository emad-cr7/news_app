import 'package:flutter/material.dart';

class OnbordingController with ChangeNotifier {

  PageController pageController = PageController();
  int currentIndex = 0;

  bool isLastPage = false ;

  void onPage(int index) {
        currentIndex = index;
        if (index == 2){
          isLastPage = true ;
        }else{
          isLastPage = false ;
        }
    notifyListeners();
  }

  void onPagecc(int index) {
    pageController.nextPage(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    notifyListeners();
  }
}
