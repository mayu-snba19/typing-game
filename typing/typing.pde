PImage back;
PImage cat;
int score=0; //スコア
String letters[]={"Java","PHP","Javascript","Python","C++","C#","COBOL","Swift","C","Brainfuck","Go","Haskell","Julia","Kotlin","Mathematica","Perl","Processing","R","Ruby","Rust"}; //タイピングする文字
String letter; //現在の文字列
int now=0; //現在の文字位置
int time=1800; //時間
int mistake=0; //ミスタイプ数
int cnt=0; //連続タイプ(10ごとに0になる)

void setup(){
    size(900,600);
    PFont font = createFont("Osaka",50);
    back=loadImage("back.PNG"); 
    cat=loadImage("cat.PNG");
    textFont(font);
    textSize(50);
    textAlign(CENTER);
    letter=letters[(int)random(letters.length)];
}

void draw(){
    image(back,0,0);
    if(frameCount>=180){
        letter=letters[(int)random(letters.length)];
        now=0;
        frameCount=0;
    }
    fill(255,255,255);
    text("ミスタイプ"+mistake+" "+letter,450,300);
    if(time<=0) {
        image(back,0,0);
        fill(255,255,255);
        text("SCORE:"+score+"ミスタイプ数 :"+mistake,450,300);
        noLoop();
    }
    fill(255,0,0);
    noStroke();
    rect(0,0,time/2,20);
    fill(255,255,255);
    text(letter.charAt(now),450,500);
    time--;
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
              time+=200;
          }
        }
    }else if(keyCode==SHIFT){
        cnt++;
    }else{
        mistake++;
        cnt=0;
    }
}
