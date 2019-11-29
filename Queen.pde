public class Queen extends Piece
{
  public Queen(int team, PVector position)
  {
    super(team, position);
  }

  public void show()
  {
    beginShape(QUAD);
    if (team == WHITE)
      texture(whiteQueen);
    else
      texture(blackQueen);

    vertex(position.y * tileLen + tileLen + (tileLen/9), position.x * tileLen + (tileLen/9), 0, 0);
    vertex(position.y * tileLen + tileLen + (tileLen - (tileLen/9)), position.x * tileLen + (tileLen/9), 345, 0);
    vertex(position.y * tileLen + tileLen + (tileLen - (tileLen/9)), position.x * tileLen + (tileLen - (tileLen/9)), 345, 345);
    vertex(position.y * tileLen + tileLen + (tileLen/9), position.x * tileLen + (tileLen - (tileLen/9)), 0, 345);
    endShape();
  }

  public ArrayList<Integer> getMoves(boolean calledThroughCheck)
  { 
    ArrayList<Integer> moves = new ArrayList<Integer>();
    //upward valid squares
    for (int i = (int)position.x - 1; i >= 0; i--)
    {
      if (i >= 0 && (board[i][(int)position.y] == null || board[i][(int)position.y].team != this.team))
      {
        moves.add(i);
        moves.add((int)position.y);
      }
      if (board[i][(int)position.y] != null) break;
    }
    //downward valid sqaures
    for (int i = (int)position.x + 1; i <= 7; i++)
    {
      if (i <= 7 && (board[i][(int)position.y] == null || board[i][(int)position.y].team != this.team))
      {
        moves.add(i);
        moves.add((int)position.y);
      }
      if (board[i][(int)position.y] != null) break;
    }
    //leftward valid squares
    for (int i = (int)position.y - 1; i >= 0; i--)
    {
      if (i >= 0 && (board[(int)position.x][i] == null || board[(int)position.x][i].team != this.team))
      {
        moves.add((int)position.x);
        moves.add(i);
      }
      if (board[(int)position.x][i] != null) break;
    }
    //rightward valid squares
    for (int i = (int)position.y + 1; i <= 7; i++)
    {
      if (i <= 7 && (board[(int)position.x][i] == null || board[(int)position.x][i].team != this.team))
      {
        moves.add((int)position.x);
        moves.add(i);
      }
      if (board[(int)position.x][i] != null) break;
    }
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
    return "Queen";
  }
}
