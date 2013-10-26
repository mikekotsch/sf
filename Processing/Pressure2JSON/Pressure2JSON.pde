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

void setup() {
 
  String portName = Serial.list()[portIndex]; 
  myPort = new Serial(this, portName, 9600); 
  
  Date now = new Date();
  fileName = fnameFormat.format(now);
  output = createWriter(fileName + ".txt"); // save the file in the sketch folder
  
  output.println("{");
  output.println("  \"" + fileName + " ");
}

void draw() {
  if ( myPort.available() > 0) {
    val = myPort.readStringUntil('\n');
    
    if (val != null) {
       println(val); //print it out in the console
    }
  } 
}

void keyPressed() {
  
  output.println("}");
  output.flush(); // Writes the remaining data to the file
  output.close(); // Finishes the file
  exit(); // Stops the program
}
