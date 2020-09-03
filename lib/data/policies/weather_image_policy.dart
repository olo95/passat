import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:passat/domain/policies/weather_image_policy_type.dart';

class WeatherImagePolicy implements WeatherImagePolicyType {
  @override
  Widget get(String weatherNameAbbr) {
    switch (weatherNameAbbr) {
      case 'c':
        return SvgPicture.asset('assets/c.svg');
      case 'h':
        return SvgPicture.asset('assets/h.svg');
      case 'hc':
        return SvgPicture.asset('assets/hc.svg');
      case 'hr':
        return SvgPicture.asset('assets/hr.svg');
      case 'lc':
        return SvgPicture.asset('assets/lc.svg');
      case 'lr':
        return SvgPicture.asset('assets/lr.svg');
      case 's':
        return SvgPicture.asset('assets/s.svg');
      case 'sl':
        return SvgPicture.asset('assets/sl.svg');
      case 'sn':
        return SvgPicture.asset('assets/sn.svg');
      case 't':
        return SvgPicture.asset('assets/t.svg');
      default:
        assert(false, 'Incorrect value of abbreviation');

        return null;
    }
  }
}
