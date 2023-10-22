import 'package:flutter_test/flutter_test.dart';
import 'package:weather/core/utils/date_converter.dart';

void main() {
  group("Change ms to dateTime test", () {
    test('It should return proper 22-october date format', () {
      var result = DateConverter.changeDtToDateTime(1697963906); //22 october
      expect(result, 'Oct 22');
    });
    test('It should return 10-september proper date format', () {
      var result2 = DateConverter.changeDtToDateTime(1694335106); //10 september
      expect(result2, 'Sep 10');
    });
  });

    group("change dt to hour-minute test", () {
    test('It should return 12:08 PM ion HH:MM PM/AM format.', () {
      var result = DateConverter.changeDtToDateTimeHour(1697963906,12600); //12:08 PM
  
      expect(result.replaceAll(RegExp(r'\s+'), ''), equals('12:08 PM'.replaceAll(RegExp(r'\s+'), '')));
    });
    test('It should return 10-september proper date format', () {
      var result = DateConverter.changeDtToDateTimeHour(1697967443,12600); //1:07 PM
       expect(result.replaceAll(RegExp(r'\s+'), ''), equals('1:07 PM'.replaceAll(RegExp(r'\s+'), '')));
    });
  });
}
