import processing.serial.*;

PImage bg;
int speed = 10;

int score = 0;

int upperOneRectHeight;
int lowerOneRectHeight; 
int rectOnePos;

int upperTwoRectHeight;
int lowerTwoRectHeight;
int rectTwoPos;

Serial serial;

int playerPosX;

PFont font;

void setup(){
  surface.setTitle("FlappyBird ");
  //surface.setResizable(true); //no background image
  size(1600,782);
  frameRate(60);
  font = createFont("GameFont.otf",128);
  bg = loadImage("BackGround.png");
  
  playerPosX = 400;
  
  upperOneRectHeight = int(random(20,height/1.3));
  lowerOneRectHeight = int(random(upperOneRectHeight+100,upperOneRectHeight-50)); 
  rectOnePos = width; 
  
  upperTwoRectHeight = int(random(20,height/1.3));
  lowerTwoRectHeight = int(random(upperTwoRectHeight+100, upperTwoRectHeight-50)); 
  rectTwoPos = rectOnePos + 800; 
  
  String pname = "COM3";
  serial = new Serial(this, pname, 9600);  
}

void draw(){
  background(bg);
  if(rectOnePos < -80){
    /*When the first pipes reach the end (0 width coordinate) the first pipes are now
    the previous second pipes and the second pipes are the new created on the right of the window*/
    upperOneRectHeight = upperTwoRectHeight;
    lowerOneRectHeight = lowerTwoRectHeight;
    rectOnePos = rectTwoPos;
    
    upperTwoRectHeight = int(random(50,height/1.2));;
    lowerTwoRectHeight = int(random(upperTwoRectHeight+150, upperTwoRectHeight-50)); 
    rectTwoPos = width;
    
    
    //println("New Tubes!!!");
    score += 1;
    //println(score);
    
  }
  if (serial.available() > 0){
    try{
      playerPosX = int(serial.readStringUntil('\n').trim());
      //println(playerPosX);
    }catch(NullPointerException e){
      print("null value, skipping");
    }
  }
  
  fill(25,200,10);
  //first pipes
  rect(rectOnePos, 0, 80, upperOneRectHeight);
  rect(rectOnePos, lowerOneRectHeight, 80, height-lowerOneRectHeight);
  //second pipes
  rect(rectTwoPos, 0, 80, upperTwoRectHeight);
  rect(rectTwoPos, lowerTwoRectHeight, 80, height-lowerTwoRectHeight);
  //moving pipes
  rectOnePos -= speed;
  rectTwoPos -= speed;
  
  //player
  fill(140,180,20);
  ellipse(50,playerPosX,50,45);
  
  if(rectOnePos <= 50){
    println(lowerOneRectHeight);
    if(playerPosX <= upperOneRectHeight || playerPosX >= lowerOneRectHeight){
      fill(200,10,80);
      stroke(0,0,0);
      textSize(56);
      
      textFont(font, 256);
      textAlign(TOP,CENTER);
      text("GAME OVER!", 335, 250);
      textFont(font, 110);
      textAlign(TOP,CENTER);
      text("PRESS RIGHT CLICK TO RESTART", 280, 500);
      
      noLoop();
    }
  }
  
  
}

void mousePressed(){
  score = 0;
  upperOneRectHeight = int(random(20,height/1.3));
  lowerOneRectHeight = int(random(upperOneRectHeight+100,upperOneRectHeight-50)); 
  rectOnePos = width; 
  
  upperTwoRectHeight = int(random(20,height/1.3));
  lowerTwoRectHeight = int(random(upperTwoRectHeight+100, upperTwoRectHeight-50)); 
  rectTwoPos = rectOnePos + 800; 
 
  loop();
}
