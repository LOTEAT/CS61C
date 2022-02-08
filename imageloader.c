/************************************************************************
**
** NAME:        imageloader.c
**
** DESCRIPTION: CS61C Fall 2020 Project 1
**
** AUTHOR:      Dan Garcia  -  University of California at Berkeley
**              Copyright (C) Dan Garcia, 2020. All rights reserved.
**              Justin Yokota - Starter Code
**				YOUR NAME HERE
**
**
** DATE:        2020-08-15
**
**************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <inttypes.h>
#include <string.h>
#include "imageloader.h"

//Opens a .ppm P3 image file, and constructs an Image object. 
//You may find the function fscanf useful.
//Make sure that you close the file with fclose before returning.
Image *readData(char *filename) 
{
	// MY SOLUTION HERE
	FILE* file = fopen(filename, "r");
	if(file == NULL){
		printf("Error opening %s!", filename);
		return NULL;
	}
	char buf[10];
	int scale;
	// read P3
	fscanf(file, "%s", buf);
	// read rows, columns and scale
	Image* image = malloc(sizeof(Image));
	fscanf(file, "%u", &image->cols);
	fscanf(file, "%u", &image->rows);
	fscanf(file, "%d", &scale);
	
	// malloc 2d array of colors
	image->image = (Color**) malloc(sizeof(Color*) * image->rows);  
    for(int i = 0; i < image->rows; i++) { 
    	image->image[i] = (Color*) malloc(sizeof(Color) * image->cols);
		for(int j = 0; j < image->cols; j++){
			Color* pixel = &image->image[i][j];
			fscanf(file, "%hhu %hhu %hhu", &pixel->R, &pixel->G, &pixel->B);
		}
	}
	fclose(file);
	return image;
}

//Given an image, prints to stdout (e.g. with printf) a .ppm P3 file with the image's data.
void writeData(Image *image)
{
	// MY SOLUTION HERE
	printf("P3\n%d %d\n255\n", image->cols, image->rows);
	Color **pixels = image->image;
	for(int i = 0; i < image->rows; i++){
		int j = 0;
		for(; j < image->cols - 1; j++){
			printf("%3hhu %3hhu %3hhu   ", pixels[i][j].R, pixels[i][j].G, pixels[i][j].B);
		}
		printf("%3hhu %3hhu %3hhu\n", pixels[i][j].R, pixels[i][j].G, pixels[i][j].B);
	}

}

//Frees an image
void freeImage(Image *image)
{
	// MY SOLUTION HERE
	for(int i = 0; i < image->rows; i++){
		free(image->image[i]);
	}
	free(image->image);
	free(image);
}