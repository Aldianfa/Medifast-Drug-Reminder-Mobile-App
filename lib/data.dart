import 'package:uasmobile/constants/theme_data.dart';
import 'package:uasmobile/models/reminder_info.dart';

List<ReminderInfo> reminders = [
  ReminderInfo(reminderDateTime: DateTime.now().add(Duration(hours: 1)),
      title: 'Obat Lee', gradientColorIndex: 0),
  ReminderInfo(reminderDateTime: DateTime.now().add(Duration(hours: 2)),
      title: 'Olahraga Lee', gradientColorIndex: 1),
];
