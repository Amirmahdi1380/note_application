import 'package:flutter/material.dart';

import '../data/task_type.dart';

class taskTypeList extends StatelessWidget {
  taskTypeList(
      {Key? key,
      required this.taskType,
      required this.index,
      required this.selectedItem})
      : super(key: key);
  TaskType taskType;
  int index;
  int selectedItem;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: (selectedItem == index)
            ? Theme.of(context).primaryColor
            : Theme.of(context).dividerColor,
        border: Border.all(
          color: (selectedItem == index)
              ? Theme.of(context).selectedRowColor
              : Colors.transparent,
          width: 3,
        ),
      ),
      width: 140,
      margin: EdgeInsets.all(8),
      //color: Colors.green,
      child: Column(
        children: [
          Image.asset(taskType.image),
          Text(
            taskType.title,
            style: TextStyle(
              // color: (selectedItem == index)
              //     ? Theme.of(context).brightness == Brightness.dark
              //         ? Colors.white
              //         : Colors.black
              //     : Theme.of(context).brightness == Brightness.dark
              //         ? Colors.white
              //         : Colors.black,
              fontSize: (selectedItem == index) ? 22 : 18,
            ),
          ),
        ],
      ),
    );
  }
}
