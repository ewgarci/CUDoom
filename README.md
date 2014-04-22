CUDoom
======

  Raycasting Video Game class project for CS4840 Embedded Systems at Columbia University during Spring 2013. The project was implemented on an Altera DE2 board with a Cyclone II FPGA and Nios 2 embedded processor. 

  CUDoom is a project inspired by the Doom, one of the last video games to use 
ray casting techniques to create a pseudo 3D environment. CUDoom creates a similar 3D 
world and allows a player to freely move around it. Among the key features in CUDoom 
is the fact that the entire world is fully texture mapped to the player’s perspective. Walls 
can be set to two different heights, the floor consists of tiles of different textures and the 
sky rotates to match the player’s frame of view. 

  The project is divided into software and hardware components. The software 
keeps track of the player position and frame of view, accepts keyboard inputs and 
generates music for the world. Hardware consists of a ray casting accelerator and the 
logic needed to texture map the environment. Individual screen pixel calculations are 
generated on the fly and the project runs smoothly at 60 frames per second for a 640x480 
screen. 

* Report - http://www.cs.columbia.edu/~sedwards/classes/2013/4840/reports/CUDoom.pdf
* Video - https://www.youtube.com/watch?v=_EH0gy6nLOs&feature=youtu.be
