public abstract class Piece //<>//
{
  protected int team;
  protected PVector position;
  protected boolean selected = false;
  protected int tileLen = height/8;
  public abstract void show();
  
  /*the parameter tells if the getMoves is called by isInCheck method 
    or called just to get the moves at the beginning 
    
    if calledThroughCheck is true, it is just getting the moves for a piece
    but if the variable is false, it is getting the moves and removing all
    the invalid moves also, which calls removeInvalidMoves() which calls
    isInCheck()
  */
  public abstract ArrayList<Integer> getMoves(boolean calledThroughCheck);

  public Piece(int team, PVector position)
  {
    this.team = team;
    this.position = position;
  }

  /*
  board[i][j].team == team => checks for moves of all pieces for own team to see 
                              if those moves have the same position with other's king
    the param tells after the whose king should be checking for 
  */
  public boolean isInCheck(boolean myKing)
  {
    boolean check;
    ArrayList<Integer> moves = new ArrayList<Integer>();
    for (int i = 0; i < board.length; i++)
    {
      for (int j = 0; j < board.length; j++)
        if (board[i][j] != null && ((!myKing && board[i][j].team == team) || (myKing && board[i][j].team != team)))
          moves.addAll(board[i][j].getMoves(true));
    }

    if ((turn == WHITE && !myKing) || (turn == BLACK && myKing))
      check = contains(moves, (int)bKing.x, (int)bKing.y);
    else
      check = contains(moves, (int)wKing.x, (int)wKing.y);
    return check;
  }

  /*  removes all invalid moves which will result in king in check or
   if king is already in check, removes moves that will not take
   king out of check
   It goes in the board and tries every move in param moves and 
   checks if the king is in check. If so, then it removes that move
   It resets everything before exiting.
   */
  private void removeInvalidMoves(ArrayList<Integer> moves)
  {
    int x = (int)position.x;
    int y = (int)position.y;
    int tempX, tempY;
    Piece tempPiece;
    int kingX = 0, kingY = 0;

    //while checking invalid moves for a king, the king's position will be changed
    //so saving the actual king's coords before checking for every move for king
    if (this instanceof King)
    {
      if (turn == WHITE)
      {
        kingX = (int)wKing.x;
        kingY = (int)wKing.y;
      } else
      {
        kingX = (int)bKing.x;
        kingY = (int)bKing.y;
      }
    }

    boolean check = false;
    board[x][y] = null;
    for (int i = 0; i < moves.size()-1; i+=2)
    {
      tempX = moves.get(i);
      tempY = moves.get(i+1);
      tempPiece = board[tempX][tempY];
      board[tempX][tempY] = this;
      if (this instanceof King)
      {
        if (turn == WHITE)
        {
          wKing.x = tempX;
          wKing.y = tempY;
        } else
        {
          bKing.x = tempX;
          bKing.y = tempY;
        }
      }   
      check = isInCheck(true);
      if (check)
      {
        moves.subList(i, i+2).clear(); //i inclusive, i+2 exclusive.. removes indices i, i+1
        i -= 2;
      }
      board[tempX][tempY] = tempPiece;
      check = false;
    }
    board[x][y] = this;
    
    if (this instanceof King)
    {
      if (turn == WHITE)
      {
        wKing.x = kingX;
        wKing.y = kingY;
      } 
      else
      {
        bKing.x = kingX;
        bKing.y = kingY;
      }
    }
  }

  public void move(int x, int y)
  {
    board[(int)position.x][(int)position.y] = null;
    position.x = x;
    position.y = y;
    board[x][y] = this;
    selectedPiece = null;
    inCheck = isInCheck(false); //checking if this move results in other's king in check

    //keeping track of both king's position, easier to check if king is in check
    if (this instanceof King) 
    {
      if (turn == WHITE)
      {
        wKing.x = x;
        wKing.y = y;
      } else
      {
        bKing.x = x;
        bKing.y = y;
      }
    }

    if (turn == WHITE) turn = BLACK;
    else turn = WHITE;
  }

  public void highlight()
  {
    fill(230, 177, 54);
    rect(position.y * tileLen + tileLen, position.x * tileLen, tileLen, tileLen);
  }
}
