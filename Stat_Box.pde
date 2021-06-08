public class Stat_Box{
  
 int value;
 String stat;
 PVector pos;
 int size = 70;
 
 Stat_Box(int v, String s, float x, float y){
   value = v;
   stat = s;

   pos = new PVector(x,y);
 }
 
 void display() {
   
   fill(0,255,0,100);
   rect(pos.x, pos.y, size, size);
   fill(255);
   textSize(20);
   text(value, pos.x + size/2, pos.y + size/2);
   textSize(30);
   text(stat, pos.x + size/2, pos.y + size);
   
 }
  
  
  
}
