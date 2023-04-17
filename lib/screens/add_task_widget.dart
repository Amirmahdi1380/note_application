import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:time_pickerr/time_pickerr.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../data/task.dart';
import '../notification/notification.dart';
import '../utility/utility.dart';
import '../widgets/task_type_item.dart';

DateTime scheduleTime = DateTime.now();

class addTsakWidget extends StatefulWidget {
  addTsakWidget({Key? key}) : super(key: key);

  @override
  State<addTsakWidget> createState() => _addTsakWidgetState();
}

class _addTsakWidgetState extends State<addTsakWidget> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  DateTime? selectedTime;
  FocusNode negahban1 = FocusNode();
  FocusNode negahban2 = FocusNode();

  int SelectedType = 0;

  final TextEditingController controllerTaskTitle = TextEditingController();
  final TextEditingController controllerSubTaskTitle = TextEditingController();

  final box = Hive.box<Task>('taskBox');

  @override
  void initState() {
    super.initState();
    negahban1.addListener(() {
      setState(() {});
    });
    negahban2.addListener(
      () {
        setState(() {});
      },
    );

    //flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? Colors.white
          : Color(0xff424242),
      body: SafeArea(
        child: Center(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 44),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextField(
                    controller: controllerTaskTitle,
                    focusNode: negahban1,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      labelText: 'تسک ها',
                      labelStyle: TextStyle(
                        fontSize: 20,
                        color: negahban1.hasFocus
                            ? Color(0xff18DAA3)
                            : Colors.grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide:
                            BorderSide(color: Color(0xffC5C5C5), width: 3.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                        borderSide: BorderSide(
                          width: 3,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Color.fromARGB(255, 94, 92, 92)
                              : Color(0xff18DAA3),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 44),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextField(
                    controller: controllerSubTaskTitle,
                    maxLines: 3,
                    focusNode: negahban2,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      labelText: 'عنوان تسک ها',
                      labelStyle: TextStyle(
                        fontSize: 20,
                        color: negahban2.hasFocus
                            ? Color(0xff18DAA3)
                            : Colors.grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide:
                            BorderSide(color: Color(0xffC5C5C5), width: 3.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(
                          width: 3,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Color.fromARGB(255, 94, 92, 92)
                              : Color(0xff18DAA3),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // ElevatedButton(
              //   child: Text('Select Time'),
              //   onPressed: () => _selectTime(context),
              // ),
              // NotificationScreen()
              DatePickerTxt(),
              ScheduleBtn(),
              // Directionality(
              //   textDirection: TextDirection.rtl,
              //   child: CustomHourPicker(
              //     title: 'زمان تسک را مشخص کن',
              //     negativeButtonText: 'حذف کن',
              //     positiveButtonText: 'انتخاب زمان',
              //     elevation: 2,
              //     titleStyle: TextStyle(
              //       color: Theme.of(context).brightness == Brightness.dark
              //           ? Colors.white
              //           : Color(0xff18DAA3),
              //       fontSize: 22,
              //       fontWeight: FontWeight.bold,
              //     ),
              //     negativeButtonStyle: TextStyle(
              //         color: Theme.of(context).brightness == Brightness.dark
              //             ? Colors.white
              //             : Color(0xff18DAA3),
              //         fontSize: 22,
              //         fontWeight: FontWeight.bold),
              //     positiveButtonStyle: TextStyle(
              //         color: Theme.of(context).brightness == Brightness.dark
              //             ? Colors.white
              //             : Color(0xff18DAA3),
              //         fontSize: 22,
              //         fontWeight: FontWeight.bold),
              //     onPositivePressed: (context, time) {
              //       selectedTime = time;
              //       // DateTime dateTime = DateTime.now();
              //       Time timeEnd =
              //           Time(selectedTime!.hour, selectedTime!.minute);
              //     },
              //     onNegativePressed: (context) {},
              //   ),
              // ),

              Container(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: getTaskTypeList().length,
                  itemBuilder: ((context, index) {
                    return InkWell(
                      onTap: () {
                        setState(
                          () {
                            SelectedType = index;
                          },
                        );
                      },
                      child: taskTypeList(
                        taskType: getTaskTypeList()[index],
                        index: index,
                        selectedItem: SelectedType,
                      ),
                    );
                  }),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 80),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        size: 35,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        String task1 = controllerTaskTitle.text;
                        String task2 = controllerSubTaskTitle.text;
                        addTask(task1, task2);
                        Navigator.pop(context);
                      },
                      child: Text(
                        'اضافه کردن تسک',
                        style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Color(0xff18DAA3)
                              : Colors.black,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).brightness == Brightness.dark
                                ? Color.fromARGB(255, 94, 92, 92)
                                : Color(0xff18DAA3),
                        minimumSize: Size(200, 40),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  addTask(String task, String subTask) {
    var allTask = Task(
      title: task,
      subTitle: subTask,
      time: scheduleTime,
      taskType: getTaskTypeList()[SelectedType],
    );
    box.add(allTask);
    //print(box.get(1)!.title);
  }
}

class DatePickerTxt extends StatefulWidget {
  const DatePickerTxt({
    Key? key,
  }) : super(key: key);

  @override
  State<DatePickerTxt> createState() => _DatePickerTxtState();
}

class _DatePickerTxtState extends State<DatePickerTxt> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        DatePicker.showDateTimePicker(
          context,
          showTitleActions: true,
          onChanged: (date) => scheduleTime = date,
          onConfirm: (date) {},
        );
      },
      child: const Text(
        'Select Date Time',
        style: TextStyle(color: Colors.blue),
      ),
    );
  }
}

class ScheduleBtn extends StatelessWidget {
  const ScheduleBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text('Schedule notifications'),
      onPressed: () {
        debugPrint('Notification Scheduled for $scheduleTime');
        NotificationService().scheduleNotification(
          title: 'Scheduled Notification',
          body: '$scheduleTime',
          scheduledNotificationDateTime: scheduleTime,
        );
      },
    );
  }
}
