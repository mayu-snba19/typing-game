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
String letters[]={"Java","PHP","Javascript","Python","C++","C#","COBOL","Swift","Brainfuck","Go","Haskell","Julia","Kotlin","Mathematica","Perl","Processing","R","Ruby","Rust"}; //タイピングする文字
String letter; //現在の文字列
int now=0; //現在の文字位置
int time=1800; //時間
int mistake=0; //ミスタイプ数
int cnt=0; //連続タイプ(10ごとに0になる)
boolean error=false;
int error_count=0;
boolean texttf=false;
int texttf_count=0;

void setup(){
    size(900,600);
    minim = new Minim( this );
    backsong = minim.loadFile( "back.mp3" );
    nekosound=minim.loadFile("nekosound.mp3");
    money=minim.loadFile("money.mp3");
    PFont font = createFont("Osaka",50);
    back=loadImage("back.PNG"); 
    cat=loadImage("cat.PNG");
    fish=loadImage("sakana.PNG");
    cat2=loadImage("endneko.PNG");
    textFont(font);
    textSize(50);
    textAlign(CENTER);
    letter=letters[(int)random(letters.length)];
    backsong.play();
}

void draw(){
    image(back,0,0);
    image(cat,frameCount*5-100,400);
    if(error){
        image(fish,0,0);
        error_count++;
        if(error_count>=50) {
            error=false;
            error_count=0;
        }
    }
    if(frameCount>=180){
        letter=letters[(int)random(letters.length)];
        now=0;
        frameCount=0;
    }
    fill(255,255,255);
    textAlign(CENTER);
    text(letter,450,200);
    text("now : "+letter.charAt(now),450,260);
    if(time<=0) {
        image(back,0,0);
        fill(255,255,255);
        textAlign(CENTER);
        text("SCORE:"+score+"  ミスタイプ数 :"+mistake,450,200);
        image(cat2,0,0);
         backsong.close();
        noLoop();
    }
    fill(141,217,163);
    noStroke();
    rect(0,0,time/2,20);
    time--;
    if(texttf){
        fill(0,212,166);
        text("PLUS",800,80);
        texttf_count++;
        if(texttf_count>=50){
            texttf_count=0;
            texttf=false;
        }
    }
    
}

//キーが押されたら
void keyPressed() {
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

void stop()
{
  nekosound.close();
  backsong.close();
  minim.stop();
  super.stop();
}
