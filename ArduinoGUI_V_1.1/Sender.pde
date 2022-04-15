import controlP5.*; //import controlp5 library
//import java.io.*;

//=========================================
import processing.serial.*;
Serial myPort;
//=========================================

ControlP5 cp5;

PFont headingFont;
PFont paragraphFont;
PFont inputFont;

String textValue = "";

PShape largeCirc;
PShape medCirc;
PShape smallCirc;

PShape bangShadow;
PShape textFieldShadow;

void setup() {

  size(400, 400);

  cp5 = new ControlP5(this);

  headingFont = createFont("calibri bold", 24);
  paragraphFont = createFont("calibri bold", 16);
  inputFont = createFont("calibri bold", 32);

  //===========================================================
  printArray(Serial.list());
  myPort = new Serial(this, "COM4", 9600);
  //==========================================================

  largeCirc = createShape(ELLIPSE, 175, -150, 500, 500); // creates and sets properties of circle
  largeCirc.setFill(color(147, 228, 230));
  largeCirc.setStroke(false);

  medCirc = createShape(ELLIPSE, 175, -150, 200, 200); // creates and sets properties of circle
  medCirc.setFill(color(147, 228, 230)); //
  medCirc.setStroke(false);

  smallCirc = createShape(ELLIPSE, 175, -150, 90, 90); // creates and sets properties of circle
  smallCirc.setFill(color(147, 228, 230));
  smallCirc.setStroke(false);

  bangShadow = createShape(RECT, 25, 235, 80, 40); // creates and sets properties of circle
  bangShadow.setFill(color(0, 45, 90));//0, 45, 90
  bangShadow.setStroke(false);

  textFieldShadow = createShape(RECT, 25, 155, 200, 40); // creates and sets properties of circle
  textFieldShadow.setFill(color(116, 159, 254));//0,116,217
  textFieldShadow.setStroke(false);

  cp5.addTextfield("Input: ")  //Creates and sets properties of input text field
    .setPosition(20, 150)
    .setSize(200, 40)
    .setFont(inputFont)
    .setFocus(true)
    .setColor(color(255, 255, 255));

  cp5.getController("Input: ").getCaptionLabel().setColor(color(116, 159, 254)); //sets "Input: " text color

  cp5.addBang("Submit")        //Creates and sets properties of submit bang (button)
    .setPosition(20, 230)
    .setSize(80, 40)
    .setFont(paragraphFont)
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);

  cp5.getController("Submit").setColorForeground(color(116, 159, 254));
}

void controlEvent(ControlEvent theEvent) {
  if (theEvent.isAssignableFrom(Textfield.class)) {
    textValue = cp5.get(Textfield.class, "Input: ").getText();
    println("controlEvent: accessing a string from controller 'input' : "
      +textValue);
    //==========================================================
    myPort.write(textValue);
    //==========================================================
  }
  if (theEvent.getController().getName()=="Submit") {
    textValue = cp5.get(Textfield.class, "Input: ").getText();
    println("controlEvent: accessing a string from controller 'input' : "
      +textValue);
    //==========================================================
    myPort.write(textValue);
    //==========================================================
    cp5.get(Textfield.class, "Input: ").clear();
  }
}

void Submit () {
  //myPort.write(cp5.get(Textfield.class, "Input: ").getText());
  println(cp5.get(Textfield.class, "Input: ").getText());
}

void draw() {
  background(255, 255, 255);

  shape(largeCirc, 25, 25);
  shape(medCirc, 120, 400);
  shape(smallCirc, -100, 480);

  shape(bangShadow);
  shape(textFieldShadow);

  fill(0, 45, 90);
  textFont(headingFont);
  text("      Department of Defense \n Non-Satelite Communication", 50, 30);
}
