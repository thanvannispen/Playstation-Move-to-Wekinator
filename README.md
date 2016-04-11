# Playstation-Move-to-Wekinator

* A description of the types of things this feature extractor could be used for:
This Processing application will send accelerometer X, Y, Z values and the gyroscope values of X, Y, Z of Playstation Move controller(s) to Wekinator.
The application sends 6 inputs to port 6488 via osc.
It can for instance be used for air drumming, virtual conducting and / or creating a light show. 


* Dependencies:
PS Move API: https://thp.io/2010/psmove/
The PS Move API is an open source library for Linux, Mac OS X and Windows to access the Sony Move Motion Controller via Bluetooth and USB directly from your PC without the need for a PS3.

oscP5 is an OSC implementation for the programming environment processing.
http://www.sojamo.de/libraries/oscP5/

* How to run it and use it
1. Make sure to have the dependencies installed
2. Open the playstationMovetoWekinator.pde in Processing and run it.
3. Use Wekinator, the WekiInputHelper (or other OSC-application) to start using it
4. When using Wekinator and/or the WekiInputHelper, you can start experimenting with the basic Max/MSP demo file
