import 'package:passat/domain/policies/temperature_policy_type.dart';

class TemperaturePolicy implements TemperaturePolicyType {
  @override
  String inCelcius(double value) => '${value.floor()}°C';

  @override
  String inFahrenheit(double value) => '${value.floor()}°F';

  @override
  double fromCelciusToFahrenheit(double value) => value * 1.8 + 32;

  @override
  double fromFahrenheitToCelcius(double value) => (value - 32) * 5 / 9;
}
