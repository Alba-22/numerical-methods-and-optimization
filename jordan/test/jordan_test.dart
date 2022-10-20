import 'package:test/test.dart';

import '../bin/jordan.dart';

void main() {
  test(
    "Teste",
    () async {
      // Arrange
      final List<List<double>> matrix = [
        [1, 5, 1, 1],
        [5, 2, 3, 2],
        [2, 3, 2, 4],
      ];

      // Act
      final result = jordanMethod(matrix);

      // Assert
      print(result);
    },
  );
}
