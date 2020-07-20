
import ddf.minim.*;
Minim minim;
AudioPlayer nekosound;
AudioPlayer backsong;
AudioPlayer money;
PImage back;
PImage cat;
PImage fish;
PImage cat2;
int score=0; //スコア
//タイピングに使う文字
String letters[]={"cluster","reaction","illuminate","friend","Japan","beauty","wonderful","cake","chocolate",
"piano","cookie","juice","apple","banana","pizza","UFO","spaghetti","pasta","curry","India","parfait","marriage",
"pretty","Snoopy","lovery","peanuts","baseball","rugby","bicycle","Pokemon","shopping","gateway","LINE",
"escape","traveler","pretender","happy","star","Processing","Java"}; 
String letter; //現在の文字列
String letter2; //文字色を変えるための文字列
int now=0; //現在の文字位置
int time=1800; //時間
int mistake=0; //ミスタイプ数
int cnt=0; //連続タイプ(10ごとに0になる)
boolean error=false;
int errorCount=0;
boolean texttf=false;
int texttfCount=0;
boolean play=true;

void setup(){
    size(900,600);
    minim = new Minim( this );
    backsong = minim.loadFile( "back.mp3" );
    nekosound=minim.loadFile("nekosound.mp3");
    money=minim.loadFile("money.mp3");
    PFont font = createFont("Osaka-Mono",50);
    back=loadImage("back.PNG"); 
    cat=loadImage("cat.PNG");
    fish=loadImage("sakana.PNG");
    cat2=loadImage("endneko.PNG");
    textFont(font);
    textSize(60);
    textAlign(CENTER);
    letter=letters[(int)random(letters.length)];
    letter2="";
    backsong.play();
}

void draw(){
   if(play){
    image(back,0,0);
    image(cat,frameCount*5-100,400);
    if(error){
        image(fish,0,0);
        errorCount++;
        if(errorCount>=50) {
            error=false;
            errorCount=0;
        }
    }
    if(frameCount>=180){
        letter=letters[(int)random(letters.length)];
        now=0;
        frameCount=0;
    } 
    fill(255,255,255);
    textAlign(CENTER);
    text(letter,450,230);
    letter2="";
    for(int i=0;i<now;i++){
        letter2+=" ";
    }
    letter2+=letter.charAt(now);
    for(int i=now+1;i<letter.length();i++){
        letter2+=" ";
    }
    fill(255,0,0);
    text(letter2,450,230);
    if(time<=0) {
        image(back,0,0);
        fill(255,255,255);
        textAlign(CENTER);
        text("SCORE:"+score+"  ミスタイプ数 :"+mistake,450,200);
        image(cat2,0,0);
        play=false;
    }
    fill(141,217,163);
    noStroke();
    rect(0,0,time/2,20);
    time--;
    if(texttf){
        fill(255,0,0);
        text("PLUS",800,80);
        texttfCount++;
        if(texttfCount>=50){
            texttfCount=0;
            texttf=false;
        }
    }
   }else{
       //リスタート
       if(mousePressed==true) {
           if(mouseX>=550 &&mouseX<=750 && mouseY>=300 && mouseY<=350){
                play=true;
                //全てを初期化する
                letter=letters[(int)random(letters.length)];
                letter2=""; 
                now=0; 
                time=1800;
                mistake=0; 
                cnt=0; 
                error=false;
                errorCount=0;
                texttf=false;
                texttfCount=0;
                score=0;
                frameCount=0;
                textSize(60);
                backsong.rewind();
                backsong.play();
           } 
       }else{
            fill(255,255,255);
            rect(550,300,200,40);
            fill(0,0,0);
            textSize(20);
            text("retry",650,325);
       } 
   }
}

//キーが押されたら
void keyPressed() {
   if(play){
    //もし正解していたら
    if(key==letter.charAt(now)){
        score++;
        now++;
        cnt++;
        if(now==letter.length()){
          letter=letters[(int)random(letters.length)];  
          now=0;
          frameCount=0;
          if(cnt>=10){
              cnt=0;
              time+=50;
              texttf=true;
              money.rewind();
              money.play();
          }
        }
        letter2="";
        for(int i=0;i<now;i++){
            letter2+=" ";
        }
        letter2+=letter.charAt(now);
        for(int i=now;i<letter.length();i++){
            letter2+=" ";
        }
        fill(255,0,0);
        text(letter2,450,230);
    }else if(keyCode==SHIFT){
        cnt++;
    }else{
        mistake++;
        cnt=0;
        nekosound.rewind();
        nekosound.play();
        error=true;
    }
   }
}

void stop(){
  nekosound.close();
  backsong.close();
  minim.stop();
  super.stop();
}
