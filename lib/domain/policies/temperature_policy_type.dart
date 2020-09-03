abstract class TemperaturePolicyType {
  String inCelcius(double value);

  String inFahrenheit(double value);

  double fromCelciusToFahrenheit(double value);

  double fromFahrenheitToCelcius(double value);
}