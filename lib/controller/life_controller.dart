import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:machinetest/model/lift_model.dart';

class LiftController extends ChangeNotifier {
  int currentFloor = 4;
  String currentFloorText = "-1";
  bool isStarted = false;
  bool up = true;
  List<LiftModel> liftModel = [
    LiftModel("3", false, 0),
    LiftModel("2", false, 1),
    LiftModel("1", false, 2),
    LiftModel("0", false, 3),
    LiftModel("-1", true, 4),
  ];
  List<LiftModel> liftChangeModel = [
    LiftModel("3", false, 0),
    LiftModel("2", false, 1),
    LiftModel("1", false, 2),
    LiftModel("0", false, 3),
    LiftModel("-1", true, 4),
  ];

  changeFloor({required int floorIndex}) async {
    if (isStarted == false) {
      liftModel[floorIndex].isSelectedFloor = true;
      notifyListeners();
      await Future.delayed(const Duration(seconds: 3));
      changeFloorNumber(selectedFloor: floorIndex);
    }
  }

  changeFloorNumber({required selectedFloor}) async {
    isStarted = true;
    print("=========== SELECTED FLOOR ===========");
    print(selectedFloor);
    print("=========== CURRENT FLOOR ===========");
    print(currentFloor);
    List selectedFloorList = [];
    for (var element in liftModel) {
      if(element.isSelectedFloor == true && element.index != currentFloor){
        selectedFloorList.add(element.index);
      }
    }
    final largest = selectedFloorList.reduce((a, b) => a > b ? a : b);
    final smallest = selectedFloorList.reduce((a, b) => a < b ? a : b);

    if (largest > currentFloor) {
      for (int i = currentFloor; i < largest + 1; i++) {
        if (i == largest) {
          liftChangeModel[i].isSelectedFloor = true;
          currentFloorText = liftChangeModel[i].floorNumber;
          currentFloor = largest;
          for (var element in liftModel) {
            if(element.isSelectedFloor == true  && element.index != currentFloor ){
              changeFloorNumber(selectedFloor: element.index);
              break;
            }
          }
          notifyListeners();
          break;
        } else {
          liftChangeModel[i].isSelectedFloor = true;
          currentFloorText = liftChangeModel[i].floorNumber;
          notifyListeners();
          if (liftModel[i].isSelectedFloor == true && liftModel[i].index != currentFloor) {
            await Future.delayed(const Duration(seconds: 5));
          } else {
            await Future.delayed(const Duration(seconds: 1));
          }
          liftChangeModel[i].isSelectedFloor = false;
          liftModel[i].isSelectedFloor = false;
          currentFloor = i;
        }
      }
      isStarted = false;
      notifyListeners();
    } else {
      print("============= UP ============");
      for (int i = currentFloor; i >= smallest; i--) {
        if (i == smallest) {
          currentFloor = smallest;
          liftChangeModel[i].isSelectedFloor = true;
          currentFloorText = liftChangeModel[i].floorNumber;
          for (var element in liftModel) {
            if(element.isSelectedFloor == true  && element.index != currentFloor ){
              changeFloorNumber(selectedFloor: element.index);
              break;
            }
          }
          notifyListeners();
          break;
        } else {
          liftChangeModel[i].isSelectedFloor = true;
          currentFloorText = liftChangeModel[i].floorNumber;
          notifyListeners();
          if (liftModel[i].isSelectedFloor == true && liftModel[i].index != currentFloor) {
            await Future.delayed(const Duration(seconds: 5));
          } else {
            await Future.delayed(const Duration(seconds: 1));
          }
          liftChangeModel[i].isSelectedFloor = false;
          liftModel[i].isSelectedFloor = false;
        }
        notifyListeners();
      }
      isStarted = false;
      notifyListeners();
    }
  }
}
