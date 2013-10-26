int sensorPin = A0;    // analog input pin to hook the sensor to
int sensorValue = 0;  // variable to store the value coming from the sensor
int potentiometer = 0; 

void setup() {
  Serial.begin(9600); // initialize serial communications
  pinMode(potentiometer, INPUT);
}
 
void loop() {
  int value = analogRead(potentiometer);
  //Serial.println(value); //pirnt the value on the serial monitor screen
  Serial.write(value); // print bytes to serial
  delay(100);
}
