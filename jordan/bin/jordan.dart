List<double> jordanMethod(List<List<double>> matrix) {
  // TODO: Verificar se a matrix está no formato correto: x linhas e x + 1 colunas
  // TODO: Verificar se não tem zero em (0,0)
  // TODO: Interface
  print("Matrix inicial:");
  print(matrix);
  for (int iteration = 0; iteration < matrix.length; iteration++) {
    print("Iteration: $iteration");

    for (int row = 0; row < matrix.length; row++) {
      double? numerator;
      double denominator = matrix[iteration][iteration];
      for (int col = iteration; col < matrix[row].length; col++) {
        if (row == iteration) {
          continue;
        } else {
          numerator ??= matrix[row][col];
          print("Conta: {[$row][$col]} = ${matrix[row][col]} - (($numerator / $denominator) * ${matrix[iteration][col]})");
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

    print("Matrix após iteração $iteration:");
    print(matrix);
  }

  print("Matrix final:");
  print(matrix);

  // TODO: Fazer retorno dos valores das incógnitas
  return [];
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
