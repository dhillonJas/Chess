public class Bishop extends Piece
{
  public Bishop(int team, PVector position)
  {
    super(team, position);
  }

  public void show()
  {
    beginShape(QUAD);
    if (team == WHITE)
      texture(whiteBishop);
    else
      texture(blackBishop);
    vertex(position.y * tileLen + tileLen + (tileLen/9), position.x * tileLen + (tileLen/9), 0, 0);
    vertex(position.y * tileLen + tileLen + (tileLen - (tileLen/9)), position.x * tileLen + (tileLen/9), 345, 0);
    vertex(position.y * tileLen + tileLen + (tileLen - (tileLen/9)), position.x * tileLen + (tileLen - (tileLen/9)), 345, 345);
    vertex(position.y * tileLen + tileLen + (tileLen/9), position.x * tileLen + (tileLen - (tileLen/9)), 0, 345);
    endShape();
  }

  public ArrayList<Integer> getMoves(boolean calledThroughCheck)
  { 
    ArrayList<Integer> moves = new ArrayList<Integer>();
    //checking valid squares in top left diagonal
    for (int i = (int)position.x - 1, j = (int)position.y - 1; i >= 0 && j >= 0; i--, j--)
    {
      if (board[i][j] == null || board[i][j].team != this.team)
      {
        moves.add(i);
        moves.add(j);
      }
      if (board[i][j] != null) break;
    }   

    //checking valid squares in bottom right diagonal
    for (int i = (int)position.x + 1, j = (int)position.y + 1; i <= 7 && j <= 7; i++, j++)
    {
      if (board[i][j] == null || board[i][j].team != this.team)
      {
        moves.add(i);
        moves.add(j);
      }
      if (board[i][j] != null) break;
    }

    //checking valid squares in top right diagonal
    for (int i = (int)position.x - 1, j = (int)position.y + 1; i >= 0 && j <= 7; i--, j++)
    {
      if (board[i][j] == null || board[i][j].team != this.team)
      {
        moves.add(i);
        moves.add(j);
      }
      if (board[i][j] != null) break;
    }

    //checking valid squares in bottom left diagonal
    for (int i = (int)position.x + 1, j = (int)position.y - 1; i <= 7 && j >= 0; i++, j--)
    {
      if (board[i][j] == null || board[i][j].team != this.team)
      {
        moves.add(i);
        moves.add(j);
      }
      if (board[i][j] != null) break;
    }  

    if (!calledThroughCheck)
      super.removeInvalidMoves(moves);

    return moves;
  }

  public String toString() 
  { 
    return "Bishop";
  }
}
