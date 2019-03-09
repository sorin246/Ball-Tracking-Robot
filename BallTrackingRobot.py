import processing.io.*;
import gohai.glvideo.*;
GLCapture video;
color trackColor;
void setup(){
    size(320, 240, P2D);
    video = new GLCapture(this);
    video.start();

    trackColor = color(255, 0, 0);

    
