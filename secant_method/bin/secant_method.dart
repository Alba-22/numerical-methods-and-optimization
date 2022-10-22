// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';
import 'dart:math';

void main() {
  List<double> polynomial = [];
  late double a;
  late double b;
  late final double tolerance;

  final int polynimalDegree = readInt("Escreva o grau do polinômio: ", errorMessage: "Grau de polinômio inválido");

  for (int i = 0; i < polynimalDegree + 1; i++) {
    final element = readDouble("Digite a constante do elemento ${polynimalDegree - i}: ");
    polynomial.add(element);
  }

  a = readDouble("Digite o valor de início do intervalo: ");
  b = readDouble("Digite o valor de fim do intervalo: ");
  tolerance = readDouble("Digite o valor de tolerância: ");

  final result = secantMethod(a, b, polynomial, tolerance);

  if (result.value != null && result.rootError != null) {
    print("Raiz encontrada: ${result.value}");
    print("Erro: ${result.rootError}");
    print("Iterações necessárias: ${result.iterationsNeeded}");
  } else {
    print("Não é possível determinar a existência de uma raíz real no polinômio dado");
  }
}

double evaluateExpression(double x, List<double> polynomial) {
  double output = 0;
  for (int i = 0; i < polynomial.length; i++) {
    final double constant = polynomial[i];
    final int degree = polynomial.length - i - 1;
    output += pow(x, degree) * constant;
  }
  return output;
}

double evaluateWeightedAverage(double a, double b, double fA, double fB) {
  return ((a * fB) - (b * fA)) / (fB - fA);
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

Output secantMethod(double a, double b, List<double> polynomial, double tolerance) {
  int iterations = 1;
  double? outputValue;

  double x0 = a;
  double x1 = b;

  while (true) {
    double fX0 = evaluateExpression(x0, polynomial);
    double fX1 = evaluateExpression(x1, polynomial);

    double x2 = evaluateWeightedAverage(x0, x1, fX0, fX1);
    double fX2 = evaluateExpression(x2, polynomial);

    // Condição de parada
    if (fX2.abs() <= tolerance) {
      outputValue = fX2;
      break;
    }

    // x1 = x0;
    // x0 = x2;
    x0 = x1;
    x1 = x2;

    iterations++;
  }

  return Output(
    iterationsNeeded: iterations,
    value: outputValue,
    rootError: tolerance - outputValue,
  );
}

class Output {
  final double? value;
  final int iterationsNeeded;
  final double? rootError;

  Output({
    this.value,
    required this.iterationsNeeded,
    this.rootError,
  });

  @override
  String toString() => 'Output(value: $value, iterationsNeeded: $iterationsNeeded, rootError: $rootError)';
}
