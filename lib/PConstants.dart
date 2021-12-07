library p_constants;

import "dart:math" as math;

class PConstants {
  static const int OPEN = 0;
  static const int CLOSE = 1;

  static const int LINES = 1;
  static const int POINTS = 2;
  static const int POLYGON = 3;

  static const int SQUARE = 1 << 0; // called 'butt' in the svg spec
  static const int ROUND = 1 << 1;
  static const int PROJECT = 1 << 2; // called 'square' in the svg spec

  static const int MITER = 1 << 3;
  static const int BEVEL = 1 << 5;

  /// ( begin auto-generated from TWO_PI.xml )
  ///
  /// TWO_PI is a mathematical constant with the value 6.28318530717958647693.
  /// It is twice the ratio of the circumference of a circle to its diameter.
  /// It is useful in combination with the trigonometric functions
  /// <b>sin()</b> and <b>cos()</b>.
  ///
  /// ( end auto-generated )
  /// @webref constants
  /// @see PConstants#PI
  /// @see PConstants#TAU
  /// @see PConstants#HALF_PI
  /// @see PConstants#QUARTER_PI
  static const double TWO_PI = 2.0 * math.pi;

  /// ( begin auto-generated from TAU.xml )
  ///
  /// TAU is an alias for TWO_PI, a mathematical constant with the value
  /// 6.28318530717958647693. It is twice the ratio of the circumference
  /// of a circle to its diameter. It is useful in combination with the
  /// trigonometric functions <b>sin()</b> and <b>cos()</b>.
  ///
  /// ( end auto-generated )
  /// @webref constants
  /// @see PConstants#PI
  /// @see PConstants#TWO_PI
  /// @see PConstants#HALF_PI
  /// @see PConstants#QUARTER_PI
  static const double TAU = 2.0 * math.pi;
}
