library p_vector;

import 'dart:math' as math;

import 'PApplet.dart';
import 'PConstants.dart';

class PVector {
  double x = 0.0;
  double y = 0.0;
  double z = 0.0;

  static PVector zero() {
    return PVector(0, 0, 0);
  }

  PVector(double x, double y, [double z = 0.0]) {
    this.x = x;
    this.y = y;
    this.z = z;
  }
  /**
   * Subtract one vector from another and store in another vector
   * @param target PVector in which to store the result
   */
  static PVector sub3(PVector v1, PVector v2, PVector target) {
    if (target == null) {
      target = new PVector(v1.x - v2.x, v1.y - v2.y, v1.z - v2.z);
    } else {
      target.set(v1.x - v2.x, v1.y - v2.y, v1.z - v2.z);
    }
    return target;
  }

  /**
   * ( begin auto-generated from PVector_sub.xml )
   *
   * Subtracts x, y, and z components from a vector, subtracts one vector
   * from another, or subtracts two independent vectors. The version of the
   * method that subtracts two vectors is a static method and returns a
   * PVector, the others have no return value -- they act directly on the
   * vector. See the examples for more context.
   *
   * ( end auto-generated )
   *
   * @webref pvector:method
   * @usage web_application
   * @param v any variable of type PVector
   * @brief Subtract x, y, and z components from a vector, one vector from another, or two independent vectors
   */
  PVector sub(PVector v) {
    x -= v.x;
    y -= v.y;
    z -= v.z;
    return this;
  }

  /**
   * Subtract one vector from another
   * @param v1 the x, y, and z components of a PVector object
   * @param v2 the x, y, and z components of a PVector object
   */
  static PVector sub2(PVector v1, PVector v2) {
    return sub3(v1, v2, null);
  }

  /**
   * ( begin auto-generated from PVector_add.xml )
   *
   * Adds x, y, and z components to a vector, adds one vector to another, or
   * adds two independent vectors together. The version of the method that
   * adds two vectors together is a static method and returns a PVector, the
   * others have no return value -- they act directly on the vector. See the
   * examples for more context.
   *
   * ( end auto-generated )
   *
   * @webref pvector:method
   * @usage web_application
   * @param v the vector to be added
   * @brief Adds x, y, and z components to a vector, one vector to another, or two independent vectors
   */
  PVector add(PVector v) {
    x += v.x;
    y += v.y;
    z += v.z;
    return this;
  }

  /**
   * Add two vectors
   * @param v1 a vector
   * @param v2 another vector
   */
  static PVector add2(PVector v1, PVector v2) {
    return add3(v1, v2, null);
  }

  /**
   * Add two vectors into a target vector
   * @param target the target vector (if null, a new vector will be created)
   */
  static PVector add3(PVector v1, PVector v2, PVector target) {
    if (target == null) {
      target = new PVector(v1.x + v2.x, v1.y + v2.y, v1.z + v2.z);
    } else {
      target.set(v1.x + v2.x, v1.y + v2.y, v1.z + v2.z);
    }
    return target;
  }

  /**
   * ( begin auto-generated from PVector_mag.xml )
   *
   * Calculates the magnitude (length) of the vector and returns the result
   * as a float (this is simply the equation <em>sqrt(x*x + y*y + z*z)</em>.)
   *
   * ( end auto-generated )
   *
   * @webref pvector:method
   * @usage web_application
   * @brief Calculate the magnitude of the vector
   * @return magnitude (length) of the vector
   * @see PVector#magSq()
   */
  double mag() {
    return math.sqrt(x * x + y * y + z * z);
  }

  /**
   * ( begin auto-generated from PVector_normalize.xml )
   *
   * Normalize the vector to length 1 (make it a unit vector).
   *
   * ( end auto-generated )
   *
   * @webref pvector:method
   * @usage web_application
   * @brief Normalize the vector to a length of 1
   */
  PVector normalize() {
    double m = mag();
    if (m != 0 && m != 1) {
      div(m);
    }
    return this;
  }

  /**
   * ( begin auto-generated from PVector_mag.xml )
   *
   * Calculates the squared magnitude of the vector and returns the result
   * as a float (this is simply the equation <em>(x*x + y*y + z*z)</em>.)
   * Faster if the real length is not required in the
   * case of comparing vectors, etc.
   *
   * ( end auto-generated )
   *
   * @webref pvector:method
   * @usage web_application
   * @brief Calculate the magnitude of the vector, squared
   * @return squared magnitude of the vector
   * @see PVector#mag()
   */
  double magSq() {
    return (x * x + y * y + z * z);
  }

  /**
   * ( begin auto-generated from PVector_limit.xml )
   *
   * Limit the magnitude of this vector to the value used for the <b>max</b> parameter.
   *
   * ( end auto-generated )
   *
   * @webref pvector:method
   * @usage web_application
   * @param max the maximum magnitude for the vector
   * @brief Limit the magnitude of the vector
   */
  PVector limit(double max) {
    if (magSq() > max * max) {
      normalize();
      mult(max);
    }
    return this;
  }

  /**
   * ( begin auto-generated from PVector_mult.xml )
   *
   * Multiplies a vector by a scalar or multiplies one vector by another.
   *
   * ( end auto-generated )
   *
   * @webref pvector:method
   * @usage web_application
   * @brief Multiply a vector by a scalar
   * @param n the number to multiply with the vector
   */
  PVector mult(double n) {
    x *= n;
    y *= n;
    z *= n;
    return this;
  }

  /**
   * ( begin auto-generated from PVector_div.xml )
   *
   * Divides a vector by a scalar or divides one vector by another.
   *
   * ( end auto-generated )
   *
   * @webref pvector:method
   * @usage web_application
   * @brief Divide a vector by a scalar
   * @param n the number by which to divide the vector
   */
  PVector div(double n) {
    x /= n;
    y /= n;
    z /= n;
    return this;
  }

  /**
   * ( begin auto-generated from PVector_set.xml )
   *
   * Sets the x, y, and z component of the vector using two or three separate
   * variables, the data from a PVector, or the values from a float array.
   *
   * ( end auto-generated )
   *
   * @webref pvector:method
   * @param x the x component of the vector
   * @param y the y component of the vector
   * @param z the z component of the vector
   * @brief Set the components of the vector
   */
  PVector set(double x, double y, double z) {
    this.x = x;
    this.y = y;
    this.z = z;
    return this;
  }

  /**
   * Divide a vector by a scalar and store the result in another vector.
   * @param target PVector in which to store the result
   */
  static PVector div3(PVector v, double n, PVector target) {
    if (target == null) {
      target = new PVector(v.x / n, v.y / n, v.z / n);
    } else {
      target.set(v.x / n, v.y / n, v.z / n);
    }
    return target;
  }

  /**
   * Divide a vector by a scalar and return the result in a new vector.
   * @param v the vector to divide by the scalar
   * @return a new vector that is v1 / n
   */
  static PVector div2(PVector v, double n) {
    return div3(v, n, null);
  }

  /**
   * ( begin auto-generated from PVector_copy.xml )
   *
   * Gets a copy of the vector, returns a PVector object.
   *
   * ( end auto-generated )
   *
   * @webref pvector:method
   * @usage web_application
   * @brief Get a copy of the vector
   */
  PVector copy() {
    return new PVector(x, y, z);
  }

  ///  @Deprecated use copy
  PVector get() {
    return copy();
  }

  /**
   * ( begin auto-generated from PVector_dist.xml )
   *
   * Calculates the Euclidean distance between two points (considering a
   * point as a vector object).
   *
   * ( end auto-generated )
   *
   * @webref pvector:method
   * @usage web_application
   * @param v the x, y, and z coordinates of a PVector
   * @brief Calculate the distance between two points
   */
  double dist(PVector v) {
    double dx = x - v.x;
    double dy = y - v.y;
    double dz = z - v.z;
    return math.sqrt(dx * dx + dy * dy + dz * dz);
  }

  /**
   * @param v1 any variable of type PVector
   * @param v2 any variable of type PVector
   * @return the Euclidean distance between v1 and v2
   */
  static double dist2(PVector v1, PVector v2) {
    double dx = v1.x - v2.x;
    double dy = v1.y - v2.y;
    double dz = v1.z - v2.z;
    return math.sqrt(dx * dx + dy * dy + dz * dz);
  }

  /**
   * ( begin auto-generated from PVector_setMag.xml )
   *
   * Set the magnitude of this vector to the value used for the <b>len</b> parameter.
   *
   * ( end auto-generated )
   *
   * @webref pvector:method
   * @usage web_application
   * @param len the new length for this vector
   * @brief Set the magnitude of the vector
   */
  PVector setMag(double len) {
    normalize();
    mult(len);
    return this;
  }

  /**
   * ( begin auto-generated from PVector_random2D.xml )
   *
   * Make a new 2D unit vector with a random direction.  If you pass in "this"
   * as an argument, it will use the PApplet's random number generator.  You can
   * also pass in a target PVector to fill.
   *
   * @webref pvector:method
   * @usage web_application
   * @return the random PVector
   * @brief Make a new 2D unit vector with a random direction.
   * @see PVector#random3D()
   */
  static PVector random2D() {
    return random2D_v3(null, null);
  }

  /**
   * Set a 2D vector to a random unit vector with a random direction
   * @param target the target vector (if null, a new vector will be created)
   * @return the random PVector
   */
  static PVector random2D_v2(PVector target) {
    return random2D_v3(target, null);
  }

  /**
   * Make a new 2D unit vector with a random direction. Pass in the parent
   * PApplet if you want randomSeed() to work (and be predictable). Or leave
   * it null and be... random.
   * @return the random PVector
   */
  static PVector random2D_v3(PVector target, PApplet parent) {
    return (parent == null)
        ? fromAngle_v2(math.Random().nextDouble() * math.pi * 2, target)
        : fromAngle_v2(parent.random(PConstants.TAU), target);
  }

  /**
   * ( begin auto-generated from PVector_sub.xml )
   *
   * Make a new 2D unit vector from an angle.
   *
   * ( end auto-generated )
   *
   * @webref pvector:method
   * @usage web_application
   * @brief Make a new 2D unit vector from an angle
   * @param angle the angle in radians
   * @return the new unit PVector
   */
  static PVector fromAngle(double angle) {
    return fromAngle_v2(angle, null);
  }

  /**
   * Make a new 2D unit vector from an angle
   *
   * @param target the target vector (if null, a new vector will be created)
   * @return the PVector
   */
  static PVector fromAngle_v2(double angle, PVector target) {
    if (target == null) {
      target = new PVector(math.cos(angle), math.sin(angle));
    } else {
      target.set(math.cos(angle), math.sin(angle), 0);
    }
    return target;
  }

  PVector operator -(PVector other) {
    return sub2(
      this,
      other,
    );
    // return Family([this, other]);
  }

  PVector operator +(PVector other) {
    return add2(
      this,
      other,
    );
    // return Family([this, other]);
  }
}
