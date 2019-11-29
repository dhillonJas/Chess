public class Knight extends Piece
{
  public Knight(int team, PVector position)
  {
    super(team, position);
  }

  public void show()
  {
    beginShape(QUAD);
    if (team == WHITE)
      texture(whiteKnight);
    else
      texture(blackKnight);
    vertex(position.y * tileLen + tileLen + (tileLen/9), position.x * tileLen + (tileLen/9), 0, 0);
    vertex(position.y * tileLen + tileLen + (tileLen - (tileLen/9)), position.x * tileLen + (tileLen/9), 345, 0);
    vertex(position.y * tileLen + tileLen + (tileLen - (tileLen/9)), position.x * tileLen + (tileLen - (tileLen/9)), 345, 345);
    vertex(position.y * tileLen + tileLen + (tileLen/9), position.x * tileLen + (tileLen - (tileLen/9)), 0, 345);
    endShape();
  }

  public ArrayList<Integer> getMoves(boolean calledThroughCheck) 
  { 
    ArrayList<Integer> moves = new ArrayList<Integer>();
    //top and bottom moves
    for (int i = (int)position.x - 2, j = 0; j < 2; j++)
    {
      if (i >= 0 && i <= 7)
      {
        //top and bottom left moves
        if (position.y > 0 && (board[i][(int)position.y - 1] == null || board[i][(int)position.y - 1].team != this.team))
        {
          moves.add(i);
          moves.add((int)position.y - 1);
        }
        //top and bottom right moves
        if (position.y < 7 && (board[i][(int)position.y + 1] == null || board[i][(int)position.y + 1].team != this.team))
        {
          moves.add(i);
          moves.add((int)position.y + 1);
        }
      }
      i = (int)position.x + 2;
    }
    //right and left moves
    for (int i = (int)position.y - 2, j = 0; j < 2; j++)
    {
      if (i >= 0 && i <= 7)
      {
        //right and left top moves
        if (position.x > 0 && (board[(int)position.x - 1][i] == null || board[(int)position.x - 1][i].team != this.team))
        {
          moves.add((int)position.x - 1);
          moves.add(i);
        }
        //right and left bottom moves
        if (position.x < 7 && (board[(int)position.x + 1][i] == null || board[(int)position.x + 1][i].team != this.team))
        {
          moves.add((int)position.x + 1);
          moves.add(i);
        }
      }
      i = (int)position.y + 2;
    }
    if (!calledThroughCheck)
      super.removeInvalidMoves(moves);
    return moves;
  }
  public String toString() 
  { 
    return "Knight";
  }
}
