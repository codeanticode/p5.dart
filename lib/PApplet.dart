library p_applet;

import "dart:math" as math;

/* mixin */
abstract class PApplet {
  static double constrain(double amt, double low, double high) {
    return (amt < low) ? low : ((amt > high) ? high : amt);
  }

  math.Random? internalRandom;

  double random(double high) {
    // avoid an infinite loop when 0 or NaN are passed in
    if (high == 0 || high != high) {
      return 0;
    }

    internalRandom ??= math.Random();

    // for some reason (rounding error?) Math.random() * 3
    // can sometimes return '3' (once in ~30 million tries)
    // so a check was added to avoid the inclusion of 'howbig'
    double value = 0;
    do {
      value = internalRandom!.nextDouble() * high;
    } while (value == high);
    return value;
  }

  /// ( begin auto-generated from random.xml )
  ///
  /// Generates random numbers. Each time the <b>random()</b> function is
  /// called, it returns an unexpected value within the specified range. If
  /// one parameter is passed to the function it will return a <b>float</b>
  /// between zero and the value of the <b>high</b> parameter. The function
  /// call <b>random(5)</b> returns values between 0 and 5 (starting at zero,
  /// up to but not including 5). If two parameters are passed, it will return
  /// a <b>float</b> with a value between the the parameters. The function
  /// call <b>random(-5, 10.2)</b> returns values starting at -5 up to (but
  /// not including) 10.2. To convert a floating-point random number to an
  /// integer, use the <b>int()</b> function.
  ///
  /// ( end auto-generated )
  /// @webref math:random
  /// @param low lower limit
  /// @param high upper limit
  /// @see PApplet#randomSeed(long)
  /// @see PApplet#noise(float, float, float)
  double random2(double low, double high) {
    if (low >= high) return low;
    double diff = high - low;
    double value = 0;
    // because of rounding error, can't just add low, otherwise it may hit high
    // https://github.com/processing/processing/issues/4551
    do {
      value = random(diff) + low;
    } while (value == high);
    return value;
  }

  num radians(num angle) {
    return (angle / 180) * math.pi;
  }

  num degrees(num angle) {
    return (angle / math.pi) * 180;
  }

  static double map(
      double value, double start1, double stop1, double start2, double stop2) {
    double outgoing =
        start2 + (stop2 - start2) * ((value - start1) / (stop1 - start1));
    String? badness;
    if (outgoing != outgoing) {
      badness = "NaN (not a number)";
    } else if (outgoing == double.negativeInfinity ||
        outgoing == double.infinity) {
      badness = "infinity";
    }
    if (badness != null) {
      /*   final String msg =
        String.format("map(%s, %s, %s, %s, %s) called, which returns %s",
                      nf(value), nf(start1), nf(stop1),
                      nf(start2), nf(stop2), badness);
      PGraphics.showWarning(msg); */
    }
    return outgoing;
  }

/**
 * @nowebref
 */
/* public void smooth() {
    smooth(1);
  } */
}
