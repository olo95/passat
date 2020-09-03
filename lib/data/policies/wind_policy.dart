import 'package:passat/domain/policies/wind_policy_type.dart';

class WindPolicy implements WindPolicyType {
  @override
  String asString(double value) => '${value.floor()} km/h';
}
