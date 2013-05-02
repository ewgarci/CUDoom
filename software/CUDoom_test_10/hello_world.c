//#include <io.h>
//#include <system.h>
//#include <stdio.h>
//
//#define IOWR_RAM_DATA(base, offset, data) \
//  IOWR_16DIRECT(base, (offset) * 2, data)
//
//#define IOWR_RAM32_DATA(base, offset, data) \
//  IOWR_32DIRECT(base, (offset) * 2, data)
//
//#define RED_8BIT 224
//#define GREEN_8BIT 28
//#define BLUE_8BIT 3
//
//void DrawColumn(unsigned int columnIndex, unsigned int color, unsigned startRow, unsigned int endRow);
//void DrawColumn32(unsigned int columnIndex, unsigned int color, unsigned int startRow, unsigned int endRow);
//
//int main()
//{
//
////	int x = 0;
////	int y = 0;
////
//////	while(1){
//////
//////	for (y = 1; y <  480 -100; y++) {
//////		for (x = 1; x < 639 ; x++) {
//////			DrawColumn(x, BLUE_8BIT, 0+y, 100+y);
//////		}
//////	}
//////
//////	}
////
//	printf("Hello World");
//
//	DrawColumn(120, BLUE_8BIT, 400, 410);
//	DrawColumn(220, RED_8BIT, 200, 250);
//	DrawColumn(320, GREEN_8BIT, 410, 470);
//
//
////	unsigned char code = 0;
//

//
//  return 0;
//}
//
//void DrawColumn(unsigned int columnIndex, unsigned int color, unsigned startRow, unsigned int endRow)
//{
//	IOWR_RAM_DATA(MEMORY_0_BASE, 0, columnIndex);
//	IOWR_RAM_DATA(MEMORY_0_BASE, 1, (color + (endRow<< 8)));
//	IOWR_RAM_DATA(MEMORY_0_BASE, 2, (endRow >> (9 - 1)) + (startRow << 1));
//}
//
//void DrawColumn32(unsigned int columnIndex, unsigned int color, unsigned int startRow, unsigned int endRow)
//{
//	IOWR_RAM32_DATA(MEMORY_TEX_0_BASE, 0, (columnIndex & 0x3FF));
//	IOWR_RAM32_DATA(MEMORY_TEX_0_BASE, 1, (endRow << 17) + (endRow<< 8) + color);
//}


/*
Copyright (c) 2004-2007, Lode Vandevenne

All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/


/*
g++ *.cpp -lSDL -O3 -W -Wall -ansi -pedantic
g++ *.cpp -lSDL
*/

//#include <math.h>
//#include <io.h>
//#include <system.h>
//#include <stdio.h>
//
//#define lookupLength 3480
//#define screenWidth 640
//#define screenHeight 480
//#define texWidth 64
//#define texHeight 64
//#define mapWidth 24
//#define mapHeight 24
//#define extensionFactor 4
//#define loopbackFactor 4
//
//#define RED_8BIT 0xE0 //red
//#define GREEN_8BIT 0x1C //green
//#define BLUE_8BIT 0x03 //blue
//#define YELLOW_8BIT 0xFC //yellow
//#define WHITE_8BIT 0xFF //white
//#define VIOLET_8BIT 0xE2 //violet
//
//
//#define posShift 22
//
//#define RAD 0.0018055130193045
//#define HALF_RAD 0.00090275650965225
//
//
//#define IOWR_RAM_DATA(base, offset, data) \
//  IOWR_16DIRECT(base, (offset) * 2, data)
//
//#define IOWR_RAM32_DATA(base, offset, data) \
//  IOWR_32DIRECT(base, (offset) * 2, data)
//
//char worldMap[mapWidth][mapHeight]=
//{
//  {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
//  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
//  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
//  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
//  {1,0,0,0,0,0,2,2,2,2,2,0,0,0,0,3,0,0,0,0,3,0,0,1},
//  {1,0,0,0,0,0,2,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,1},
//  {1,0,0,0,0,0,2,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,1},
//  {1,0,0,0,0,0,2,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,1},
//  {1,0,0,0,0,0,2,2,0,2,2,0,0,0,0,3,0,0,0,0,3,0,0,1},
//  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
//  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
//  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
//  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
//  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
//  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
//  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
//  {1,4,4,4,4,4,4,4,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
//  {1,4,0,4,0,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
//  {1,4,0,0,0,0,5,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
//  {1,4,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
//  {1,4,0,4,4,4,4,4,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
//  {1,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
//  {1,4,4,4,4,4,4,4,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
//  {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}
//};
//
//
////fixed point conversion functions
//int doubleToInt(double);
////int ToDouble(int);
//void DrawColumn(unsigned int columnIndex, unsigned int color, unsigned int startRow, unsigned int endRow, unsigned int side);
////void DrawColumn32(unsigned int columnIndex, unsigned int color, unsigned int startRow, unsigned int endRow, unsigned int side);
//void DrawTexture(unsigned int columnIndex, unsigned int texX, unsigned int rowStart, unsigned int rowEnd, unsigned int side, unsigned int texNum, unsigned int invLineHeight , unsigned int line_minus_h);
//void DrawTexture2(unsigned int columnIndex, unsigned int texX, unsigned int rowStart, unsigned int rowEnd, unsigned int side, unsigned int texNum, unsigned int invLineHeight , unsigned int h_minus_line);
////void DrawColumn(unsigned int columnIndex, unsigned int color, unsigned int lineHeight, unsigned int side);
//int absVal(int v);
//
//unsigned int startarray[640];
//unsigned int stoparray[640];
//
/////UNECESSARY CAN BE IMPLEMENTED WITHOUT THESE TWO LOOKUP
//int dirsine[lookupLength];
//int dircosine[lookupLength];
//
///// MEMORY HERE CAN BE CUT DOWN IF NECESSARY
//int sine[lookupLength];
//int cosine[lookupLength];
////int inv_sine[lookupLength];
////int inv_cosine[lookupLength];
//
//int main()
//{
//
//	IOWR_RAM_DATA(NIOSINTERFACE_0_BASE, 0, 0);
//	int dir = 0;
//	int posX = doubleToInt(22.0), posY = doubleToInt(11.5);  //x and y start position
// // int posX = 22, posY = 11;  //x and y start position
//  int x =0;
//
//  double sine_temp;
//  double cosine_temp;
//
//    for(x = 0; x < lookupLength ; x++)
//    {
//            //calculate ray position and direction
//
//        sine_temp = sin(x*RAD + HALF_RAD);
//        cosine_temp = cos(x*RAD + HALF_RAD);
//
//        dirsine[x] = doubleToInt(sin(x*RAD));
//        dircosine[x] = doubleToInt(cos(x*RAD));
//        sine[x] = doubleToInt(sine_temp);
//        cosine[x] = doubleToInt(cosine_temp);
//    }
//
//
//  int angle;
//  int fish_angle;
//  int move;
//
//  int k;
//  int k2;
//  //char key[] = { 'd','d','d','d','d','d','d','d', 'd','d','d','d','d','d','d','d', 'd','d','d','d','d','d','d','d', 'd','d','d','d','d','d','d','d', 'd','d','d','d','d','d','d','d', 'd','d','d','d','d','d','d','d', 'd','d','d','d','d','d','d','d', 'd','d','d','d','d','d','d','d','d','d','d','d','d','d','d','d',
////		  'd','d','d','d','d','d','d','d', 'd','d','d','d','d','d','d','d', 'd','d','d','d','d','d','d','d', 'd','d','d','d','d','d','d','d', 'd','d','d','d','d','d','d','d', 'd','d','d','d','d','d','d','d', 'd','d','d','d','d','d','d','d', 'd','d','d','d','d','d','d','d','d','d','d','d','d','d','d','d'};
//
//  unsigned char code = 0;
//  //char key[] = {'d'};
//  k2 = 0;
//  //start the main loop
//  //for (k2 = 0; k2 < sizeof(key); k2++)
//
//  int hardwareData = 0;
//
//  while(1)
//  {
//
//
////		while (!IORD_8DIRECT(DE2_PS2_0_BASE, 0)) ; /* Poll the status */
////		code = IORD_8DIRECT(DE2_PS2_0_BASE, 1);
//		//printf("%c, %x, %d\n", code, code, code);
//
//		/* Get received byte */
//
//	  code = 'k';
//
//	 hardwareData = IORD_16DIRECT(NIOSINTERFACE_0_BASE, 1);
//	 printf("%d\n", hardwareData);
//
//     x = 1;
//    for(k = -screenWidth/2; k < (screenWidth/2 - 1); k++)
//    {
//        angle = dir + k;
//
//        if ( angle < 0)
//                angle += lookupLength;
//
//        if (angle >= lookupLength)
//                angle -= lookupLength;
//
//        fish_angle = k;
//
//        if ( fish_angle < 0)
//            fish_angle += lookupLength;
//
//        if (fish_angle >= lookupLength)
//             fish_angle -= lookupLength;
//
//
//      //calculate ray position and direction
//      //double cameraX = 2*x/double(w)-1; //x-coordinate in camera space
//      int rayDirX = cosine[angle]>>4;
//      int rayDirY = sine[angle]>>4;
//
//      int rayPosX = posX;
//      int rayPosY = posY;
//      int count_step = cosine[fish_angle]>>4;
//      int count = 0;
//
//      int mapX;
//      int mapY;
//
//      //what direction to step in x or y-direction (either +1 or -1)
//      int stepX;
//      int stepY;
//
//      int hit = 0; //was there a wall hit?
//      unsigned int side = 0; //was a NS or a EW wall hit?
//
//      //calculate step and initial sideDist
//      if (rayDirX < 0)
//         stepX = -1;
//      else
//         stepX = 1;
//
//      if (rayDirY < 0)
//         stepY = -1;
//      else
//         stepY = 1;
//
//
//      while ( worldMap[rayPosX>>posShift][rayPosY>>posShift] == 0)
//      {
//        count += count_step;
//
//        //jump to next map square, OR in x-direction, OR in y-direction
//        rayPosX += rayDirX;
//        rayPosY += rayDirY;
//
//        //Check if ray has hit a wall
//      }
//
//      hit = 1;
//      ////////////////////////////////////////////////////////////////////////
//      /////LOOOP BACK CODE FOR SMOOTHER EDGES AND FASTER SPEEDS///////////////
//
//      count_step = count_step>>4;
//      rayDirX = rayDirX>>4;
//      rayDirY = rayDirY>>4;
//
//      while(hit == 1)
//      {
//
//        count -= count_step;
//
//        //jump to next map square, OR in x-direction, OR in y-direction
//        rayPosX -= rayDirX;
//        rayPosY -= rayDirY;
//
//        //Check if ray has hit a wall
//        if (worldMap[rayPosX>>posShift][rayPosY>>posShift] == 0) hit = 0;
//
//      }
//
//      count += count_step;
//      rayPosX += rayDirX;
//      rayPosY += rayDirY;
//
//      ////////////////////////////////////////////////////////////////////////
//      ////////////////////////////////////////////////////////////////////////
//
//      mapX = ((rayPosX>>posShift)  + ((1 - stepX)>>1))<<posShift;
//      mapY = ((rayPosY>>posShift)  + ((1 - stepY)>>1))<<posShift;
//
//      //Calculate distance of perpendicular ray (oblique distance will give fisheye effect!)
//      if ( absVal(mapX - rayPosX) <  absVal(mapY - rayPosY) )
//          side  = 1;
//
//
//      //Calculate height of line to draw on screen
//      //int lineHeight = abs( (screenHeight<<posShift) /count);
//      int lineHeight = (screenHeight<<posShift) /count;
//      //printf("lineHeight= %d", lineHeight);
////      if (lineHeight >= screenHeight){
////    	  lineHeight = 0x1FF;
////    	  //printf(" lineHeight= %d", lineHeight);
////      }
//      //printf("\n");
//
//      //calculate lowest and highest pixel to fill in current stripe
//      int drawStart = (-lineHeight >> 1) + (screenHeight >> 1);
//      if(drawStart < 0) drawStart = 0;
//      int drawEnd = (lineHeight >> 1) + (screenHeight >> 1);
//      if(drawEnd >= screenHeight) drawEnd = screenHeight - 1;
//
//      /////////////////////////////////////////////////
//      ////texturing calculations
//      /////////////////////////////////////////////////
//	   unsigned int texNum = worldMap[rayPosX>>posShift][rayPosY>>posShift] - 1; //1 subtracted from it so that texture 0 can      be used!
//
//	   //calculate value of wallX
//	   int wallX; //where exactly the wall was hit
//
//	   if (side == 0) wallX = rayPosX;
//	   else           wallX = rayPosY;
//
//
//	   wallX -= (wallX>>posShift)<<posShift;
//
//	   //x coordinate on the texture
//	   unsigned int texX = (wallX * texWidth)>>posShift;
//	   if(side == 1 && rayDirX > 0) texX = texWidth - texX - 1;
//	   if(side == 0 && rayDirY < 0) texX = texWidth - texX - 1;
//
//	   unsigned int invLineHeight = (texHeight << 16)/lineHeight;
//	   int line_minus_h = lineHeight - screenHeight;
//	   //int line_minus_h = lineHeight - screenHeight;
//
//	   //Check for Overflow
////	   if (h_minus_line > 512)
////		   h_minus_line = 0;
//
//	   DrawTexture(x, texX, drawStart, drawEnd, side, texNum, invLineHeight , line_minus_h);
//
////       unsigned int color;
////      switch(worldMap[rayPosX>>posShift][rayPosY>>posShift])
////      {
////        case 1:  color = RED_8BIT;  break; //red
////        case 2:  color = GREEN_8BIT;  break; //green
////        case 3:  color = BLUE_8BIT;   break; //blue
////        case 4:  color = WHITE_8BIT;  break; //white
////        default: color = YELLOW_8BIT; break; //yellow
////      }
//
//      //draw the pixels of the stripe as a vertical line
//      //DrawColumn(x, color, drawStart, drawEnd, side);
//      //DrawColumn(x, color, lineHeight, side);
//      //verLine(x, drawStart, drawEnd, color);
//
//      x++;
//    }
//
//
//
//    //move forward if no wall in front of you
//    if (code =='u')
//    {
//        move = dircosine[dir]>>4;
//        if(worldMap[(posX + move)>>posShift][posY>>posShift] == 0)
//                posX += move;
//
//        move = dirsine[dir]>>4;
//        if(worldMap[posX>>posShift][(posY+move)>>posShift] == 0)
//                posY += move;
//    }
//    //move backwards if no wall behind you
//    if (code =='r')
//    {
//        move = dircosine[dir]>>4;
//        if(worldMap[(posX - move)>>posShift][posY>>posShift] == 0)
//                posX -= move;
//
//        move = dirsine[dir]>>4;
//        if(worldMap[posX>>posShift][(posY - move)>>posShift] == 0)
//                posY -= move;
//    }
//    //rotate to the right
//    if (code == 't')
//    {
//      //both camera direction and camera plane must be rotated
//       dir+=13;
//
//       if(dir >= lookupLength)
//           dir -= lookupLength;
//    }
//    //rotate to the left
//    if (code =='k')
//    {
//      //both camera direction and camera plane must be rotated
//        dir -=13;
//
//        if (dir <0)
//            dir += lookupLength;
//    }
//
//
//  }
//
//
//
//    return 0;
//}
//
//int absVal(int v)
//{
//  return v * ((v>0) - (v<0));
//}
//
//int intToDouble(int a)
//{
//
//    return a>>posShift;
//
//}
//
//
//int doubleToInt(double a)
//{
//    return (int)(a*(1<<posShift));
//}
//
////void DrawColumn(unsigned int columnIndex, unsigned int color, unsigned int lineHeight, unsigned int side)
////void DrawColumn(unsigned int columnIndex, unsigned int color, unsigned int startRow, unsigned int endRow, unsigned int side)
////{
////	IOWR_RAM_DATA(MEMORY64_16_0_BASE, 0, (columnIndex & 0x3FF));
////	IOWR_RAM_DATA(MEMORY64_16_0_BASE, 1, (color + (endRow<< 8)));
////	//IOWR_RAM_DATA(MEMORY64_16_0_BASE, 2, (side << 10) + (endRow >> (9 - 1)) + (startRow << 1));
////	IOWR_RAM_DATA(MEMORY64_16_0_BASE, 2, (endRow >> (9 - 1)) + (startRow << 1));
////	IOWR_RAM_DATA(MEMORY64_16_0_BASE, 3, (side << 8));
////	//startarray[columnIndex] = (color + (endRow<< 8));
////	//stoparray[columnIndex] = (side << 10) + (endRow >> (9 - 1)) + (startRow << 1);
////}
//
////void DrawColumn32(unsigned int columnIndex, unsigned int color, unsigned int startRow, unsigned int endRow, unsigned int side)
////{
////	IOWR_RAM32_DATA(MEMORY_TEX_0_BASE, 0, (columnIndex & 0x3FF));
////	IOWR_RAM32_DATA(MEMORY_TEX_0_BASE, 1, (side << 26) + (endRow << 17) + (endRow<< 8) + color);
////	//IOWR_RAM_DATA(MEMORY_0_BASE, 1, (color + (lineHeight<< 8)));
////	//IOWR_RAM_DATA(MEMORY_0_BASE, 2, ((side << 10)  + (lineHeight << 1)));
////	//startarray[columnIndex] = (color + (endRow<< 8));
////	//stoparray[columnIndex] = (side << 10) + (endRow >> (9 - 1)) + (startRow << 1);
////}
//
//
////void DrawTexture(unsigned int columnIndex, unsigned int texX, unsigned int rowStart, unsigned int rowEnd, unsigned int side, unsigned int texNum, unsigned int invLineHeight , unsigned int line_minus_h)
////{
////	IOWR_RAM_DATA(MEMORY256_16_0_BASE, 0, (columnIndex & 0x3FF));
////	IOWR_RAM_DATA(MEMORY256_16_0_BASE, 1, ((texNum & 3) + (texX <<2) + (rowEnd<< 8)));
////	IOWR_RAM_DATA(MEMORY256_16_0_BASE, 2, ((invLineHeight & 0x3F) << 10) + (rowEnd >> 8) + ((rowStart & 0x1FF) << 1));
////	IOWR_RAM_DATA(MEMORY256_16_0_BASE, 3, ((invLineHeight & 0x3FFFF) >> 6) + ((line_minus_h & 0xF) << 12 ) );
////	IOWR_RAM_DATA(MEMORY256_16_0_BASE, 4, ( (line_minus_h & 0x3FFFF) >> 4) + (side << 15));
////
////	//startarray[columnIndex] = (color + (endRow<< 8));
////	//stoparray[columnIndex] = (side << 10) + (endRow >> (9 - 1)) + (startRow << 1);
////}
//
//void DrawTexture(unsigned int columnIndex, unsigned int texX, unsigned int rowStart, unsigned int rowEnd, unsigned int side, unsigned int texNum, unsigned int invLineHeight , unsigned int line_minus_h)
//{
//
//	IOWR_RAM_DATA(NIOSINTERFACE_0_BASE, 16, ((columnIndex & 0x3FF) << 6));
//	IOWR_RAM_DATA(NIOSINTERFACE_0_BASE, 1, ((texNum & 3) + (texX <<2) + (rowEnd<< 8)));
//	IOWR_RAM_DATA(NIOSINTERFACE_0_BASE, 2, ((invLineHeight & 0x3F) << 10) + (rowEnd >> 8) + ((rowStart & 0x1FF) << 1));
//	IOWR_RAM_DATA(NIOSINTERFACE_0_BASE, 3, ((invLineHeight & 0x3FFFF) >> 6) + ((line_minus_h & 0xF) << 12 ) );
//	IOWR_RAM_DATA(NIOSINTERFACE_0_BASE, 4, ( (line_minus_h & 0x3FFFF) >> 4) + (side << 15));
//	IOWR_RAM_DATA(NIOSINTERFACE_0_BASE, 0, 1);
//	IOWR_RAM_DATA(NIOSINTERFACE_0_BASE, 0, 0);
//
//	//startarray[columnIndex] = (color + (endRow<< 8));
//	//stoparray[columnIndex] = (side << 10) + (endRow >> (9 - 1)) + (startRow << 1);
//}
//
////void DrawTexture2(unsigned int columnIndex, unsigned int texX, unsigned int rowStart, unsigned int rowEnd, unsigned int side, unsigned int texNum, unsigned int invLineHeight , unsigned int h_minus_line)
////{
////	IOWR_RAM_DATA(MEMORY256_16_0_BASE, 0, (columnIndex & 0x3FF));
////	IOWR_RAM_DATA(MEMORY256_16_0_BASE, 1, ((texNum & 0xF) + ((texX & 0x3F) <<8)));
////
////	IOWR_RAM_DATA(MEMORY256_16_0_BASE, 3, (invLineHeight & 0x3FFFF));
////	IOWR_RAM_DATA(MEMORY256_16_0_BASE, 4, (invLineHeight & 0x3FFFF) >> 16);
////
////
////	IOWR_RAM_DATA(MEMORY256_16_0_BASE, 9, (h_minus_line & 0x3FFFF) << 12);
////	IOWR_RAM_DATA(MEMORY256_16_0_BASE, 10, (h_minus_line & 0x3FFFF) >> 4);
////	IOWR_RAM_DATA(MEMORY256_16_0_BASE, 11, (h_minus_line & 0x3FFFF) >> 16);
////
////	IOWR_RAM_DATA(MEMORY256_16_0_BASE, 13, (rowStart & 0x1FF) << 4);
////	IOWR_RAM_DATA(MEMORY256_16_0_BASE, 14, (rowEnd & 0x1FF) << 6);
////
////	IOWR_RAM_DATA(MEMORY256_16_0_BASE, 15, (side & 0x1) );
////
////	//startarray[columnIndex] = (color + (endRow<< 8));
////	//stoparray[columnIndex] = (side << 10) + (endRow >> (9 - 1)) + (startRow << 1);
////}

#include <math.h>
#include <io.h>
#include <system.h>
#include <stdio.h>

#define lookupLength 3480
#define screenWidth 640
#define screenHeight 480
#define texWidth 64
#define texHeight 64
#define mapWidth 24
#define mapHeight 24
#define extensionFactor 4
#define loopbackFactor 4

#define RED_8BIT 0xE0 //red
#define GREEN_8BIT 0x1C //green
#define BLUE_8BIT 0x03 //blue
#define YELLOW_8BIT 0xFC //yellow
#define WHITE_8BIT 0xFF //white
#define VIOLET_8BIT 0xE2 //violet

#define CTRL_WRITE_HIGH 0
#define CTRL_WRITE_LOW 0

#define posShift 22

#define RAD 0.0018055130193045
#define HALF_RAD 0.00090275650965225


#define IOWR_RAM_DATA(base, offset, data) \
IOWR_32DIRECT(base, (offset*4), data)

#define IORD_RAM_DATA(base, offset) \
IORD_32DIRECT(base, (offset*4) )




char worldMap[mapWidth][mapHeight]=
{
  {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,2,2,2,2,2,0,0,0,0,3,0,0,0,0,3,0,0,1},
  {1,0,0,0,0,0,2,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,2,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,2,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,2,2,0,2,2,0,0,0,0,3,0,0,0,0,3,0,0,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,4,4,4,4,4,4,4,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,4,0,4,0,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,4,0,0,0,0,5,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,4,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,4,0,4,4,4,4,4,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,4,4,4,4,4,4,4,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}
};


//fixed point conversion functions
int doubleToInt(double);
//int ToDouble(int);

void DrawTexture(unsigned int columnIndex, unsigned int texX, unsigned int rowStart, unsigned int rowEnd, unsigned int side, unsigned int texNum, unsigned int invLineHeight , unsigned int line_minus_h);
void DrawAccelerate(int posX, int posY, int countstep, int rayDirX, int rayDirY, unsigned int columnIndex);
int absVal(int v);

unsigned int startarray[640];
unsigned int stoparray[640];

///UNECESSARY CAN BE IMPLEMENTED WITHOUT THESE TWO LOOKUP
int dirsine[lookupLength];
int dircosine[lookupLength];

/// MEMORY HERE CAN BE CUT DOWN IF NECESSARY
int sine[lookupLength];
int cosine[lookupLength];
//int inv_sine[lookupLength];
//int inv_cosine[lookupLength];

int main()
{

	IOWR_RAM_DATA(NIOSINTERFACE_1_0_BASE, 0, 0);
	int dir = 0;
	int posX = doubleToInt(22.0), posY = doubleToInt(11.5);  //x and y start position
 // int posX = 22, posY = 11;  //x and y start position
  int x =0;

  double sine_temp;
  double cosine_temp;

    for(x = 0; x < lookupLength ; x++)
    {
            //calculate ray position and direction

        sine_temp = sin(x*RAD + HALF_RAD);
        cosine_temp = cos(x*RAD + HALF_RAD);

        dirsine[x] = doubleToInt(sin(x*RAD));
        dircosine[x] = doubleToInt(cos(x*RAD));
        sine[x] = doubleToInt(sine_temp);
        cosine[x] = doubleToInt(cosine_temp);
    }


  int angle;
  int fish_angle;
  int move;

  int k;
  int k2;
  //char key[] = { 'd','d','d','d','d','d','d','d', 'd','d','d','d','d','d','d','d', 'd','d','d','d','d','d','d','d', 'd','d','d','d','d','d','d','d', 'd','d','d','d','d','d','d','d', 'd','d','d','d','d','d','d','d', 'd','d','d','d','d','d','d','d', 'd','d','d','d','d','d','d','d','d','d','d','d','d','d','d','d',
//		  'd','d','d','d','d','d','d','d', 'd','d','d','d','d','d','d','d', 'd','d','d','d','d','d','d','d', 'd','d','d','d','d','d','d','d', 'd','d','d','d','d','d','d','d', 'd','d','d','d','d','d','d','d', 'd','d','d','d','d','d','d','d', 'd','d','d','d','d','d','d','d','d','d','d','d','d','d','d','d'};

  unsigned char code = 0;
  //char key[] = {'d'};
  k2 = 0;
  //start the main loop
  //for (k2 = 0; k2 < sizeof(key); k2++)

  int hardwareData = 0;

  while(1)
  {


//		while (!IORD_8DIRECT(DE2_PS2_0_BASE, 0)) ; /* Poll the status */
//		code = IORD_8DIRECT(DE2_PS2_0_BASE, 1);
		//printf("%c, %x, %d\n", code, code, code);

		/* Get received byte */

	  code = 'k';

	  hardwareData = IORD_RAM_DATA(NIOSINTERFACE_1_0_BASE, 1);
	  printf("%d\n", hardwareData >> 4);


//	 hardwareData = IORD_16DIRECT(NIOSINTERFACE_0_BASE, 1);
//	 printf("%d\n", hardwareData);

     x = 1;
    for(k = -screenWidth/2; k < (screenWidth/2 - 1); k++)
    {
        angle = dir + k;

        if ( angle < 0)
                angle += lookupLength;

        if (angle >= lookupLength)
                angle -= lookupLength;

        fish_angle = k;

        if ( fish_angle < 0)
            fish_angle += lookupLength;

        if (fish_angle >= lookupLength)
             fish_angle -= lookupLength;


      //calculate ray position and direction
      //double cameraX = 2*x/double(w)-1; //x-coordinate in camera space
      int rayDirX = cosine[angle]>>4;
      int rayDirY = sine[angle]>>4;
      int count_step = cosine[fish_angle]>>4;

 //     hardwareData = IORD_32DIRECT(NIOSINTERFACE_1_0_BASE, 1);
 //     printf("%d\n", hardwareData);

     hardwareData = IORD_32DIRECT(NIOSINTERFACE_1_0_BASE, 1);
	 while (!(hardwareData & 1)){
		 hardwareData = IORD_32DIRECT(NIOSINTERFACE_1_0_BASE, 1);
	  }

      DrawAccelerate(posX, posY, count_step, rayDirX, rayDirY, x);
      IOWR_RAM_DATA(NIOSINTERFACE_1_0_BASE, 0, 0);





//	  printf("out of loop\n");
	  //IOWR_RAM_DATA(NIOSINTERFACE_0_BASE, 0, 0);

//	  int rayPosX = posX;
//	  int rayPosY = posY;
//	  int count = 0;
//      int mapX;
//      int mapY;
//
//      //what direction to step in x or y-direction (either +1 or -1)
//      int stepX;
//      int stepY;
//
//      int hit = 0; //was there a wall hit?
//      unsigned int side = 0; //was a NS or a EW wall hit?
//
//      //calculate step and initial sideDist
//      if (rayDirX < 0)
//         stepX = -1;
//      else
//         stepX = 1;
//
//      if (rayDirY < 0)
//         stepY = -1;
//      else
//         stepY = 1;
//
//
//      while ( worldMap[rayPosX>>posShift][rayPosY>>posShift] == 0)
//      {
//        count += count_step;
//
//        //jump to next map square, OR in x-direction, OR in y-direction
//        rayPosX += rayDirX;
//        rayPosY += rayDirY;
//
//        //Check if ray has hit a wall
//      }
//
//      hit = 1;
//      ////////////////////////////////////////////////////////////////////////
//      /////LOOOP BACK CODE FOR SMOOTHER EDGES AND FASTER SPEEDS///////////////
//
//      count_step = count_step>>4;
//      rayDirX = rayDirX>>4;
//      rayDirY = rayDirY>>4;
//
//      while(hit == 1)
//      {
//
//        count -= count_step;
//
//        //jump to next map square, OR in x-direction, OR in y-direction
//        rayPosX -= rayDirX;
//        rayPosY -= rayDirY;
//
//        //Check if ray has hit a wall
//        if (worldMap[rayPosX>>posShift][rayPosY>>posShift] == 0) hit = 0;
//
//      }
//
//      count += count_step;
//      rayPosX += rayDirX;
//      rayPosY += rayDirY;
//
//      ////////////////////////////////////////////////////////////////////////
//      ////////////////////////////////////////////////////////////////////////
//
//      mapX = ((rayPosX>>posShift)  + ((1 - stepX)>>1))<<posShift;
//      mapY = ((rayPosY>>posShift)  + ((1 - stepY)>>1))<<posShift;
//
//      //Calculate distance of perpendicular ray (oblique distance will give fisheye effect!)
//      if ( absVal(mapX - rayPosX) <  absVal(mapY - rayPosY) )
//          side  = 1;
//
//
//      //Calculate height of line to draw on screen
//      //int lineHeight = abs( (screenHeight<<posShift) /count);
//      int lineHeight = (screenHeight<<posShift) /count;
//      //printf("lineHeight= %d", lineHeight);
////      if (lineHeight >= screenHeight){
////    	  lineHeight = 0x1FF;
////    	  //printf(" lineHeight= %d", lineHeight);
////      }
//      //printf("\n");
//
//      //calculate lowest and highest pixel to fill in current stripe
//      int drawStart = (-lineHeight >> 1) + (screenHeight >> 1);
//      if(drawStart < 0) drawStart = 0;
//      int drawEnd = (lineHeight >> 1) + (screenHeight >> 1);
//      if(drawEnd >= screenHeight) drawEnd = screenHeight - 1;
//
//      /////////////////////////////////////////////////
//      ////texturing calculations
//      /////////////////////////////////////////////////
//	   unsigned int texNum = worldMap[rayPosX>>posShift][rayPosY>>posShift] - 1; //1 subtracted from it so that texture 0 can      be used!
//
//	   //calculate value of wallX
//	   int wallX; //where exactly the wall was hit
//
//	   if (side == 0) wallX = rayPosX;
//	   else           wallX = rayPosY;
//
//
//	   wallX -= (wallX>>posShift)<<posShift;
//
//	   //x coordinate on the texture
//	   unsigned int texX = (wallX * texWidth)>>posShift;
//	   if(side == 1 && rayDirX > 0) texX = texWidth - texX - 1;
//	   if(side == 0 && rayDirY < 0) texX = texWidth - texX - 1;
//
//	   unsigned int invLineHeight = (texHeight << 16)/lineHeight;
//	   int line_minus_h = lineHeight - screenHeight;
//
//
//
//	   DrawTexture(x, texX, drawStart, drawEnd, side, texNum, invLineHeight , line_minus_h);

//       unsigned int color;
//      switch(worldMap[rayPosX>>posShift][rayPosY>>posShift])
//      {
//        case 1:  color = RED_8BIT;  break; //red
//        case 2:  color = GREEN_8BIT;  break; //green
//        case 3:  color = BLUE_8BIT;   break; //blue
//        case 4:  color = WHITE_8BIT;  break; //white
//        default: color = YELLOW_8BIT; break; //yellow
//      }

      //draw the pixels of the stripe as a vertical line
      //DrawColumn(x, color, drawStart, drawEnd, side);
      //DrawColumn(x, color, lineHeight, side);
      //verLine(x, drawStart, drawEnd, color);

      x++;
    }



    //move forward if no wall in front of you
    if (code =='u')
    {
        move = dircosine[dir]>>4;
        if(worldMap[(posX + move)>>posShift][posY>>posShift] == 0)
                posX += move;

        move = dirsine[dir]>>4;
        if(worldMap[posX>>posShift][(posY+move)>>posShift] == 0)
                posY += move;
    }
    //move backwards if no wall behind you
    if (code =='r')
    {
        move = dircosine[dir]>>4;
        if(worldMap[(posX - move)>>posShift][posY>>posShift] == 0)
                posX -= move;

        move = dirsine[dir]>>4;
        if(worldMap[posX>>posShift][(posY - move)>>posShift] == 0)
                posY -= move;
    }
    //rotate to the right
    if (code == 't')
    {
      //both camera direction and camera plane must be rotated
       dir += 1;

       if(dir >= lookupLength)
           dir -= lookupLength;
    }
    //rotate to the left
    if (code =='k')
    {
      //both camera direction and camera plane must be rotated
        dir -= 1;

        if (dir <0)
            dir += lookupLength;
    }


  }



    return 0;
}

int absVal(int v)
{
  return v * ((v>0) - (v<0));
}

int intToDouble(int a)
{

    return a>>posShift;

}


int doubleToInt(double a)
{
    return (int)(a*(1<<posShift));
}


void DrawTexture(unsigned int columnIndex, unsigned int texX, unsigned int rowStart, unsigned int rowEnd, unsigned int side, unsigned int texNum, unsigned int invLineHeight , unsigned int line_minus_h)
{

	IOWR_RAM_DATA(NIOSINTERFACE_1_0_BASE, 8, (columnIndex  << 22));
	IOWR_RAM_DATA(NIOSINTERFACE_1_0_BASE, 1, ((texNum & 3) + (texX <<2) + (rowEnd<< 8) + (rowStart<<17)+ ((invLineHeight & 0x3F)<<26)));
	IOWR_RAM_DATA(NIOSINTERFACE_1_0_BASE, 2, ((invLineHeight & 0x3FFFF) >> 6) + ((line_minus_h & 0x3FFFF) << 12 ) + (side << 31));
	IOWR_RAM_DATA(NIOSINTERFACE_1_0_BASE, 0, 1);
	IOWR_RAM_DATA(NIOSINTERFACE_1_0_BASE, 0, 0);

	//startarray[columnIndex] = (color + (endRow<< 8));
	//stoparray[columnIndex] = (side << 10) + (endRow >> (9 - 1)) + (startRow << 1);
}

void DrawAccelerate(int posX, int posY, int countstep, int rayDirX, int rayDirY, unsigned int columnIndex)
{

	IOWR_RAM_DATA(NIOSINTERFACE_1_0_BASE, 8, (columnIndex << 22));
	IOWR_RAM_DATA(NIOSINTERFACE_1_0_BASE, 1, posX);
	IOWR_RAM_DATA(NIOSINTERFACE_1_0_BASE, 2, posY );
	IOWR_RAM_DATA(NIOSINTERFACE_1_0_BASE, 3, countstep );
	IOWR_RAM_DATA(NIOSINTERFACE_1_0_BASE, 4, rayDirX);
	IOWR_RAM_DATA(NIOSINTERFACE_1_0_BASE, 5, rayDirY );
	IOWR_RAM_DATA(NIOSINTERFACE_1_0_BASE, 0, 0);
	IOWR_RAM_DATA(NIOSINTERFACE_1_0_BASE, 0, 0xFFFFFFFF);


	//startarray[columnIndex] = (color + (endRow<< 8));
	//stoparray[columnIndex] = (side << 10) + (endRow >> (9 - 1)) + (startRow << 1);
}



