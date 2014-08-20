#include <message.h>
#include <SoftwareSerial.h>
#include <printhex.h>
boolean debugMode = true;
// motor A (right side)
int dir1PinA = 13;
int dir2PinA = 12;
int motorRightSpeedPin = 10;
// motor B (left side)
int dir1PinB = 11;
int dir2PinB = 8;
int motorLeftSpeedPin = 9;
SoftwareSerial mySerial(0, 1); // указываем пины rx и tx

//unsigned long time;
int speed;

void setup() {
  Serial.begin(9600); // begin serial communication
  Serial.println("TEsT"); // debug string
  pinMode(dir1PinA, OUTPUT);
  pinMode(dir2PinA, OUTPUT);
  pinMode(motorRightSpeedPin, OUTPUT);
  pinMode(dir1PinB, OUTPUT);
  pinMode(dir2PinB, OUTPUT);
  pinMode(motorLeftSpeedPin, OUTPUT);
 // time = millis();
  speed = 0;
}


void loop() {

    if(Serial.available()>0)  
    {  
         //make sure we have all the data 
      delay(7);
      //serial data is waiting, lets extract      
      int i;
      char bufferText[6];
      i=0;      
      while(i<6)
        {
        bufferText[i] =(char) Serial.read();
        //Serial.println(operation + X_buffer[i] + '0');
        i++;
        }
  
       //flush serial buffer of extra data>9999
      Serial.flush();
    
    
      
      String command = "";
      command = command + bufferText;
      processCommand(command);
    }  

}


void processCommand(String command)
{  
  String operation;
  operation =(String)' ';
 // serialPrintln("Command = " + command );
  serialPrintln("Obrabotka command");
 
  int IdCommand;
  int speed;
  int X6 = command[0] -'0';
  int X5 = command[1] -'0';
  int X4 = command[2] -'0';
  int X3 = command[3] -'0';
  int X2 = command[4] -'0';
  int X1 = command[5] -'0';
  IdCommand = 100 * X6 + 10 * X5 + X4;
  speed = 100 * X3 + 10 * X2 + X1;
   
  serialPrintln("X6 = " + operation + (char)(X6 +'0'));
  serialPrintln("X5 = " + operation + (char)(X5 +'0'));
  serialPrintln("X4 = " + operation + (char)(X4 +'0'));
  serialPrintln("X3 = " + operation + (char)(X3 +'0'));
  serialPrintln("X2 = " + operation + (char)(X2 +'0'));
  serialPrintln("X1 = " + operation + (char)(X1 +'0'));
  
  serialPrintln("IdCommand = " + operation + IdCommand);
  serialPrintln("speed = " + operation + speed);
  
  moveMotor(IdCommand, speed);
  

}


void moveMotor(int IdCommand, int speed)
{
  if (speed > 255 || speed < 0)
  {
    speed=100;
  }
  
  //---Глушим двигатели
   if (IdCommand == 000)
  {
    digitalWrite(dir1PinA, LOW);
    digitalWrite(dir2PinA, LOW);
    analogWrite(motorRightSpeedPin, 0);
    
    digitalWrite(dir1PinB, LOW);
    digitalWrite(dir2PinB, LOW);
    analogWrite(motorLeftSpeedPin, 0);
  }
  
  
  //---Левый двигатель вперёд
  if (IdCommand == 001)
  {
    digitalWrite(dir1PinB, HIGH);
    digitalWrite(dir2PinB, LOW);
    analogWrite(motorLeftSpeedPin, speed);
  }
  
  //---Левый двигатель назад
  if (IdCommand == 002)
  {
    digitalWrite(dir1PinB, LOW);
    digitalWrite(dir2PinB, HIGH);
    analogWrite(motorLeftSpeedPin, speed);
  }

  //Правый двигатель вперёд
  if (IdCommand == 003)
  {
    digitalWrite(dir1PinA, HIGH);
    digitalWrite(dir2PinA, LOW);
    analogWrite(motorRightSpeedPin, speed);
  }  

  //Правый двигатель назад
  if (IdCommand == 004)
  {
    digitalWrite(dir1PinA, LOW);
    digitalWrite(dir2PinA, HIGH);
    analogWrite(motorRightSpeedPin, speed);
  }  

  //Оба двигателя вперёд
  if (IdCommand == 005)
  {
    digitalWrite(dir1PinA, HIGH);
    digitalWrite(dir2PinA, LOW);
    digitalWrite(dir1PinB, HIGH);
    digitalWrite(dir2PinB, LOW);
    analogWrite(motorRightSpeedPin, speed);
    analogWrite(motorLeftSpeedPin, speed);
  } 

  //Оба двигателя назад
  if (IdCommand == 006)
  {
    digitalWrite(dir1PinA, LOW);
    digitalWrite(dir2PinA, HIGH);
    analogWrite(motorRightSpeedPin, speed);
    
    digitalWrite(dir1PinB, LOW);
    digitalWrite(dir2PinB, HIGH);
    analogWrite(motorLeftSpeedPin, speed);
  }
 
  //Тест робота
  
  /*if (IdCommand == 255)
  {
    moveMotor(002, 128);
    delay(1000);
    moveMotor(002, 128);
    delay(1000);
    moveMotor(003, 128);
    delay(1000);
    moveMotor(004, 128);
    delay(1000);
    moveMotor(005, 255);
    delay(1000);
    moveMotor(006, 255);
    delay(1000);
  }  */
}

// Вывод строки в последовательный порт.
void serialPrintln(String outputText) {
  if (debugMode) {
    Serial.println(outputText);
  }
}
