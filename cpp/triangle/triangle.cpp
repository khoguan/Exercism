#include "triangle.h"
#include <stdexcept>

namespace triangle {

bool assert_valid_triangle(double a, double b, double c) {
    if (a <= 0 || b <= 0 || c <= 0) {
        throw std::domain_error("triangles with zero/negative sides are illegal");
    }
    if ((a + b <= c) || (b + c <= a) || (c + a <= b)) {
        throw std::domain_error("triangles violating triangle inequality are illegal");
    }
    return true;
}

bool is_equilateral(double a, double b, double c) {
    return a == b && b == c;
}
bool is_isosceles(double a, double b, double c) {
    return a == b || b == c || c == a;
}

flavor kind(double a, double b, double c) {
    assert_valid_triangle(a, b, c);
    if (is_equilateral(a, b, c)) return flavor::equilateral;
    if (is_isosceles(a, b, c)) return flavor::isosceles;
    return flavor::scalene;
}

}  // namespace triangle





