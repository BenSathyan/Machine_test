import 'package:flutter/material.dart';
import 'package:machinetest/controller/life_controller.dart';
import 'package:provider/provider.dart';

class Elevator extends StatefulWidget {
  const Elevator({Key? key}) : super(key: key);

  @override
  State<Elevator> createState() => _ElevatorState();
}

class _ElevatorState extends State<Elevator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<LiftController>(builder: (context, controller, child) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 100,
                      height: 80,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 2, //                   <--- border width here
                        ),
                        // border color
                      ),
                      child: Center(
                          child: Text(
                        controller.currentFloorText,
                        style: const TextStyle(fontSize: 50),
                      )),
                    ),
                    SizedBox(
                      height: 500,
                      width: 150,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (ctx, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white38.withOpacity(.3),
                                border: Border.all(
                                  color: controller.liftChangeModel[index]
                                          .isSelectedFloor
                                      ? Colors.blue
                                      : Colors.grey,
                                  width:
                                      3, //                   <--- border width here
                                ),
                                // border color
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(2),
                                // border width
                                child: Center(
                                    child: Text(
                                  controller.liftChangeModel[index].floorNumber,
                                  style: TextStyle(
                                      color: controller.liftChangeModel[index]
                                              .isSelectedFloor
                                          ? Colors.blue
                                          : Colors.black,
                                      fontSize: 18),
                                ) // inner content
                                    ),
                              ),
                            ),
                          );
                        },
                        itemCount: controller.liftChangeModel.length,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (ctx, index) {
                      return SimpleDialogOption(
                        onPressed: () {
                          controller.changeFloor(floorIndex: index);
                        },
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: controller.liftModel[index].isSelectedFloor
                                  ? Colors.blue
                                  : Colors.grey,
                              width:
                                  2, //                   <--- border width here
                            ),
                            color: controller.liftModel[index].isSelectedFloor
                                ? Colors.blue
                                : Colors.grey,
                            // border color
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2),
                            // border width
                            child: Container(
                              // or ClipRRect if you need to clip the content
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white38
                                    .withOpacity(.3), // inner circle color
                              ),
                              child: Center(
                                  child: Text(
                                controller.liftModel[index].floorNumber,
                                style: TextStyle(
                                    color: controller
                                            .liftModel[index].isSelectedFloor
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 18),
                              )), // inner content
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: controller.liftModel.length,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
