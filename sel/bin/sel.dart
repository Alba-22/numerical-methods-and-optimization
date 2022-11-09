import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'jordan.dart';

void main(List<String> arguments) {
  final degree = readInt("Qual o grau do polinômio? ");
  List<Point> points = [];
  for (int i = 0; i < degree + 1; i++) {
    print("Ponto ${i + 1}:");
    final x = readDouble("Valor de X: ");
    final y = readDouble("Valor de Y: ");
    points.add(Point(x, y));
  }
  final result = sel(points);
  String polynomial = "";
  for (int i = 0; i < degree + 1; i++) {
    if (i == 0) {
      polynomial += result[i].toStringAsFixed(2);
    } else {
      polynomial += "${result[i].toStringAsFixed(2)}x^$i";
    }
    if (i != degree) {
      polynomial += " + ";
    }
  }
  print("O polinômio é: $polynomial");
}

List<double> sel(List<Point> points) {
  final degree = points.length - 1;
  List<List<double>> matrix = [];
  for (final point in points) {
    final List<double> row = [1];
    for (int col = 1; col < degree + 1; col++) {
      row.add(pow(point.x, col).toDouble());
    }
    row.add(point.y);
    matrix.add(row);
  }
  final values = jordanMethod(matrix);
  return values;
}

class Point {
  final double x;
  final double y;

  Point(this.x, this.y);
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
