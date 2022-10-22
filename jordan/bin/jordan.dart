import 'dart:convert';
import 'dart:io';

void main() {
  List<List<double>> matrix = [];
  final variablesQuantity = readInt("Quantas variáveis terá o sistema? ");

  for (int row = 0; row < variablesQuantity; row++) {
    final List<double> rowItems = [];
    for (int col = 0; col < variablesQuantity + 1; col++) {
      final value = readDouble("Digite o coeficiente de [${row + 1}][${col + 1}]: ");
      rowItems.add(value);
    }
    matrix.add(rowItems);
  }

  final result = jordanMethod(matrix);

  print("Os valores das incógnitas são: ${result.map((e) => e.toStringAsFixed(3)).join(", ")}");
}

List<double> jordanMethod(List<List<double>> matrix) {
  // print("Matrix inicial:");
  // print(matrix);
  for (int iteration = 0; iteration < matrix.length; iteration++) {
    // print("Iteration: $iteration");

    for (int row = 0; row < matrix.length; row++) {
      double? numerator;
      double denominator = matrix[iteration][iteration];
      for (int col = iteration; col < matrix[row].length; col++) {
        if (row == iteration) {
          continue;
        } else {
          numerator ??= matrix[row][col];
          // print("Conta: {[$row][$col]} = ${matrix[row][col]} - (($numerator / $denominator) * ${matrix[iteration][col]})");
          matrix[row][col] = matrix[row][col] - ((numerator / denominator) * matrix[iteration][col]);
        }
      }
    }

    // Verificação de zero na diagonal principal
    final rowWithZero = getLineWhereMainDiagonalIsZero(matrix);

    if (rowWithZero != null) {
      if (rowWithZero == matrix.length - 1) {
        List<double> auxRow = matrix[rowWithZero - 1];
        matrix[rowWithZero - 1] = matrix[rowWithZero];
        matrix[rowWithZero] = auxRow;
      } else {
        List<double> auxRow = matrix[rowWithZero + 1];
        matrix[rowWithZero + 1] = matrix[rowWithZero];
        matrix[rowWithZero] = auxRow;
      }
    }

    // print("Matrix após iteração $iteration:");
    // print(matrix);
  }

  // print("Matrix final:");
  // print(matrix);

  List<double> result = [];

  for (int iteration = 0; iteration < matrix.length; iteration++) {
    result.add(matrix[iteration].last / matrix[iteration][iteration]);
  }

  return result;
}

int? getLineWhereMainDiagonalIsZero(List<List<double>> matrix) {
  for (int row = 0; row < matrix.length; row++) {
    for (int col = 0; col < matrix[row].length; col++) {
      // Se tem um zero numa diagonal principal e não é a última linha
      if (row == col && matrix[row][col] == 0) {
        return row;
      }
    }
  }

  return null;
}

double readDouble(String message, {String errorMessage = "Valor inválido"}) {
  stdout.write(message);
  final String? elementInput = stdin.readLineSync(encoding: utf8);
  if (elementInput == null || double.tryParse(elementInput) == null) {
    print(errorMessage);
    exit(0);
  }

  return double.parse(elementInput);
}

int readInt(String message, {String errorMessage = "Valor inválido"}) {
  stdout.write(message);
  final String? polynomialDegreeInput = stdin.readLineSync(encoding: utf8);
  if (polynomialDegreeInput == null || int.tryParse(polynomialDegreeInput) == null) {
    print(errorMessage);
    exit(0);
  }

  return int.parse(polynomialDegreeInput);
}
