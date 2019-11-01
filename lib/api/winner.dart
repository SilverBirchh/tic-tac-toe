class Winner {
  String calculateWinner(List<String> squares) {
    const lines = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];
    for (int i = 0; i < lines.length; i++) {
      int a = lines[i][0];
      int b = lines[i][1];
      int c = lines[i][2];
      if (squares[a] != null &&
          squares[a] == squares[b] &&
          squares[a] == squares[c]) {
        return 'WIN';
      }
    }

    if (!squares.contains(null)) {
      return 'DRAW';
    }
    return 'NONE';
  }
}
