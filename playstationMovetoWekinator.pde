/**
* Simple processing sketch that sends playstation move controller movement data 
* to the awesome Wekinator application 
* This sends 6 input values to port 6448 using message /wek/inputs
* It also listens to port 12012 for green / red lights on/off messages
**/

// playstation move controller to Wekinator application in Processing   


// Import the PS Move API and P5 OSC Packages
import io.thp.psmove.*;
import oscP5.*;
import netP5.*;
OscP5 oscP5;
NetAddress myRemoteLocation;

PSMove [] moves;

int lightState = 0;

void setup() {
  size(60, 60);
    oscP5 = new OscP5(this,12012);

  myRemoteLocation = new NetAddress("127.0.0.1",6448);

  moves = new PSMove[psmoveapi.count_connected()];
  for (int i=0; i<moves.length; i++) {
    moves[i] = new PSMove(i);
  } 
}

void handle(int i, PSMove move)
{
  float [] ax = {0.f}, ay = {0.f}, az = {0.f};
  float [] gx = {0.f}, gy = {0.f}, gz = {0.f};
  float [] mx = {0.f}, my = {0.f}, mz = {0.f};

  while (move.poll() != 0) {}
   
  move.get_accelerometer_frame(io.thp.psmove.Frame.Frame_SecondHalf, ax, ay, az);
  move.get_gyroscope_frame(io.thp.psmove.Frame.Frame_SecondHalf, gx, gy, gz);
  move.get_magnetometer_vector(mx, my, mz);
  
        //Send over OSC

        OscBundle PSMoveOSC = new OscBundle();        
        OscMessage myMessage = new OscMessage("/wek/inputs");
        myMessage.add(ax);
  
        /* refill the osc message object again - ay */
        myMessage.add(ay);

        /* az */
        myMessage.add(az);

        /* gx */
        myMessage.add(gx);
  
        /* gy */
        myMessage.add(gy);
   
        /* gz */
        myMessage.add(gz);
 
        oscP5.send(myMessage, myRemoteLocation); 
        // limit data-flow to 25 p/s
        delay(40);
        
 // do something with light feedback via OSC    
 switch (lightState)
 {
   case 0: move.set_leds(0, 0, 0); 
   break;
   case 1:move.set_leds(0, 255, 0); 
   break;
   case 2:move.set_leds(255, 0, 0); 
   break;
 }
  move.update_leds();        
}

void draw() {
  for (int i=0; i<moves.length; i++) {
    handle(i, moves[i]);
  }
}

/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
// lightstate is currently 1, or 0

  lightState = theOscMessage.get(0).intValue();
}