### Project Information
#### Group Project:
##### `CSE341`
##### `BRAC UNIVERSITY` </br >
#### Group Members: </br >
##### <li>`Tauki Tahmid` </li>
##### ID: `15101051` </br > </br >
##### <li>`Samin _______` </li>
##### ID: `__________` </br >

</br >
#### A sample `emu8086.inc` file is present in the `Project\inc` folder </br >
#### All the included pre-defined procedures `to be included` should be put under `Project\inc` folder
</br >
##### Project Instructions </br >
<li> Variables are defined </li>
<li> The variable called `userInput_main` will be used to take input from main procedure, using which the user will decide which procedure to run </li>
<li> The variable `userInput_secondary` is to be used for inputs </li>
<li> If the program to be included is to be included directly to the main program, it has to be in one single procedure, no more procedure will be included other than the present ones </li>
<li> For other functions or procedures to be included if necessary only for the program, Some common functions that can make writing the program easily, which has (has to have) some significance or, which has to be used more than once in the program, can be included as a different procedure </li>
<li> A list of all globally available procedures and macros is included in this file </li>
<li> Future global procedures and macros (if there is any) will be included in this file after they are made </li>
</br >
##### Available Global Procedures </br >
<li> `main` - it will decide upon userInput_main </li>
<li> `NotValid` - this proc will clear the screen and print NotValid, and will return to the calling procedure</li>
<li> `reset_reg` - this procedure will reset every general purpose registers to 0 and return to the calling procedure </li>
<li> `newLine` - this procedure will print a new Line (will move the curser to the next Line) and return to the calling procedure </li>
<li> `Fibonacci` - this procedure will handle Fibonacci related functions and return to main afterward</li>
<li> `HappyNumber` - this procedure will handle Happy Number related functions and return to main afterward </li>
<li> `PerfectNumber` - this procedure will handle Perfect Number related functions and return to main afterward </li>
</br >
##### Available Global procedures Imported from `emu8086.inc` </br >
<li>`scan_num` - to take number inputs from user. procedure will get the multi-digit SIGNED number from the keyboard, and stores the result in CX register.</li>
<li> `get_String` - procedure to get a null terminated string from a user, the received string is written to buffer at DS:DI, buffer size should be in DX. Procedure stops the input when 'Enter' is pressed</li>
<li> `print_num` - procedure that prints a signed number in AX register </li>
<li> `print_num_uns` - procedure that prints out an unsigned number in AX register </li>
<li> `clear_screen` - procedure to clear the screen, (done by scrolling entire screen window), and set cursor position to top of it </li>
<li> `print_String` - procedure to print a null terminated string at current cursor position, receives address of string in DS:SI register </li>
<li> `pthis` - procedure to print a null terminated string at current cursor position (just as PRINT_STRING), but receives address of string from Stack. The ZERO TERMINATED string should be defined just after the CALL instruction. </li> </br > 
For example: </br >

CALL PTHIS </br >
db 'Hello World!', 0 </br >

##### Available Global macros Imported from `emu8086.inc` </br >

<li>`PUTC char` - macro with 1 parameter, prints out an ASCII char at current cursor position </li>
<li> `GOTOXY col`, row - macro with 2 parameters, sets cursor position </li>
<li> `PRINT string` - macro with 1 parameter, prints out a string </li>
<li> `PRINTN string` - macro with 1 parameter, prints out a string. The same as PRINT but automatically adds "carriage return" at the end of the string </li>
<li> `CURSOROFF` - turns off the text cursor </li>
<li> `CURSORON` - turns on the text cursor. </li>
