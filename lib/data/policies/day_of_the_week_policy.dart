import 'package:passat/domain/policies/day_of_the_week_policy_type.dart';

class DayOfTheWeekPolicy implements DayOfTheWeekPolicyType {
  @override
  String fullName(DateTime dateTime) {
    switch (dateTime.weekday) {
      case DateTime.monday:
        return 'Monday';
      case DateTime.tuesday:
        return 'Tuesday';
      case DateTime.wednesday:
        return 'Wednesday';
      case DateTime.thursday:
        return 'Thursday';
      case DateTime.friday:
        return 'Friday';
      case DateTime.saturday:
        return 'Saturday';
      case DateTime.sunday:
        return 'Sunday';
      default:
        assert(false, 'SOMETHING WRONG WITH DATETIME OBJECT');

        return '';
    }
  }

  @override
  String shortName(DateTime dateTime) {
    switch (dateTime.weekday) {
      case DateTime.monday:
        return 'Mon';
      case DateTime.tuesday:
        return 'Tue';
      case DateTime.wednesday:
        return 'Wed';
      case DateTime.thursday:
        return 'Thu';
      case DateTime.friday:
        return 'Fri';
      case DateTime.saturday:
        return 'Sat';
      case DateTime.sunday:
        return 'Sun';
      default:
        assert(false, 'SOMETHING WRONG WITH DATETIME OBJECT');

        return '';
    }
  }
}
