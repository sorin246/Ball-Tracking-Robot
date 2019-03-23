import processing.io.*;
import gohai.glvideo.*;
import RPi.GPIO as G;
GLCapture video;
color trackColor;
void setup(){
    size(320, 240, P2D);
    video = new GLCapture(this);
    video.start();

    trackColor = color(255, 0, 255);
    G.pinMode(4, G.OUTPUT);
    G.pinMode(14, G.OUTPUT);
    G.pinMode(17, G.OUTPUT);
    G.pinMode(18, G.OUTPUT);
}
void draw(){
    background(0);
    if (video.availible()){
        video.read();
}
    video.loadPixels;
    image(video, 0, 0);

    float worldRecord = 500;
    int closestX = 0;
    int closestY = 0;

    for (int x = 0;x < video.width; x ++){
        for(int y = 0; y < video.height; y ++){
            int loc = x + y * video.width;
            color currentColor = video.pixels[loc];
            float r1 = red(currentColor);
            float g1 = green(currentColor);
            float b1 = blue(currentColor);
            float r2 = red (trackColor);
            float g2 = green(trackColor);
            float b2 = blue (trackColor);

            float d = dist (r1, g1, b1, r2, g2, b2);

            if (d < worldRecord){
                worldRecord = d;
                closestX = x;
                closestY = y;
            }
        }
    }
    if (worldRecord < 10){
        fill(trackColor);
        strokeWeight(4.0);
        stroke(0);
        ellipse(closestX, closestY, 16, 16);
        println(closestX, closestY);

        if (closestX < 140)
        {
            G.digitalWrite(4, G.HIGH);
            G.digitalWrite(14, G.HIGH);
            G.digitalWrite(17, G.HIGH);
            G.digitalWrite(18, G.LOW);
            delay(10);
            G.digitalWrite(4, G.HIGH);
            G.digitalWrite(14, G.HIGH);
            G.digitalWrite(17, G.HIGH);
            G.digitalWrite(18, G.HIGH);

            println("Turn Right");
        }
        else if (closestX > 200)
        {
            G.digitalWrite(4, G.HIGH);
            G.digitalWrite(14, G.LOW);
            G.digitalWrite(17, G.HIGH);
            G.digitalWrite(18, G.HIGH);
            delay(10);
            G.digitalWrite(4, G.HIGH);
            G.digitalWrite(14, G.HIGH);
            G.digitalWrite(17, G.HIGH);
            G.digitalWrite(18, G.HIGH);
            println("Turn Left");
            
      else if (closestY < 170)
      {
            G.digitalWrite(4, G.HIGH);
            G.digitalWrite(14, G.LOW);
            G.digitalWrite(17, G.HIGH);
            G.digitalWrite(18, G.HIGH);
            delay(10);
            G.digitalWrite(4, G.HIGH);
            G.digitalWrite(14, G.HIGH);
            G.digitalWrite(17, G.HIGH);
            G.digitalWrite(18, G.HIGH);
            println("GO Frwd");
      }
        else
        {
         G.digitalWrite(4, G.HIGH);
         G.digitalWrite(14, G.HIGH);
         G.digitalWrite(17, G.HIGH);
         G.digotalWrite(18, G.HIGH);
        }
        }
        
        viod mousePressed(){
          int loc = mouseX = mouseY * video.width;
          trackColor = video.pixels[loc];
        }
