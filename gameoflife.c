/************************************************************************
**
** NAME:        gameoflife.c
**
** DESCRIPTION: CS61C Fall 2020 Project 1
**
** AUTHOR:      Justin Yokota - Starter Code
**				YOUR NAME HERE
**
**
** DATE:        2020-08-23
**
**************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <inttypes.h>
#include "imageloader.h"

//Determines what color the cell at the given row/col should be. This function allocates space for a new Color.
//Note that you will need to read the eight neighbors of the cell in question. The grid "wraps", so we treat the top row as adjacent to the bottom row
//and the left column as adjacent to the right column.
Color *evaluateOneCell(Image *image, int row, int col, uint32_t rule)
{
	// MY SOLUTION HERE
	Color* nextCell = malloc(sizeof(Color));
	int rows = image->rows, cols = image->cols;
	int countR = 0, countG = 0, countB = 0;
	int isAliveR, isAliveG, isAliveB;
	Color** pixels = image->image;
	isAliveR = pixels[row][col].R == 255;
	isAliveG = pixels[row][col].G == 255;
	isAliveB = pixels[row][col].B == 255;
	// range
	for(int i = -1; i <= 1; i++){
		int cur_row = (row + i + rows) % rows;
		for(int j = -1; j <= 1; j++){
			int cur_col = (col + j + cols) % cols;
			if(cur_row == row && cur_col == col)
				continue;
			if(pixels[cur_row][cur_col].R == 255)
				countR++;
			if(pixels[cur_row][cur_col].G == 255)
				countG++;
			if(pixels[cur_row][cur_col].B == 255)
				countB++;
		}
	}
	
	if((1 << (isAliveR * 9 + countR)) & rule)
		nextCell->R = 255;
	else
		nextCell->R = 0;
	if((1 << (isAliveG * 9 + countG)) & rule)
		nextCell->G = 255;
	else
		nextCell->G = 0;
	if((1 << (isAliveB * 9 + countB)) & rule)
		nextCell->B = 255;
	else
		nextCell->B = 0;
	
	return nextCell;
}

//The main body of Life; given an image and a rule, computes one iteration of the Game of Life.
//You should be able to copy most of this from steganography.c
Image *life(Image *image, uint32_t rule)
{
	// MY SOLUTION HERE
	Image *nextImage = malloc(sizeof(Image));
	nextImage->image = (Color**) malloc(sizeof(Color*) * image->rows);  
	nextImage->cols = image->cols;
	nextImage->rows = image->rows;
	for(int i = 0; i < image->rows; i++){
		nextImage->image[i] = (Color*) malloc(sizeof(Color) * image->cols);
		for(int j = 0; j < image->cols; j++){
			Color *nextCell = evaluateOneCell(image, i, j, rule);
			nextImage->image[i][j] = *nextCell;
			free(nextCell);
		}
	}

	return nextImage;
}

/*
Loads a .ppm from a file, computes the next iteration of the game of life, then prints to stdout the new image.

argc stores the number of arguments.
argv stores a list of arguments. Here is the expected input:
argv[0] will store the name of the program (this happens automatically).
argv[1] should contain a filename, containing a .ppm.
argv[2] should contain a hexadecimal number (such as 0x1808). Note that this will be a string.
You may find the function strtol useful for this conversion.
If the input is not correct, a malloc fails, or any other error occurs, you should exit with code -1.
Otherwise, you should return from main with code 0.
Make sure to free all memory before returning!

You may find it useful to copy the code from steganography.c, to start.
*/
int main(int argc, char **argv)
{
	// MY SOLUTION HERE
	if (argc != 3) {
		printf("usage: ./gameOfLife filename rule");
		printf("filename is an ASCII PPM file (type P3) with maximum value 255.\n");
		printf("rule is a hex number beginning with 0x; Life is 0x1808.\n");
		exit(-1);
	}
	uint32_t rule = strtol(argv[2], NULL, 16);
	Image* image = readData(argv[1]);
	Image* life_image = life(image, rule);
	writeData(life_image);
	freeImage(image);
	freeImage(life_image);
	return 0;
}
