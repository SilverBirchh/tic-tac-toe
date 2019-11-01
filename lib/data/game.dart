class Game {
  Game(
      {this.xIsNext,
      this.squares,
      this.xHasWon,
      this.xWins,
      this.totalGames});

  List<String> squares;
  bool xIsNext;
  bool xHasWon;
  int xWins;
  int totalGames;

  Game copyWith(
      {List<String> squares,
      bool xIsNext,
      bool hasFinished,
      bool xHasWon,
      int xWins,
      int totalGames}) {
    return Game(
      squares: squares ?? this.squares,
      xIsNext: xIsNext ?? this.xIsNext,
      xHasWon: xHasWon ?? this.xHasWon,
      xWins: xWins ?? this.xWins,
      totalGames: totalGames ?? this.totalGames,
    );
  }

  bool isEqual(Game gameTwo) {
    return this.squares == gameTwo.squares &&
        this.xIsNext == gameTwo.xIsNext &&
        this.xHasWon == gameTwo.xHasWon &&
        this.xWins == gameTwo.xWins &&
        this.totalGames == gameTwo.totalGames;
  }

  Game.fromJson(Map<String, dynamic> json)
      : squares = json['squares'],
        xIsNext = json['xIsNext'],
        xHasWon = json['xHasWon'],
        xWins = json['xWins'],
        totalGames = json['totalGames'];

  Map<String, dynamic> toJson() => {
        'squares': squares,
        'xIsNext': xIsNext,
        'xHasWon': xHasWon,
        'xWins': xWins,
        'totalGames': totalGames,
      };
}
