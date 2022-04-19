String nextBib({required String firstChar, required int number}) {
  number += 1;
  String numberString = '';
  if (number < 10) {
    numberString = '000$number'; // 0001 - 0009
  } else if (number < 100) {
    numberString = '00$number'; // 0010 - 0099
  } else if (number < 1000) {
    numberString = '0$number'; // 0100 - 0999
  } else {
    numberString = '$number'; // 1000 - 9999
  }

  return '$firstChar$numberString';
}
