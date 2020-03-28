import 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;
String getTimeFormated(Timestamp time){
    Map<int,String> calendar ={
      
    };
    var date = DateTime.fromMillisecondsSinceEpoch(time.millisecondsSinceEpoch);
    return '${date.hour}:${date.minute} - ${calendarStrs[date.weekday-1]},${date.day}-${date.month}-${date.year}';
}
List<String> calendarStrs = [
  'Mon',
  'Tue',
  'Wed',
  'Thu',
  'Fri',
  'Sat',
  'Sun'
];