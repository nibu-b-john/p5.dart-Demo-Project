library p_vector;

import 'dart:math' as math;

import 'p5applet.dart';
import 'constants.dart';

class P5Vector {
  double x = 0.0;
  double y = 0.0;
  double z = 0.0;

  static P5Vector zero() {
    return P5Vector(0, 0, 0);
  }

  P5Vector(double x, double y, [double z = 0.0]) {
    this.x = x;
    this.y = y;
    this.z = z;
  }

  /// Subtract one vector from another and store in another vector
  /// @param target P5Vector in which to store the result
  static P5Vector? sub3(P5Vector v1, P5Vector v2, P5Vector? target) {
    if (target == null) {
      target = P5Vector(v1.x - v2.x, v1.y - v2.y, v1.z - v2.z);
    } else {
      target.set(v1.x - v2.x, v1.y - v2.y, v1.z - v2.z);
    }
    return target;
  }

  /// ( begin auto-generated from P5Vector_sub.xml )
  ///
  /// Subtracts x, y, and z components from a vector, subtracts one vector
  /// from another, or subtracts two independent vectors. The version of the
  /// method that subtracts two vectors is a static method and returns a
  /// P5Vector, the others have no return value -- they act directly on the
  /// vector. See the examples for more context.
  ///
  /// ( end auto-generated )
  ///
  /// @webref P5Vector:method
  /// @usage web_application
  /// @param v any variable of type P5Vector
  /// @brief Subtract x, y, and z components from a vector, one vector from another, or two independent vectors
  P5Vector sub(P5Vector v) {
    x -= v.x;
    y -= v.y;
    z -= v.z;
    return this;
  }

  /// Subtract one vector from another
  /// @param v1 the x, y, and z components of a P5Vector object
  /// @param v2 the x, y, and z components of a P5Vector object
  static P5Vector? sub2(P5Vector v1, P5Vector v2) {
    return sub3(v1, v2, null);
  }

  /// ( begin auto-generated from P5Vector_add.xml )
  ///
  /// Adds x, y, and z components to a vector, adds one vector to another, or
  /// adds two independent vectors together. The version of the method that
  /// adds two vectors together is a static method and returns a P5Vector, the
  /// others have no return value -- they act directly on the vector. See the
  /// examples for more context.
  ///
  /// ( end auto-generated )
  ///
  /// @webref P5Vector:method
  /// @usage web_application
  /// @param v the vector to be added
  /// @brief Adds x, y, and z components to a vector, one vector to another, or two independent vectors
  P5Vector add(P5Vector v) {
    x += v.x;
    y += v.y;
    z += v.z;
    return this;
  }

  /// Add two vectors
  /// @param v1 a vector
  /// @param v2 another vector
  static P5Vector add2(P5Vector v1, P5Vector v2) {
    return add3(v1, v2, null);
  }

  /// Add two vectors into a target vector
  /// @param target the target vector (if null, a new vector will be created)
  static P5Vector add3(P5Vector v1, P5Vector v2, P5Vector? target) {
    if (target == null) {
      target = P5Vector(v1.x + v2.x, v1.y + v2.y, v1.z + v2.z);
    } else {
      target.set(v1.x + v2.x, v1.y + v2.y, v1.z + v2.z);
    }
    return target;
  }

  /// ( begin auto-generated from P5Vector_mag.xml )
  ///
  /// Calculates the magnitude (length) of the vector and returns the result
  /// as a float (this is simply the equation <em>sqrt(x*x + y*y + z*z)</em>.)
  ///
  /// ( end auto-generated )
  ///
  /// @webref P5Vector:method
  /// @usage web_application
  /// @brief Calculate the magnitude of the vector
  /// @return magnitude (length) of the vector
  /// @see P5Vector#magSq()
  double mag() {
    return math.sqrt(x * x + y * y + z * z);
  }

  /// ( begin auto-generated from P5Vector_normalize.xml )
  ///
  /// Normalize the vector to length 1 (make it a unit vector).
  ///
  /// ( end auto-generated )
  ///
  /// @webref P5Vector:method
  /// @usage web_application
  /// @brief Normalize the vector to a length of 1
  P5Vector normalize() {
    double m = mag();
    if (m != 0 && m != 1) {
      div(m);
    }
    return this;
  }

  /// ( begin auto-generated from P5Vector_mag.xml )
  ///
  /// Calculates the squared magnitude of the vector and returns the result
  /// as a float (this is simply the equation <em>(x*x + y*y + z*z)</em>.)
  /// Faster if the real length is not required in the
  /// case of comparing vectors, etc.
  ///
  /// ( end auto-generated )
  ///
  /// @webref P5Vector:method
  /// @usage web_application
  /// @brief Calculate the magnitude of the vector, squared
  /// @return squared magnitude of the vector
  /// @see P5Vector#mag()
  double magSq() {
    return (x * x + y * y + z * z);
  }

  /// ( begin auto-generated from P5Vector_limit.xml )
  ///
  /// Limit the magnitude of this vector to the value used for the <b>max</b> parameter.
  ///
  /// ( end auto-generated )
  ///
  /// @webref P5Vector:method
  /// @usage web_application
  /// @param max the maximum magnitude for the vector
  /// @brief Limit the magnitude of the vector
  P5Vector limit(double max) {
    if (magSq() > max * max) {
      normalize();
      mult(max);
    }
    return this;
  }

  /// ( begin auto-generated from P5Vector_mult.xml )
  ///
  /// Multiplies a vector by a scalar or multiplies one vector by another.
  ///
  /// ( end auto-generated )
  ///
  /// @webref P5Vector:method
  /// @usage web_application
  /// @brief Multiply a vector by a scalar
  /// @param n the number to multiply with the vector
  P5Vector mult(double n) {
    x *= n;
    y *= n;
    z *= n;
    return this;
  }

  /// ( begin auto-generated from P5Vector_div.xml )
  ///
  /// Divides a vector by a scalar or divides one vector by another.
  ///
  /// ( end auto-generated )
  ///
  /// @webref P5Vector:method
  /// @usage web_application
  /// @brief Divide a vector by a scalar
  /// @param n the number by which to divide the vector
  P5Vector div(double n) {
    x /= n;
    y /= n;
    z /= n;
    return this;
  }

  /// ( begin auto-generated from P5Vector_set.xml )
  ///
  /// Sets the x, y, and z component of the vector using two or three separate
  /// variables, the data from a P5Vector, or the values from a float array.
  ///
  /// ( end auto-generated )
  ///
  /// @webref P5Vector:method
  /// @param x the x component of the vector
  /// @param y the y component of the vector
  /// @param z the z component of the vector
  /// @brief Set the components of the vector
  P5Vector set(double x, double y, double z) {
    this.x = x;
    this.y = y;
    this.z = z;
    return this;
  }

  /// Divide a vector by a scalar and store the result in another vector.
  /// @param target P5Vector in which to store the result
  static P5Vector? div3(P5Vector v, double n, P5Vector? target) {
    if (target == null) {
      target = P5Vector(v.x / n, v.y / n, v.z / n);
    } else {
      target.set(v.x / n, v.y / n, v.z / n);
    }
    return target;
  }

  /// Divide a vector by a scalar and return the result in a new vector.
  /// @param v the vector to divide by the scalar
  /// @return a new vector that is v1 / n
  static P5Vector? div2(P5Vector v, double n) {
    return div3(v, n, null);
  }

  /// ( begin auto-generated from P5Vector_copy.xml )
  ///
  /// Gets a copy of the vector, returns a P5Vector object.
  ///
  /// ( end auto-generated )
  ///
  /// @webref P5Vector:method
  /// @usage web_application
  /// @brief Get a copy of the vector
  P5Vector copy() {
    return P5Vector(x, y, z);
  }

  ///  @Deprecated use copy
  P5Vector get() {
    return copy();
  }

  /// ( begin auto-generated from P5Vector_dist.xml )
  ///
  /// Calculates the Euclidean distance between two points (considering a
  /// point as a vector object).
  ///
  /// ( end auto-generated )
  ///
  /// @webref P5Vector:method
  /// @usage web_application
  /// @param v the x, y, and z coordinates of a P5Vector
  /// @brief Calculate the distance between two points
  double dist(P5Vector v) {
    double dx = x - v.x;
    double dy = y - v.y;
    double dz = z - v.z;
    return math.sqrt(dx * dx + dy * dy + dz * dz);
  }

  /// @param v1 any variable of type P5Vector
  /// @param v2 any variable of type P5Vector
  /// @return the Euclidean distance between v1 and v2
  static double dist2(P5Vector v1, P5Vector v2) {
    double dx = v1.x - v2.x;
    double dy = v1.y - v2.y;
    double dz = v1.z - v2.z;
    return math.sqrt(dx * dx + dy * dy + dz * dz);
  }

  /// ( begin auto-generated from P5Vector_setMag.xml )
  ///
  /// Set the magnitude of this vector to the value used for the <b>len</b> parameter.
  ///
  /// ( end auto-generated )
  ///
  /// @webref P5Vector:method
  /// @usage web_application
  /// @param len the new length for this vector
  /// @brief Set the magnitude of the vector
  P5Vector setMag(double len) {
    normalize();
    mult(len);
    return this;
  }

  /// ( begin auto-generated from P5Vector_random2D.xml )
  ///
  /// Make a new 2D unit vector with a random direction.  If you pass in "this"
  /// as an argument, it will use the PApplet's random number generator.  You can
  /// also pass in a target P5Vector to fill.
  ///
  /// @webref P5Vector:method
  /// @usage web_application
  /// @return the random P5Vector
  /// @brief Make a new 2D unit vector with a random direction.
  /// @see P5Vector#random3D()
  static P5Vector random2D() {
    return random2D_v3(null, null);
  }

  /// Set a 2D vector to a random unit vector with a random direction
  /// @param target the target vector (if null, a new vector will be created)
  /// @return the random P5Vector
  static P5Vector random2D_v2(P5Vector target) {
    return random2D_v3(target, null);
  }

  /// Make a new 2D unit vector with a random direction. Pass in the parent
  /// PApplet if you want randomSeed() to work (and be predictable). Or leave
  /// it null and be... random.
  /// @return the random P5Vector
  static P5Vector random2D_v3(P5Vector? target, P5Applet? parent) {
    return (parent == null)
        ? fromAngle_v2(math.Random().nextDouble() * math.pi * 2, target)
        : fromAngle_v2(parent.random(Constants.TAU), target);
  }

  /// ( begin auto-generated from P5Vector_sub.xml )
  ///
  /// Make a new 2D unit vector from an angle.
  ///
  /// ( end auto-generated )
  ///
  /// @webref P5Vector:method
  /// @usage web_application
  /// @brief Make a new 2D unit vector from an angle
  /// @param angle the angle in radians
  /// @return the new unit P5Vector
  static P5Vector fromAngle(double angle) {
    return fromAngle_v2(angle, null);
  }

  /// Make a new 2D unit vector from an angle
  ///
  /// @param target the target vector (if null, a new vector will be created)
  /// @return the P5Vector
  static P5Vector fromAngle_v2(double angle, P5Vector? target) {
    if (target == null) {
      target = P5Vector(math.cos(angle), math.sin(angle));
    } else {
      target.set(math.cos(angle), math.sin(angle), 0);
    }
    return target;
  }

  P5Vector? operator -(P5Vector other) {
    return sub2(
      this,
      other,
    );
    // return Family([this, other]);
  }

  P5Vector operator +(P5Vector other) {
    return add2(
      this,
      other,
    );
    // return Family([this, other]);
  }
}
