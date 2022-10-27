import 'dart:convert';
import 'dart:io';
import 'dart:math';

typedef Matrix = List<List<double>>;

void main(List<String> arguments) {
  Matrix matrix = [];
  List<double> initialValues = [];
  late double tolerance;
  final variablesQuantity = readInt("Quantas variáveis terá o sistema? ");

  for (int row = 0; row < variablesQuantity; row++) {
    final List<double> rowItems = [];
    for (int col = 0; col < variablesQuantity + 1; col++) {
      final value = readDouble("Digite o coeficiente de [${row + 1}][${col + 1}]: ");
      rowItems.add(value);
    }
    matrix.add(rowItems);
  }

  for (int row = 0; row < variablesQuantity; row++) {
    final value = readDouble("Digite o valor inicial ${row + 1}: ");
    initialValues.add(value);
  }

  tolerance = readDouble("Digite o valor de tolerância: ");

  if (!sassenfeldConvergence(matrix)) {
    print("A matrix digitada não converge!");
  } else {
    final result = gaussSeidel(matrix, initialValues, tolerance);
    print("Os valores das variáveis são:");
    for (int i = 0; i < result.length; i++) {
      print("X${i + 1}: ${result[i]}");
    }
  }
}

List<double> gaussSeidel(Matrix matrix, List<double> initialValues, double tolerance) {
  final List<double> result = [...initialValues];

  while (true) {
    final lastValues = [...result];

    for (int row = 0; row < matrix.length; row++) {
      final identityElem = matrix[row][row];
      double sumOfOtherElements = 0;
      final b = matrix[row].last;

      for (int col = 0; col < matrix[row].length - 1; col++) {
        if (col != row) {
          final elem = matrix[row][col] * result[col] * -1;
          sumOfOtherElements += elem;
        }
      }

      final value = (1 / identityElem) * (b + sumOfOtherElements);
      // print("x${row + 1} = (1 / $identityElem) * ($b + $sumOfOtherElements) = $value");

      result[row] = value;
    }

    // Condição de Parada
    final currentMax = result.reduce(max);
    List<double> maxes = [];
    for (int i = 0; i < result.length; i++) {
      maxes.add(result[i] - lastValues[i]);
    }
    final numerator = maxes.reduce(max);
    if ((numerator / currentMax).abs() <= tolerance) {
      break;
    }
  }

  return result;
}

bool sassenfeldConvergence(Matrix matrix) {
  List<double> betas = List.generate(matrix.length, (index) => 1);

  for (int iteration = 0; iteration < matrix.length; iteration++) {
    final identityElem = (1 / matrix[iteration][iteration]).abs();
    List<double> otherElements = [];
    for (int col = 0; col < matrix[iteration].length - 1; col++) {
      if (col != iteration) {
        final elem = matrix[iteration][col].abs();

        otherElements.add(betas[col] * elem);
      }
    }

    final beta = identityElem * otherElements.reduce((value, element) => value + element);
    betas[iteration] = beta;
  }

  return betas.reduce(max) < 1;
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
