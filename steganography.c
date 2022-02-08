/************************************************************************
**
** NAME:        steganography.c
**
** DESCRIPTION: CS61C Fall 2020 Project 1
**
** AUTHOR:      Dan Garcia  -  University of California at Berkeley
**              Copyright (C) Dan Garcia, 2020. All rights reserved.
**				Justin Yokota - Starter Code
**				YOUR NAME HERE
**
** DATE:        2020-08-23
**
**************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <inttypes.h>
#include "imageloader.h"

//Determines what color the cell at the given row/col should be. This should not affect Image, and should allocate space for a new Color.
Color *evaluateOnePixel(Image *image, int row, int col)
{
	// MY SOLUTION HERE
	Color pixel = image->image[row][col];
	uint8_t decode = (pixel.B & 1) * 255;
	Color* color = (Color *)malloc(sizeof(Color));
	// copy
	color->R = color->G = color->B = decode;
	return color;
}

//Given an image, creates a new image extracting the LSB of the B channel.
Image *steganography(Image *image)
{
	// MY SOLUTION HERE
	// You had better not use my solution,
	// because this way is more complicated.
	// The best solution is malloc a 1d array!
	Image *lsb_image = malloc(sizeof(Image));
	lsb_image->image = (Color**) malloc(sizeof(Color*) * image->rows);  
	lsb_image->cols = image->cols;
	lsb_image->rows = image->rows;
	for(int i = 0; i < image->rows; i++){
		lsb_image->image[i] = (Color*) malloc(sizeof(Color) * image->cols);
		for(int j = 0; j < image->cols; j++){
			Color *decode_color = evaluateOnePixel(image, i, j);
			lsb_image->image[i][j] = *decode_color;
			free(decode_color);
		}
	}

	return lsb_image;
}

/*
Loads a file of ppm P3 format from a file, and prints to stdout (e.g. with printf) a new image, 
where each pixel is black if the LSB of the B channel is 0, 
and white if the LSB of the B channel is 1.

argc stores the number of arguments.
argv stores a list of arguments. Here is the expected input:
argv[0] will store the name of the program (this happens automatically).
argv[1] should contain a filename, containing a file of ppm P3 format (not necessarily with .ppm file extension).
If the input is not correct, a malloc fails, or any other error occurs, you should exit with code -1.
Otherwise, you should return from main with code 0.
Make sure to free all memory before returning!
*/
int main(int argc, char **argv)
{
	// MY SOLUTION HERE
	if (argc != 2) {
		printf("usage: %s filename\n",argv[0]);
		printf("filename is an ASCII PPM file (type P3) with maximum value 255.\n");
		exit(-1);
	}
	Image* image = readData(argv[1]);
	Image* ste_image = steganography(image);
	writeData(ste_image);
	freeImage(image);
	freeImage(ste_image);
	return 0;
}
