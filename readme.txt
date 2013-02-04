Instructions


1.) Install NME


Make sure you have NME installed on your system. You can check by running "haxelib run nme" from a 
command-prompt or terminal.



2.) Install Actuate


This sample requires the "Actuate" library from haxelib. You can install from a command-prompt or
terminal with this command:
	
	haxelib install actuate


	
3.) Running the sample


If you using FlashDevelop, open "Actuate Example.hxproj" and hit Ctrl+Enter to build for Flash.

To build for other targets, go to Project > Properties > Run Custom Command... (Edit...) and change
the value from "flash" to another target, like "windows", "android" or "webos". Make sure that you
have set up the dependencies for these targets before using them.


If you are not using FlashDevelop, you can use a terminal to run the sample:
	
	haxelib run nme test "Actuate Example.nmml" flash
	
	
You can also use "nme" instead of "haxelib run nme" if the shortcut is available on your system.
If it is not available, you should be able to run "sudo haxelib run nme setup" to install it.

To build for other targets, use another string, like "linux", "mac", "ios" or "webos" when running
the above command. Make sure that you have set up the dependencies for these targets before using
them.