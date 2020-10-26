# Flappifier-1000
Flappifier-1000 is a simple program that can be used to complete levels of Flappy Golf 2. It takes control of the keyboard in order to precisely make moves at certain time intervals as designated in the database.
## Usage
The program may be run directly inside xcode or built and run using the command line shell inside the products folder of xcode. When running you must drag in the `DRAGME.plist` from within the Flappifier 1000 folder or create your own or edit the existing file.
## How It Works
The code is quite primitive first the plist is loaded as a dictionary. Next the array of the desired hole# and course are loaded. The flap for each index of the array is appended to the DispatchQueue to be asyncronysouly execute a set maneuver and a DispatchGroup is opened to hold the program until all flaps have been executed. When the DispatchQueue block is called the direction of the flap is determined and then using CoreGraphics keyboard events are registered and posted.

