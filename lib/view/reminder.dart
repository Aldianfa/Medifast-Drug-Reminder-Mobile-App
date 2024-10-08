import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:uasmobile/constants/theme_data.dart';
import 'package:intl/intl.dart';
import 'package:uasmobile/models/obat.dart';
import 'package:uasmobile/viewmodels/kopi_controller.dart';
import '../data.dart';
import '../main.dart';
import '../models/reminder_info.dart';
import '../viewmodels/reminder_helper.dart';

class reminderPage extends StatefulWidget {
  const reminderPage({super.key});

  @override
  State<reminderPage> createState() => _reminderPageState();
}

class _reminderPageState extends State<reminderPage> {
  @override
  DateTime? _reminderTime;
  String? _reminderTimeString;
  TextEditingController _titleController = TextEditingController();
  ReminderHelper _reminderHelper = ReminderHelper();
  Future<List<ReminderInfo>>? _reminders;
  List<ReminderInfo>? _currentReminders;
  int selectedValue = 0;

  var selectedObat = "";
  var obatList = <Obat>[];

  @override
  void initState() {
    _reminderTime = DateTime.now();
    _reminderHelper.initializeDatabase().then((value) {
      print('database intialized');
      loadReminders();
    });
    super.initState();
  }

  void loadReminders() {
    _reminders = _reminderHelper.getReminders();
    if (mounted) setState(() {});
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 23, 119, 247),
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Reminder',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Poppins'),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Pills Reminder",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.black87),
            ),
            SizedBox(
              height: 12,
            ),
            Expanded(
              child: FutureBuilder<List<ReminderInfo>>(
                future: _reminders,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    _currentReminders = snapshot.data!;
                    return ListView(
                      children: snapshot.data!.map<Widget>((reminder) {
                        var reminderTime = DateFormat('hh:mm aa')
                            .format(reminder.reminderDateTime!);
                        var gradientColor = GradientTemplate
                            .gradientTemplate[reminder.gradientColorIndex!]
                            .colors;
                        return Container(
                          margin: const EdgeInsets.only(bottom: 32),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: gradientColor,
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: gradientColor.last.withOpacity(0.4),
                                blurRadius: 8,
                                spreadRadius: 2,
                                offset: Offset(4, 4),
                              ),
                            ],
                            borderRadius: BorderRadius.all(Radius.circular(24)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.label,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        reminder.title!,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Switch(
                                    onChanged: (bool value) {},
                                    value: true,
                                    activeColor: Colors.white,
                                  ),
                                ],
                              ),
                              Text(
                                _titleController.text,
                                style: TextStyle(color: Colors.white),
                              ),
                              
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                selectedObat,
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                selectedValue.toString() + " jam per hari",
                                style: TextStyle(color: Colors.white),
                              ),
                                ]

                              ),
                              
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    reminderTime,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  IconButton(
                                      icon: Icon(Icons.delete),
                                      color: Colors.white,
                                      onPressed: () {
                                        deleteReminder(reminder.id!);
                                      }),
                                ],
                              ),
                            ],
                          ),
                        );
                      }).followedBy([
                        if (_currentReminders!.length < 5)
                          DottedBorder(
                            strokeWidth: 2,
                            color: Colors.blue.shade400,
                            borderType: BorderType.RRect,
                            radius: Radius.circular(24),
                            dashPattern: [5, 4],
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(24)),
                              ),
                              child: TextButton(
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all<
                                      EdgeInsetsGeometry>(
                                    EdgeInsets.symmetric(
                                        vertical: 16, horizontal: 0),
                                  ),
                                ),
                                // padding: const EdgeInsets.symmetric(
                                //     horizontal: 32, vertical: 16),
                                onPressed: () {
                                  _reminderTimeString = DateFormat('HH:mm')
                                      .format(DateTime.now());
                                  showModalBottomSheet(
                                    useRootNavigator: true,
                                    context: context,
                                    clipBehavior: Clip.antiAlias,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(24),
                                      ),
                                    ),
                                    builder: (context) {
                                      return StatefulBuilder(
                                        builder: (context, setModalState) {
                                          return Container(
                                            padding: const EdgeInsets.all(32),
                                            child: Column(
                                              children: [
                                                TextButton(
                                                  onPressed: () async {
                                                    var selectedTime =
                                                        await showTimePicker(
                                                      context: context,
                                                      initialTime:
                                                          TimeOfDay.now(),
                                                    );
                                                    if (selectedTime != null) {
                                                      final now =
                                                          DateTime.now();
                                                      var selectedDateTime =
                                                          DateTime(
                                                              now.year,
                                                              now.month,
                                                              now.day,
                                                              selectedTime.hour,
                                                              selectedTime
                                                                  .minute);
                                                      _reminderTime =
                                                          selectedDateTime;
                                                      setModalState(() {
                                                        _reminderTimeString =
                                                            DateFormat('HH:mm')
                                                                .format(
                                                                    selectedDateTime);
                                                      });
                                                    }
                                                  },
                                                  child: Text(
                                                    _reminderTimeString!,
                                                    style:
                                                        TextStyle(fontSize: 32),
                                                  ),
                                                ),
                                                TextField(
                                                  decoration: InputDecoration(
                                                    labelText: 'Title',
                                                  ),
                                                  controller: _titleController,
                                                ),
                                                // ListTile(
                                                //   title: Text('Repeat'),
                                                //   trailing: Icon(
                                                //       Icons.arrow_forward_ios),
                                                // ),
                                                FutureBuilder<List<Obat>>(
                                                  future: service.fetchObat(),
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasData) {
                                                      // Extract the data from the snapshot
                                                      List<Obat> obatList =
                                                          snapshot.data!;

                                                      // Create a list of DropdownMenuItem widgets
                                                      List<
                                                              DropdownMenuItem<
                                                                  Obat>>
                                                          dropdownItems =
                                                          obatList.map((obat) {
                                                        return DropdownMenuItem<
                                                            Obat>(
                                                          value: obat,
                                                          child: Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child:
                                                                Text(obat.name!),
                                                          )
                                                              
                                                        );
                                                      }).toList();

                                                      return DropdownButton<
                                                          Obat>(
                                                        items: dropdownItems,
                                                        onChanged:
                                                            (selectedObat) {
                                                          setState(() {
                                                            this.selectedObat =
                                                                selectedObat!
                                                                    .name;
                                                          });
                                                        },
                                                        hint: Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text('Obat'),
                                                        ),
                                                        
                                                      );
                                                    } else if (snapshot
                                                        .hasError) {
                                                      return Text(
                                                          "${snapshot.error}");
                                                    }
                                                    return CircularProgressIndicator();
                                                  },
                                                ),
                                                selectedObat != null
                                                    ? Text(
                                                        '${selectedObat}')
                                                    : Container(),

                                                // ListTile(
                                                //   title: Text('Title'),
                                                //   trailing: Icon(
                                                //       Icons.arrow_forward_ios),
                                                // ),

                                                SizedBox(height: 10),

                                                Row(
                                                  children: [
                                                    Text(
                                                      'Minum obat setiap ',
                                                    ),
                                                    DropdownButton<int>(
                                                      value: selectedValue,
                                                      onChanged:
                                                          (int? newValue) {
                                                        if (newValue != null) {
                                                          setState(() {
                                                            selectedValue =
                                                                newValue;
                                                          });
                                                          print(
                                                              'Anda memilih untuk minum obat setiap $selectedValue jam.');
                                                        }
                                                      },
                                                      items: List.generate(24,
                                                          (index) {
                                                        return DropdownMenuItem<
                                                            int>(
                                                          value: index,
                                                          child: Text(
                                                              '$index jam'),
                                                        );
                                                      }),
                                                    ),
                                                    Text(
                                                      'per hari',
                                                    ),
                                                  ],
                                                ),

                                                FloatingActionButton.extended(
                                                  onPressed: onSaveReminder,
                                                  icon: Icon(
                                                      Icons.alarm_add_rounded),
                                                  label: Text('Save'),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  );
                                },
                                child: Column(
                                  children: <Widget>[
                                    Image.asset(
                                      'assets/img/add_alarm.png',
                                      scale: 1.5,
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Add Reminder',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        else
                          Center(
                              child: Text(
                            'Only 5 reminders allowed!',
                            style: TextStyle(color: Colors.white),
                          )),
                      ]).toList(),
                    );
                  }
                  return Center(
                    child: Text(
                      'Loading..',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void scheduleReminder(
      DateTime scheduledNotificationDateTime, ReminderInfo reminderInfo) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      // 'reminder_notif',
      'reminder_notif',
      'Channel for Reminder notification',
      icon: 'codex_logo',
      sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
      largeIcon: DrawableResourceAndroidBitmap('codex_logo'),
    );

    var iOSPlatformChannelSpecifics = DarwinNotificationDetails(
        sound: 'a_long_cold_sting.wav',
        presentAlert: true,
        presentBadge: true,
        presentSound: true);
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationPlugin.schedule(
        0,
        'Reminder Minum Obat',
        _titleController.text,
        scheduledNotificationDateTime,
        platformChannelSpecifics);
  }

  void onSaveReminder() {
    DateTime scheduleReminderDateTime;
    if (_reminderTime!.isAfter(DateTime.now()))
      scheduleReminderDateTime = _reminderTime!;
    else
      scheduleReminderDateTime = _reminderTime!.add(Duration(days: 1));

    var reminderInfo = ReminderInfo(
      reminderDateTime: scheduleReminderDateTime,
      gradientColorIndex: _currentReminders!.length,
      title: 'reminder',
    );
    _reminderHelper.insertReminder(reminderInfo);
    scheduleReminder(scheduleReminderDateTime, reminderInfo);
    Navigator.pop(context);
    loadReminders();
  }

  void deleteReminder(int id) {
    _reminderHelper.delete(id);
    //unsubscribe for notification
    loadReminders();
  }
}
