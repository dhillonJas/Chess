public class King extends Piece
{
  public King(int team, PVector position)
  {
    super(team, position);
  }

  public void show()
  {
    beginShape(QUAD);
    if (team == WHITE)
      texture(whiteKing);
    else
      texture(blackKing);
    if (inCheck && turn == team) //to hightlight the king in check
      tint(255, 0, 0);
    vertex(position.y * tileLen + tileLen + (tileLen/9), position.x * tileLen + (tileLen/9), 0, 0);
    vertex(position.y * tileLen + tileLen + (tileLen - (tileLen/9)), position.x * tileLen + (tileLen/9), 345, 0);
    vertex(position.y * tileLen + tileLen + (tileLen - (tileLen/9)), position.x * tileLen + (tileLen - (tileLen/9)), 345, 345);
    vertex(position.y * tileLen + tileLen + (tileLen/9), position.x * tileLen + (tileLen - (tileLen/9)), 0, 345);
    endShape();
    noTint();
  }

  public ArrayList<Integer> getMoves(boolean calledThroughCheck)
  {
    ArrayList<Integer> moves = new ArrayList<Integer>();
    boolean same;
    for (int i = (int)position.x - 1; i <= (int)position.x + 1; i++)
    {
      for (int j = (int)position.y - 1; j <= (int)position.y + 1; j++)
      {
        same = i == position.x && j == position.y;
        if (i >= 0 && j >= 0 && i <= 7 && j <= 7 && (board[i][j] == null || board[i][j].team != this.team) && !same)
        {
          moves.add(i);
          moves.add(j);
        }
      }
    }
    if (!calledThroughCheck)
      super.removeInvalidMoves(moves);
    return moves;
  }

  public String toString() 
  { 
    return "King";
  }
}
