/*  //<>// //<>// //<>//
 PROJECT - Chess
 AUTHOR - Jasdeep Singh
 REFRENCES - chess piece symbols
             https://www.pinclipart.com/pindetail/hRbwim_file-pieces-sprite-wikimedia-chess-pieces-png-clipart/
             
 Note : The board keeps track of the all the pieces during the play. All the pieces that are
 moved are moved with respect to that board. That is, going downwards increases the x value
 and going right increases y value, as it happens in a 2D array. 
 
 Two rules it doesn't have - En passant and castling
 
 It does not show if the king is in checkmate. If no moves are shown after you click on every 
 piece, then that is checkmate.
 No undo option
*/
PImage whiteKing, whiteQueen, whiteRook, whiteBishop, whitePawn, whiteKnight;
PImage blackKing, blackQueen, blackRook, blackBishop, blackPawn, blackKnight;
final int WHITE = 0;
final int BLACK = 1;
void setup()
{
  size(1235, 988, P3D);  //width = height + (height/4)
  background(142, 149, 152);
  loadimages();
  initialize();
  wKing = new PVector(7, 4);
  bKing = new PVector(0, 4);
  noStroke();
}

//the board keeps track of where the pieces are 
Piece[][] board = new Piece[8][8];
PVector wKing, bKing;
boolean inCheck = false;
//stores all valid moves of a piece
ArrayList<Integer> allMoves = new ArrayList<Integer>();
int turn = WHITE;
Piece selectedPiece;
Piece prevSelected;
void keyPressed()
{
  if (key == ' ')
  {
    for (int i = 0; i < board.length; i++)
    {
      for (int j = 0; j < board.length; j++)
        print(board[i][j] + "\t");
      println();
    }
    println();
  } else if (key == 'r' || key == 'R')
  {
    board = new Piece[8][8];
    initialize();
    selectedPiece = null;
    prevSelected = null;
    turn = WHITE;
    allMoves = null;
    inCheck = false;
    bKing.x = 0;
    bKing.y = 4;
    wKing.x = 7;
    wKing.y = 4;
    redraw();
  }
}
void draw()
{
  drawBoard();
  drawPieces();
  noLoop();
}

void initialize()
{
  int row;
  int team = BLACK;
  for (int i = 0; i < 8; i+=7)
  {   
    board[i][0] = new Rook(team, new PVector(i, 0));
    board[i][1] = new Knight(team, new PVector(i, 1));
    board[i][2] = new Bishop(team, new PVector(i, 2));
    board[i][3] = new Queen(team, new PVector(i, 3));
    board[i][4] = new King(team, new PVector(i, 4));
    board[i][5] = new Bishop(team, new PVector(i, 5));
    board[i][6] = new Knight(team, new PVector(i, 6));
    board[i][7] = new Rook(team, new PVector(i, 7));
    for (int j = 0; j < 8; j++)
    {
      if (i == 0)
        row = i+1;
      else
        row = i-1;
      board[row][j] = new Pawn(team, new PVector(row, j));
    }
    team = WHITE;
  }
}

void drawPieces()
{
  for (int i = 0; i < board.length; i++)
  {
    for (int j = 0; j < board.length; j++)
    {
      if (board[i][j] != null)
      {
        if (board[i][j].selected)
          board[i][j].highlight();
        board[i][j].show();
      }
    }
  }
}
void drawBoard()
{
  int tileLen = height/8;
  //(x,y) the coordinates where the square will be drawn
  int x = tileLen;
  int y = 0;
  for (int i = 0; i < 8; i++)
  {
    for (int j = 0; j < 8; j++)
    {
      //colouring the chess board
      if ((i % 2 == 0 && j % 2 == 0) || (i % 2 != 0 && j % 2 != 0))
        fill(251, 235, 174);
      else
        fill(84, 124, 72);

      //getting the valid moves of the selected piece
      if (selectedPiece != null && i == 0 && j == 0)  //checking i and j, so getMoves is called only once while the board is drawn
        allMoves = selectedPiece.getMoves(false);
      rect(x, y, tileLen, tileLen);

      //showing the valid moves
      if (allMoves != null && contains(allMoves, j, i))
      {
        fill(142, 149, 152);
        ellipse(x + height/16, y + height/16, 25, 25);
      }

      y += tileLen;
    }
    x += tileLen;
    y = 0;
  }
}

void loadimages()
{
  whiteKing = loadImage("Pieces/white king.png");
  whiteQueen = loadImage("Pieces/white queen.png");
  whiteRook = loadImage("Pieces/white rook.png");
  whiteBishop = loadImage("Pieces/white bishop.png");
  whitePawn = loadImage("Pieces/white pawn.png");
  whiteKnight = loadImage("Pieces/white knight.png");

  blackKing = loadImage("Pieces/black king.png");
  blackQueen = loadImage("Pieces/black queen.png");
  blackRook = loadImage("Pieces/black rook.png");
  blackBishop = loadImage("Pieces/black bishop.png");
  blackPawn = loadImage("Pieces/black pawn.png");
  blackKnight = loadImage("Pieces/black knight.png");
}

void mouseClicked()
{
  if (mouseX > (height/8) && mouseX < height + height/8)
  {
    prevSelected = selectedPiece;
    int selectedY = (mouseX/(height/8))-1;
    int selectedX = (mouseY/(height/8));

    //a piece is selected if the there is something on square and it is the player's turn
    if (board[selectedX][selectedY] != null && board[selectedX][selectedY].team == turn)
    {
      selectedPiece = board[selectedX][selectedY];     
      selectedPiece.selected = true;
    }

    //a player can move if something is selected and the next click has either no piece on square or it is of other team
    if (selectedPiece != null && (board[selectedX][selectedY] == null || board[selectedX][selectedY].team != selectedPiece.team))
    {
      if (contains(allMoves, selectedX, selectedY))
        selectedPiece.move(selectedX, selectedY);
      allMoves = null;  //so the valid moves are not shown for the selected piece after the move has been completed
    }
  }
  //unselecting the previous piece
  if (prevSelected != null && !prevSelected.equals(selectedPiece))
    prevSelected.selected = false;

  redraw();
}

//to see if the arraylist has the (x,y) point
boolean contains(ArrayList<Integer> moves, int x, int y)
{
  boolean result = false;
  for (int i = 0; i < moves.size()-1 && !result; i+=2)
  {
    if (moves.get(i) == x && moves.get(i+1) == y)
      result = true;
  }
  return result;
}
