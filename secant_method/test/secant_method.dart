import 'package:test/test.dart';

import '../bin/secant_method.dart';

void main() {
  test(
    "Teste do método da secante pra equação: x³ - x - 1",
    () async {
      // Arrange
      final List<double> polynomial = [1, 0, -1, -1];
      final double a = 1.5;
      final double b = 1.7;
      final double tolerance = 0.002;

      // Act
      final result = secantMethod(a, b, polynomial, tolerance);

      // Assert
      print(result.toString());
      expect(result.iterationsNeeded, 3);
    },
  );

  test(
    "Teste do método da secante pra equação: x2 + x - 6",
    () async {
      // Arrange
      final List<double> polynomial = [1, 1, -6];
      final double a = 1.5;
      final double b = 1.7;
      final double tolerance = 0.002;

      // Act
      final result = secantMethod(a, b, polynomial, tolerance);

      // Assert
      print(result.toString());
      expect(result.iterationsNeeded, 3);
    },
  );

  test(
    "Teste da evaluateExpression para x³ - x -1",
    () async {
      // Arrange
      final List<double> polynomial = [1, 0, -1, -1];
      final double a = 1;
      final double b = 2;

      // Act
      final fA = evaluateExpression(a, polynomial);
      final fB = evaluateExpression(b, polynomial);

      // Assert
      expect(fA, -1);
      expect(fB, 5);
    },
  );

  test(
    "Teste da evaluateWeightedAverage",
    () async {
      // Arrange
      final double a = 1;
      final double b = 2;
      final double fA = -1;
      final double fB = 5;

      // Act
      final result = evaluateWeightedAverage(a, b, fA, fB);

      // Assert
      expect(result, 1.1666666666666667);
    },
  );
}
