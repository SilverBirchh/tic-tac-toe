enum GAME_TYPE { PVP, PVB, BVB }

enum RESULT { DRAW, WIN, NONE }

class Type {
  Type(this.gameType);
  final GAME_TYPE gameType;
}