# [[[Block Dungeon]]]
# Directions
  Once downloaded you can run this project on processing. (https://processing.org/download/) <b>WARNING!!!</b> you need to have the sound library installed for this project to run. This can be done by clicking "sketch", then select "Add Library..." from the "Import Library..." submenu within the Sketch menu. search "sound" and add it.<br></br>
  After you run the program you will see a menu, where if you click the button in the bottom center the game will start.
# How To Play
  Use the <b>WASD</b> keys to move . <br></br>
  Aim using the crosshair that follows the mouse. (+). <b>Left click</b> to shoot. 
  You can pause at any time by clicking 'm' for the menu and 'm' again to resume (or using the mouse to hit 'play')
  You can zoom in or out by using 'i' for in and 'o' for out. You can also use the <b>Mouse Wheel</b> to zoom in/out.
  
  You start off holding the handgun (7 bullet capacity). After shooting seven times you can right-click to reload or hit the 'r' key. You can switch to the Auto-Rifle  by pressing 'e' or the center mouse button (and by pressing it again you can switch back). <br></br>
<b>Guns:</b>
The auto-rifle requires a magazine to reload. You can aquire magazines by killing enemies (who can drop them randomly). It has 12 rounds per magazine. The handgun can be reloaded infinitely, it has 7 rounds.

  The slow motion effect can be activated or deactivated by pressing the <b>|spacebar|</b>. You will see the neon blue bar drain as you use the slow motion effect. This effects slows bullets to the same speed as the user can move. firerate also increases. enemis also slow down.
  
  The Health bar is displayed on the top left (along with bullets, slow motion bar and magazines). You begin with 12 health. every 4 seconds you regain one health up to a max of ten. body shots take one damage and headshots take two damage.
  
  Your goal is to kill all the enemies and reach the last room. Enemeis spawn as you enter the room. If you die you will just restart from the begining. If you reach the end you respawn in a harder floor with more rooms with two more magazines. 
  **holding down 'w', 's' and then right clicking activates "god mode", only for quitters though ;)**
# Developement Log 
<br> 5/17/19: started the project, made the repo and laid the basic foundation for the game</br>
<br> 5/18/19: started the person class which will be used for the enemies and player. started wall class and terrain generation</br>
<br> 5/19/19: Made the player head & body. made the arm follow the mouse. </br>
<br> 5/20/19: made the player move, with the wasd keys, including when holding two buttons down. </br>
<br> 5/21/19: added the particle effects. squares spread out. Tested them by making them appear on mouse clicks. </br>
<br> 5/22/19: started the gun shape and turning effects on arm. </br>
<br> 5/23/19: continued working on gun (bug present). </br>
<br> 5/24/19: gun fixed, moving on to collision detection. </br>
<br> 5/26/19: shooting added. bullets move on their own. continued working on collison -isTouching(). </br>
<br> 5/27/19: collision works!!! user cannot move through walls bullets collide with walls. bullets now come directly out of the guns!!! Sounds for shooting added!!!</br>
<br> 5/28/19: fixed sounds, made cartridges rotate as they fall. Added walking animation. 
<br> 5/29/19: worked on scaling the world and finding correct way to translate back </br>
<br> 5/30/19: fixed scaling, by making world scale around character. realized different git account was commiting because of switching to desktop </br>
<br> 5/31/19: got started on the map and floors. made the enemies graphics and positioning, made the bullets dealing damage feature </br>
<br> 6/1/19: made offset moving to make it smoother and more realistic. added reloading after firing a certain number of bullets. added getting hurt noises</br>
<br> 6/2/19: bullets and headbars. headbars retain size and position when zooming in and out. Made rooms. number of rooms&floors can be modified</br>
<br> 6/3/19: headshots deal double damage. automatic rifle added. more info present on pause/start page. </br>
<br> 6/4/19: made the "Room" class. Room class makes that obstacles that do not block the entrances </br>
# Sources
-sounds from http://soundbible.com/tags-gun.html
