class Button{
 
  int rectX, rectY;      // Position of square button
  int rectSize = 90;     // Diameter of rect
  color rectColor, baseColor;
  color rectHighlight, circleHighlight;
  color currentColor;
  boolean rectOver = false;

  
  Button(){
    
    rectColor = color(255,0,0);
    rectHighlight = color(51);
    baseColor = color(102);
    currentColor = baseColor;
    rectX = width/2-rectSize-10;
    rectY = height/2-rectSize/2;
    ellipseMode(CENTER);
    
  }
  
  void display(){
    background(currentColor);
      if (rectOver) {
        fill(rectHighlight);
      } else {
        fill(rectColor);
      }
      stroke(255);
      rect(rectX, rectY, rectSize, rectSize);
    
  }
  
  void update(){
      if ( overRect(rectX, rectY, rectSize, rectSize) ) {
        rectOver = true;
      } else {
       
        rectOver = false;
        
      }
  }
  
  void mousePressed() {
    if (rectOver) {
      print("\nButton_Clicked");
    }
  }
  
  boolean overRect(int x, int y, int width, int height)  {
    if (mouseX >= x && mouseX <= x+width && 
        mouseY >= y && mouseY <= y+height) {
      return true;
    } else {
      return false;
    }
  }
  
  
  
}
