public class Character{
  
  ArrayList<Spell> spells;
  Dnd_class dnd_class;
  Dnd_race dnd_race;
  
  int[] stats = {0,0,0,0,0,0}; //str, dex, con, int, wis, cha
  

  int speed;
  String name = "Wilson McKenzie";
  int hp;
  int ac;
  String sexe;
  int level = 1;
  ArrayList<Stat_Box> statboxes;
  ArrayList<Skill> skills; 
  int proficiency_bonus = 2;
  
  
  Character(){
    dnd_class = new Dnd_class();
    dnd_race = new Dnd_race(); 
  }
  
  void display()
  {
    textAlign(CENTER);
    stroke(255);
       
    //Char Info
    textSize(20);
    fill(255);
    text("Name: " + name, 7, 10, 300, 30);
    text("Race: " + dnd_race.name, 300, 10, 200, 30);
    text("Class: " + dnd_class.name, 500,10, 200,30);
    text("Level: " + level, 700,10, 100,30);

    //Stats
    for(Stat_Box b : statboxes) {
      b.display();
    }

    //Proficiencies
    textAlign(LEFT);
    textSize(20);
    fill(255);
    PVector pos = new PVector(40, 200);
    text("Proficiencies", pos.x, pos.y);
    textSize(15);
    fill(255);
    for(Proficiencie p : dnd_class.proficiencies) {          
      pos.y += 20; 
      text(p.name, pos.x, pos.y); //p.display(pos) would crash -- unknown reason !
    }
    
   //Skills
   textAlign(LEFT);
   textSize(20);
   fill(255);
   pos = new PVector(300,200);
   text("Skills", pos.x, pos.y);
   textSize(15);
   fill(255);
   for(Skill s : skills) { 
     if(s.isProficient)
     {
       fill(0,255,0);
     }
      pos.y += 20; 
      if(s.bonus >= 0)
      text("(" + s.ability_score.index + ") " + s.name + " +" + s.bonus, pos.x, pos.y); //s.display(pos) would crash -- unknown reason !
      else
      {
        text("(" + s.ability_score.index + ") " + s.name + " " + s.bonus, pos.x, pos.y); //s.display(pos) would crash -- unknown reason !
      }
      fill(255);
    }
    
   //Languages
   textAlign(LEFT);
   textSize(20);
   fill(255);
   pos = new PVector(580,200);
   text("Languages", pos.x, pos.y);
   textSize(15);
   fill(255);
   for(Api_format_item s : dnd_race.languages) {          
      pos.y += 20; 
      text(s.name, pos.x, pos.y); // Didn't want to try, s.display probably would crash like the 2 others -- unknown reason !
      fill(255);
    }
    
   //Traits
   textAlign(LEFT);
   textSize(20);
   fill(255);
   pos = new PVector(800,200);
   text("Traits", pos.x, pos.y);
   textSize(15);
   fill(255);
   for(Api_format_item t : dnd_race.traits) {          
      pos.y += 20; 
      text(t.name, pos.x, pos.y); // Didn't want to try, t.display probably would crash like the 2 first -- unknown reason !
      fill(255);
    }
    
    //Proficieny Bonus
    
   
  }
  
    void create_stat_boxes(){
     
    statboxes = new ArrayList<Stat_Box>();
    int inc = width/8;
    int i = 0;  
    statboxes.add(new Stat_Box(stats[0], "str", 70 + inc * i++, 50) );
    statboxes.add(new Stat_Box(stats[1], "dex", 70 + inc * i++, 50) );
    statboxes.add(new Stat_Box(stats[2], "con", 70 + inc * i++, 50) );
    statboxes.add(new Stat_Box(stats[3], "int", 70 + inc * i++, 50) );
    statboxes.add(new Stat_Box(stats[4], "wis", 70 + inc * i++, 50) );
    statboxes.add(new Stat_Box(stats[5], "cha", 70 + inc * i++, 50) );
      
    }
  
}
