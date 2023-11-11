import 'package:flutter/foundation.dart';

class PracticeProvider with ChangeNotifier {
  bool? isEligible;
  String? eligibilityMessage="";
  List favlist = [];

  addtoList(Index){
    favlist.add(Index);
    notifyListeners();
  }

  removeFav(Index){
    favlist.remove(Index);
    notifyListeners();
  }

  void checkEligibility(int age){
    if (age >= 18) {
      isEligible = true;
      eligibilityMessage = "You are eligible";
      notifyListeners();
    }
    else{
      isEligible = false;
      eligibilityMessage = "Your are not eligible";
      notifyListeners();
    }
  }

}