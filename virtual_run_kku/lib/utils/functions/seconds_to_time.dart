import 'dart:developer';

String intToTimeLeft(int value) {
  int h, m, s;

  h = value ~/ 3600;
  m = ((value - h * 3600)) ~/ 60;
  s = value - (h * 3600) - (m * 60);

  // String hourLeft = h.toString().length < 2 ? "0" + h.toString() : h.toString();
  String minuteLeft =
      m.toString().length < 2 ? "0" + m.toString() : m.toString();
  String secondsLeft =
      s.toString().length < 2 ? "0" + s.toString() : s.toString();

  // String result = "$hourLeft:$minuteLeft:$secondsLeft";
  String result = "$h:$minuteLeft:$secondsLeft";

  return result;
}

String addZeroToTime(int value) {
  return value.toString().length < 2
      ? "0" + value.toString()
      : value.toString();
}

int hhmmssToSeconds(String time) {
  int result = 0;

  var list = time.split(':').asMap().forEach(
    (index, value) {
      // print('index: $index');
      // print('value: $value');

      if (index == 0) {
        result += int.parse(value) * 3600;
      } else if (index == 1) {
        result += int.parse(value) * 60;
      } else {
        result += int.parse(value);
      }
    },
  );
  // print(list);
  print('result: $result');

  return result;
}
