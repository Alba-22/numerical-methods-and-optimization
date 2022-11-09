import 'package:test/test.dart';

import '../bin/sel.dart';

void main() {
  test(
    "Teste 1",
    () async {
      // Arrange
      final points = [
        Point(-1, 4),
        Point(0, 1),
        Point(2, -1),
      ];

      // Act
      final result = sel(points);

      // Assert
      print(result);
    },
  );

  test(
    "Teste 2",
    () async {
      // Arrange
      final points = [
        Point(2, 3),
        Point(2.5, 5),
        Point(4, 2),
        Point(6, 4.5),
      ];

      // Act
      final result = sel(points);

      // Assert
      print(result);
      // -39.6 | 40.04 | -11.33 | 0.98
    },
  );
}
