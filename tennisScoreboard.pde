/* Update Variables Pre-Game*/
int bestOf = 3; //Update depending on what you want it to be first to

/* Non-Updateable Variables */
PFont defaultFont, title;
int playerNum = 1; //Are they player 1 or 2
int playerPos; //Location variable for where players name appears
int gameLeft, gameRight, setLeft, setRight = 0; //Variables to hold current score of player
boolean winnerFound = false; //Boolean to look if there is a winner yet
char personLeft, personRight = 'd'; //Holds char representing which character is currently on.
PImage ausOpen;

void setup() {
  //Load Fonts & Images
  title = createFont("DaxBold.otf", 1000/13); 
  defaultFont = loadFont("ArialRoundedMTBold-48.vlw");
  ausOpen = loadImage("logo.png");
   
  //Initialise screen attributes, modes & globals
  background(255);
  size(1000, 1000);
  playerPos = width/4 - width/12;
  rectMode(CENTER);  
  
  //Tournament Title 
  strokeWeight(width/120);  
  stroke(162, 245, 54); //Green Border
  fill(245, 242, 54, 200); //Yellow Fill
  rect(width/2+100, height/6, width*2/3, height/5);
  textFont(title);
  fill(245, 54, 207); //Pink Text
  text("Kaelin Tennis", width/4+width/35+100, height/6);
  fill(66, 135, 245); //Blue Text
  text("Tournament 2020", width/4-width/18+100, height/4.5 + height/100);

  //Current Game Score Boxes
  stroke(0);
  fill(240);
  strokeWeight(width/300);
  rect(width/4-width/32, height/2, width/5.5, height/5);
  rect(width*3/4+width/16, height/2, width/5.5, height/5);
  
  textFont(defaultFont); //set font for rest of text
  textSize(width/10);
}

void draw() {
  image(ausOpen, 0, 50);
  
  if (winnerFound) {
    winningSequence();
  }
}

void keyPressed() {
  //Update Player Fields (only if 2 players have not been selected yet)
  if ((key == 's' || key == 'e' || key == 'a' || key == 'a' || key == 'm' || key == 'd') && playerNum < 3) {
    updatePlayerField();
  }

  //Update Current Score (if left and right arrow selected)
  // ',' Increase score of left player
  // '.' Increase score of right player
  if (key == ',' || key == '.') {
    //Score Box refresh
    //GAME SCORE BOX
    stroke(0);
    fill(240);
    strokeWeight(width/300);
    rect(width/4-width/32, height/2, width/5.5, height/5);
    rect(width*3/4+width/16, height/2, width/5.5, height/5);
    
    //SET SCORE BOX
    fill(255); 
    noStroke();
    rect(width/2, height/2 + height/4, width, 200);
    
    //Update Score variables
    if (key == ',') { //LEFT
      updateScore("left");
    }
    if (key == '.') { //RIGHT
      updateScore("right");
    }
    
    //Display new Score variables
    //GAME SCORE
    fill(0);
    text(gameLeft, width/4-width/11, height/2+height/32);
    text(gameRight, width*3/4+width/128, height/2+height/32);

    //SET SCORE
    text(setLeft, width/4-width/11, height/2 + height/4);
    text(setRight, width*3/4+width/128, height/2 + height/4);
    
  }

  //RESET Screen
  if (key == 'r') {
    resetVariables();
    setup();
  }
}

/*
* @param: String with value "left" or "right" to determine whose score is increased
* Will update the variables containing current game and set values for each player.
*/
void updateScore(String win) {
  //If left player won the point.
  if (win.equals("left")) {
    
    gameLeft += 15;
    
    //Adjust score of 45 to be 40.
    if (gameLeft == 45) {
      gameLeft = 40;
    }
    
    //If they have won the game
    if (gameLeft > 40) {
      gameLeft = 0;
      gameRight = 0;
      setLeft ++;
    }
  } 
  
  //If Right Player won the point
  else {
    
    gameRight += 15;
    
    //Adjust score of 45 to be 40.
    if (gameRight == 45) {
      gameRight = 40;
    }
    
    //If they have won the game
    if (gameRight > 40) {
      gameLeft = 0;
      gameRight = 0;
      setRight ++;
    }
  }
  
  // Alert if winner has been found.
  if (setLeft == bestOf || setRight == bestOf) {
        winnerFound = true;
  }
}

/*
* Creates Screen with the winning person declared
*/
void winningSequence() {
  background(255);
  String champ = "";
  if (setLeft == 3) {
    champ = whoIsWinner(personLeft);
  } else {
    champ = whoIsWinner(personRight);
  }    
  text("WINNER!", width/4, height/2);
  text(champ+"!", width/4, height/2 + height/8);
}

/* 
* Reset variables to their original state to start a fresh match.
*/
void resetVariables() {
  playerNum = 1;
  gameLeft = 0; 
  gameRight = 0; 
  setLeft = 0; 
  setRight = 0;
  winnerFound = false;
  personLeft = 'd';
  personRight = 'd';
}

/*
* @param: c represents char of winning player
* @return: string of winners full name.
*/
String whoIsWinner(char c) {
       if (c == 's') { return "Sophie"; } 
  else if (c == 'e') { return "Emma"; } 
  else if (c == 'a') { return "Alex"; } 
  else if (c == 'd') { return "Anthony"; } 
  else {               return "Lucy"; }
}

/*
* Updates the players name on the left or right side of the Score Board
*/
void updatePlayerField(){
  String player = "";

         if (key == 's') {  player = ("Sophie"); } 
    else if (key == 'm') {  player = ("Lucy"); }   
    else if (key == 'd') {  player = ("Anthony"); } 
    else if (key == 'e') {  player = ("Emma"); } 
    else if (key == 'a') {  player = ("Alex"); }
    
    //Stores Player character in player variable
    if (playerNum == 1) {
      personLeft = key;
    }
    if (playerNum == 2) {
      personRight = key;
    }
    
    //Display Player name
    textSize(width/30);
    fill(0);
    text(player, playerPos, height/2-height/6 + 50);
    
    //Prepare for next Player
    playerNum ++;
    playerPos = width* 3 /4 + 10;
}
