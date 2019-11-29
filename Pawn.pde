public class Pawn extends Piece //<>//
{
  public Pawn(int team, PVector position)
  {
    super(team, position);
  }

  public void show()
  {
    beginShape(QUAD);
    if (team == WHITE)
      texture(whitePawn);
    else
      texture(blackPawn);
    vertex(position.y * tileLen + tileLen + (tileLen/9), position.x * tileLen + (tileLen/9), 0, 0);
    vertex(position.y * tileLen + tileLen + (tileLen - (tileLen/9)), position.x * tileLen + (tileLen/9), 345, 0);
    vertex(position.y * tileLen + tileLen + (tileLen - (tileLen/9)), position.x * tileLen + (tileLen - (tileLen/9)), 345, 345);
    vertex(position.y * tileLen + tileLen + (tileLen/9), position.x * tileLen + (tileLen - (tileLen/9)), 0, 345);
    endShape();
  }

  public ArrayList<Integer> getMoves(boolean calledThroughCheck) 
  {
    ArrayList<Integer> moves = new ArrayList<Integer>();
    if (team == WHITE)
    {
      //the first move
      if (position.x == 6 && board[(int)position.x - 2][(int)position.y] == null && board[(int)position.x - 1][(int)position.y] == null)
      {
        moves.add((int)position.x - 2);
        moves.add((int)position.y);
      }
      if (position.x == 0) //to promote
        board[0][(int)position.y] = new Queen(team, new PVector(0, (int)position.y));
      else if (board[(int)position.x - 1][(int)position.y] == null) //straight moves
      {
        moves.add((int)position.x - 1);
        moves.add((int)position.y);
      }
      //moves for capturing on the left
      if (position.y != 7 && position.x > 0 && board[(int)position.x - 1][(int)position.y + 1] != null && board[(int)position.x - 1][(int)position.y + 1].team != this.team)
      {
        moves.add((int)position.x - 1);
        moves.add((int)position.y + 1);
      }
      //moves for capturing on the right
      if (position.y != 0 && position.x > 0 && board[(int)position.x - 1][(int)position.y - 1] != null && board[(int)position.x - 1][(int)position.y - 1].team != this.team)
      {
        moves.add((int)position.x - 1);
        moves.add((int)position.y - 1);
      }
    } else
    {
      //the first move
      if (position.x == 1 && board[(int)position.x + 2][(int)position.y] == null && board[(int)position.x + 1][(int)position.y] == null)
      {
        moves.add((int)position.x + 2);
        moves.add((int)position.y);
      }
      if (position.x == 7) //to promote
        board[7][(int)position.y] = new Queen(team, new PVector(7, (int)position.y));
      else if (board[(int)position.x + 1][(int)position.y] == null) //all straight moves
      {
        moves.add((int)position.x + 1);
        moves.add((int)position.y);
      }
      //moves for capturing on the left
      if (position.y != 7 && position.x < 7 && board[(int)position.x + 1][(int)position.y + 1] != null && board[(int)position.x + 1][(int)position.y + 1].team != this.team)
      {
        moves.add((int)position.x + 1);
        moves.add((int)position.y + 1);
      }      
      //moves for capturing on the right
      if (position.y != 0 && position.x < 7 && board[(int)position.x + 1][(int)position.y - 1] != null && board[(int)position.x + 1][(int)position.y - 1].team != this.team)
      {
        moves.add((int)position.x + 1);
        moves.add((int)position.y - 1);
      }
    }
    if (!calledThroughCheck)
      super.removeInvalidMoves(moves); //<>//
    return moves;
  }

  public String toString() 
  { 
    return "Pawn";
  }
}
