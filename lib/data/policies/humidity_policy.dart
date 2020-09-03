import 'package:passat/domain/policies/humidity_policy_type.dart';

class HumidityPolicy implements HumidityPolicyType {

  @override
  String asString(int value) => '$value%';
}