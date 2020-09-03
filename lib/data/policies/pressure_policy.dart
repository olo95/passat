import 'package:passat/domain/policies/pressure_policy_type.dart';

class PressurePolicy implements PressurePolicyType {

  @override
  String asString(double value) => '${value.floor()}hPa';
}