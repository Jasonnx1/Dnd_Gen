import http.requests.*;
import static javax.swing.JOptionPane.*;

Character dnd_char;
Gson g = new Gson();
PImage logo;
PGraphics pg;
void setup()
{
  size(1280, 720);
  
    logo = loadImage("logo/logo.png");
    imageMode(CENTER);
    logo.resize(200,200);
    surface.setTitle("DND 5e Generation");
    surface.setIcon(logo);

 
    
    DetermineClass();
    DetermineRace();
    RollForStats();
    RaceTraits();
    RollHp();
    DetermineSexe();
    GetSkills();
    DetermineChoiceProficiencies();
    DetermineLanguages();

    // Displayed Boxes  
    dnd_char.create_stat_boxes();
    
   
}


void draw() {
  background(0);
  update();
  display();
}

void update() {
  

}

void display() {
  dnd_char.display();
}

void GetSkills() {
  
    GetRequest get = new GetRequest("https://www.dnd5eapi.co/api/skills");
    get.send();
    Api_format skills = g.fromJson(get.getContent(), Api_format.class);
    dnd_char.skills = new ArrayList<Skill>();
    for(Api_format_item s : skills.results)
    {
      
      get = new GetRequest("https://www.dnd5eapi.co/api/skills/" + s.index);
      get.send();
      Skill skill = g.fromJson(get.getContent(), Skill.class);
      dnd_char.skills.add( skill  );
      
      
    }
    
    
    for(Skill s : dnd_char.skills)
    {
      String mod = s.ability_score.index;
      int value = 0;
      
      switch(mod)
      {
        case "str": value = dnd_char.stats[0];  
        break;
        case "dex": value = dnd_char.stats[1];   
        break;
        case "con": value = dnd_char.stats[2];   
        break;
        case "int": value = dnd_char.stats[3];      
        break;
        case "wis": value = dnd_char.stats[4]; 
        break;
        case "cha": value = dnd_char.stats[5]; 
        break;
      }      
      if(value < 10);
      { 
        if(value%2 == 1)
        {
          value -= 1;
        }
      }
      int i = Math.round( (value - 10) / 2 );
      s.bonus = i;
      
    }
     
}

void GetTraits() {
  
  
  
}

void DetermineChoiceProficiencies() {
  
  
  for(Proficiencie_choice c : dnd_char.dnd_class.proficiency_choices)
  {
    int n = c.choose;
    int lastr = -1;
    
    for(int i = 0; i < n; i++)
    {
      Proficiencie p = new Proficiencie();
      int m = c.from.size();
      int r;
      
      do
      {
        r = int(random(m)); 
      }while(r == lastr);
          
      p.name = c.from.get(r).name;
      p.index = c.from.get(r).index;
      p.url = c.from.get(r).url;
      lastr = r;
      dnd_char.dnd_class.proficiencies.add(p);
    }  
  } 
  
  if(dnd_char.dnd_race.starting_proficiencies != null)
  {
      for(Proficiencie p : dnd_char.dnd_race.starting_proficiencies)
      {
       dnd_char.dnd_class.proficiencies.add(p); 
      }
  }
  
  
  for(Proficiencie p : dnd_char.dnd_class.proficiencies)
  {
    
    if(p.name.startsWith("Skill:"))
    {
      String str = p.name.substring(7,p.name.length());
      print(str + "\n");
      
      for(Skill s : dnd_char.skills)
      {
       if(str.equals(s.name))
       {
         s.isProficient = true;
         s.bonus += dnd_char.proficiency_bonus;
       }
      }
      
    }
    
  }

  
  
}

void DetermineLanguages() {
  
  if(dnd_char.dnd_race.language_options != null)
  {
    int n = dnd_char.dnd_race.language_options.choose;
    int lastr = -1;
    
    for(int i = 0; i < n; i++)
    {
      Api_format_item l = new Api_format_item();
      int m = dnd_char.dnd_race.language_options.from.size();
      int r;
      
      do
      {
        r = int(random(m)); 
      }while(r == lastr);
          
      l.name = dnd_char.dnd_race.language_options.from.get(r).name;
      l.index = dnd_char.dnd_race.language_options.from.get(r).index;
      l.url = dnd_char.dnd_race.language_options.from.get(r).url;
      lastr = r;
      dnd_char.dnd_race.languages.add(l);
    } 
  }
}

void RaceTraits() {
  
  for(Ability_bonus ab : dnd_char.dnd_race.ability_bonuses)
  {

      switch(ab.ability_score.index)
      {
        case "str": dnd_char.stats[0] += ab.bonus;   
        break;
        case "dex": dnd_char.stats[1] += ab.bonus;     
        break;
        case "con": dnd_char.stats[2] += ab.bonus;    
        break;
        case "int": dnd_char.stats[3] += ab.bonus;      
        break;
        case "wis": dnd_char.stats[4] += ab.bonus;    
        break;
        case "cha": dnd_char.stats[5] += ab.bonus;   
        break;
      }
  }
  
}

void RollHp() {
    dnd_char.hp = dnd_char.dnd_class.hit_die;
    print(dnd_char.hp + " hp" + "\n");  
}

void DetermineSexe() {
    String sexe;
    int i = int(random(2));
    if(i == 0) {
      sexe = "Female";
    } else {
     sexe = "Male"; 
    }
    dnd_char.sexe = sexe;
    print(dnd_char.sexe + "\n");
}

void DetermineClass() {
    GetRequest get = new GetRequest("https://www.dnd5eapi.co/api/classes");
    get.send();
    Api_format classes = g.fromJson(get.getContent(), Api_format.class);
    int index = int(random(classes.count));
    String dnd_class = classes.results.get(index).index; 
    dnd_char = new Character();
    get = new GetRequest("https://www.dnd5eapi.co/api/classes/" + dnd_class);
    get.send();
    dnd_char.dnd_class = g.fromJson(get.getContent(), Dnd_class.class);
    print(dnd_char.dnd_class.name  + "\n");
  
}

void DetermineRace() {
    GetRequest get = new GetRequest("https://www.dnd5eapi.co/api/races");
    get.send();
    Api_format races = g.fromJson(get.getContent(), Api_format.class);
    int index = int(random(races.count));
    String dnd_race = races.results.get(index).index; 
    get = new GetRequest("https://www.dnd5eapi.co/api/races/" + dnd_race);
    get.send();
    dnd_char.dnd_race = g.fromJson(get.getContent(), Dnd_race.class);
    print(dnd_char.dnd_race.name  + "\n");
  
}

void RollForStats() {

    int[] stats = {0,0,0,0,0,0};
    
    for(int i = 0; i < 6; i++)
    {
      int[] dice = {0,0,0,0};
      
      for(int j = 0; j < 4; j++)
      {
        dice[j] = int(random(6)) + 1;
      }
      
      int lowest = dice[0];
      
      for(int j = 1; j < 4; j++)
      {
         if(dice[j] < lowest)
         {
          lowest = dice[j]; 
         }
      }
      
      stats[i] = dice[0] + dice[1] + dice[2] + dice[3] - lowest;
      print(stats[i]);
      if(i < 5)
      {
         print(", ");
      }

    }
    print("\n");
    
    int highest = stats[0];
    int index_of_highest = 0;
    
    int highest_2 = 0;
    int index_of_highest_2 = 0;
    
    for(int j = 1; j < 6; j++)
    {
      if(stats[j] > highest)
      {
       highest = stats[j];
       index_of_highest = j;
      }
      
    }
    
    for(int j = 0; j < 6; j++)
    {
      if(j != index_of_highest)
      {     
        if(stats[j] > highest_2)
        {
         highest_2 = stats[j];
         index_of_highest_2 = j;
        }
        
      }

    }
    
    String[] sav_throws = {"", ""};
    sav_throws[0] = dnd_char.dnd_class.saving_throws.get(0).index;
    sav_throws[1] = dnd_char.dnd_class.saving_throws.get(1).index;
    
    
     
      switch(sav_throws[0])
      {
        case "str": dnd_char.stats[0] = stats[index_of_highest];   
        break;
        case "dex": dnd_char.stats[1] = stats[index_of_highest];   
        break;
        case "con": dnd_char.stats[2] = stats[index_of_highest];  
        break;
        case "int": dnd_char.stats[3] = stats[index_of_highest];    
        break;
        case "wis": dnd_char.stats[4] = stats[index_of_highest];  
        break;
        case "cha": dnd_char.stats[5] = stats[index_of_highest];
        break;
      }
      
      
      switch(sav_throws[1])
      {
        case "str": dnd_char.stats[0] = stats[index_of_highest_2];   
        break;
        case "dex": dnd_char.stats[1] = stats[index_of_highest_2];   
        break;
        case "con": dnd_char.stats[2] = stats[index_of_highest_2];  
        break;
        case "int": dnd_char.stats[3] = stats[index_of_highest_2];    
        break;
        case "wis": dnd_char.stats[4] = stats[index_of_highest_2];  
        break;
        case "cha": dnd_char.stats[5] = stats[index_of_highest_2];
        break;
      }
      
      int index_for_stats = 0;
      int j = 0;
      boolean done = false;
      while(!done)
      {
       
        if(j == 6)
        {
         done = true; 
        }
        else
        {    
          if(j != index_of_highest && j != index_of_highest_2)
          { 
            if(dnd_char.stats[index_for_stats] == 0)
            {
              dnd_char.stats[index_for_stats] = stats[j];
              index_for_stats++;
              j++;
            }
            else
            {
             index_for_stats++; 
            }   
          }
          else
          {
             j++;
          }  
        }
      }
 
}


void keyPressed(){
  if(key == 'r')
  {
    setup();  
  }
  
}



  
