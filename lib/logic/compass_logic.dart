import 'dart:math' as math;

class CompassLogic {
  String getCardinalDirection(double heading) {
    if (heading >= 337.5 || heading < 22.5) {
      return 'North (N)';
    } else if (heading >= 22.5 && heading < 67.5) {
      return 'North-East (NE)';
    } else if (heading >= 67.5 && heading < 112.5) {
      return 'East (E)';
    } else if (heading >= 112.5 && heading < 157.5) {
      return 'South-East (SE)';
    } else if (heading >= 157.5 && heading < 202.5) {
      return 'South (S)';
    } else if (heading >= 202.5 && heading < 247.5) {
      return 'South-West (SW)';
    } else if (heading >= 247.5 && heading < 292.5) {
      return 'West (W)';
    } else if (heading >= 292.5 && heading < 337.5) {
      return 'North-West (NW)';
    }
    return '';
  }

  double getRotationAngle(double heading) {
    return heading * (math.pi / 180) * -1;
  }
}
