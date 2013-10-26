/*
 * ReceiveMultipleFieldsBinaryToFile_P
 *
 * portIndex must be set to the port connected to the Arduino
 * based on ReceiveMultipleFieldsBinary, this version saves data to file
 * Press any key to stop logging and save file
 */

import processing.serial.*;
import java.util.*;
import java.text.*;

PrintWriter output;
DateFormat fnameFormat= new SimpleDateFormat("yyMMdd_HHmm");
DateFormat  timeFormat = new SimpleDateFormat("hh:mm:ss");
String fileName;

Serial myPort;  // Create object from Serial class
short portIndex = 8;
String val;     // Data received from the serial port

PImage baby;
PImage schmidt;
int i = 0;

void setup() {
 
  String portName = Serial.list()[portIndex]; 
  myPort = new Serial(this, portName, 9600); 
  
  Date now = new Date();
  fileName = fnameFormat.format(now);
  output = createWriter("Box Documents/Default Sync Folder/" + fileName + ".txt"); // save the file in the sketch folder
  
  output.println("{");
  output.println("  \"" + fileName + "\": [ ");
  
  size(500,800);
  
  baby = loadImage("baby.png");
  schmidt = loadImage("schmidt.png");
}

void draw() {
  
  i++;
  
  if ( myPort.available() > 0) {
    
    val = myPort.readStringUntil('\n');
    
    if (val != null) {
      
      background(0);
      
      int tmp = int(val);
      tmp = (tmp % 1000)/2;
      
      println("Temp: " + tmp);
      
      int red = 0;
      int green = 255;
      
      if (tmp > 0) {
        red = (255/tmp)*255;
        green = tmp-(255/tmp)*255;
      }
      
      fill(red,green,0);
      rect(100,(3*tmp/2),50,height);
      
      
      
      if (i >= 59) {
        
        i = 0;
        
        String timeString = timeFormat.format(new Date());
      
        output.println("    {");
        output.println("      \"time\" : \"" + timeString + "\",");
        output.println("      \"intensity\" : " + val);
        output.println("    },");
      
        // println(val); //print it out in the console
      }
    }
  } 
}

void keyPressed() {
  
  output.println("    {}");
  output.println("  ]");
  output.println("}");
  output.flush(); // Writes the remaining data to the file
  output.close(); // Finishes the file
  exit(); // Stops the program
}
