import 'package:test/test.dart';

import '../bin/gauss_seidel.dart';

void main() {
  test(
    "Teste de convergência 1",
    () async {
      // Arrange
      final Matrix matrix = [
        [2.0, 1.0, -0.2, 0.2, 0.4],
        [0.6, 3.0, -0.6, -0.3, -7.8],
        [-0.1, -0.2, 1.0, 0.2, 1.0],
        [0.4, 1.2, 0.8, 4.0, -10.0],
      ];

      // Act
      final result = sassenfeldConvergence(matrix);

      // Assert
      expect(result, true);
    },
  );

  test(
    "Teste de convergência 2",
    () async {
      // Arrange
      final Matrix matrix = [
        [2, 1, 1, 3],
        [-2, 2, -1, 0],
        [3, 1, 1, 1],
      ];

      // Act
      final result = sassenfeldConvergence(matrix);

      // Assert
      expect(result, false);
    },
  );

  test(
    "Teste de convergência 3",
    () async {
      // Arrange
      final Matrix matrix = [
        [45, 2, 3, 58],
        [-3, 22, 2, 47],
        [5, 1, 20, 67],
      ];

      // Act
      final result = sassenfeldConvergence(matrix);

      // Assert
      expect(result, true);
    },
  );

  test(
    "Teste para Gauss-Seidel",
    () async {
      // Arrange
      final Matrix matrix = [
        [5, 1, 1, 5],
        [3, 4, 1, 6],
        [3, 3, 6, 0],
      ];
      final List<double> initialValues = [-1, 0, 1];
      final double tolerance = 0.05;

      // Act
      final result = gaussSeidel(matrix, initialValues, tolerance);

      // Assert
      print(result);
    },
  );

  test(
    "Teste 2 para Gauss-Seidel",
    () async {
      // Arrange
      final Matrix matrix = [
        [2, 3, 1, 4],
        [4, 6, -2, 6],
        [2, 3, 4, 2],
      ];
      final List<double> initialValues = [0, 0, 0];
      final double tolerance = 0.002;

      // Act
      final result = gaussSeidel(matrix, initialValues, tolerance);

      // Assert
      print(result);
    },
  );

  test(
    "Teste 3 para Gauss-Seidel",
    () async {
      // Arrange
      final Matrix matrix = [
        [45, 2, 3, 58],
        [-3, 22, 2, 47],
        [5, 1, 20, 67],
      ];
      final List<double> initialValues = [0, 0, 0];
      final double tolerance = 0.0005;

      // Act
      final result = gaussSeidel(matrix, initialValues, tolerance);

      // Assert
      print(result);
    },
  );
}
