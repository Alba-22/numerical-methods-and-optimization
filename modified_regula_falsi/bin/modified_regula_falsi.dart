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

  final result = modifiedRegulaFalsi(a, b, polynomial, tolerance);

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
  return (a * fB.abs() + b * fA.abs()) / (fB.abs() + fA.abs());
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

Output modifiedRegulaFalsi(double a, double b, List<double> polynomial, double tolerance) {
  // Condição de aplicação
  double fA = evaluateExpression(a, polynomial);
  double fB = evaluateExpression(b, polynomial);

  if (fA * fB >= 0) {
    return Output(iterationsNeeded: 0);
  }

  double lastX = a;
  double x = 0;
  double fX = 0;

  double? outputValue;
  int iterations = 1;

  while (true) {
    fA = evaluateExpression(a, polynomial);
    fB = evaluateExpression(b, polynomial);

    print("a = $a | f(a) = $fA");
    print("b = $b | f(b) = $fB");
    print("x = $x | f(x) = $fX");
    print("=====================");

    final fLastX = evaluateExpression(lastX, polynomial);
    if (fX != 0) {
      if (fLastX * fX > 0) {
        if (fA * fX < 0) {
          fA /= 2;
        } else {
          fB /= 2;
        }
      }
    }

    x = evaluateWeightedAverage(a, b, fA, fB);
    fX = evaluateExpression(x, polynomial);

    // Condição de Parada
    if (fX.abs() <= tolerance) {
      outputValue = fX;
      break;
    }

    // Definição do Novo Intervalo
    if (fA * fX < 0) {
      b = x;
    } else {
      a = x;
    }

    lastX = x;
    iterations++;
  }

  return Output(
    value: outputValue,
    iterationsNeeded: iterations,
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
