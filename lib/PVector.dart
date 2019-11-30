library p_vector;

class PVector {
  double x = 0.0;
  double y = 0.0;
  double z = 0.0;

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
   * Subtract one vector from another
   * @param v1 the x, y, and z components of a PVector object
   * @param v2 the x, y, and z components of a PVector object
   */
  static PVector sub2(PVector v1, PVector v2) {
    return sub3(v1, v2, null);
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
}
