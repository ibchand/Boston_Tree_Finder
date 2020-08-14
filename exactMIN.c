//  exactMIN.c
//
//  Created by Student on 12/11/18.
//  Copyright © 2018 C. All rights reserved.
//
//  exactMIN will read length.dat and get num and length, but only needs num. Then it will read exactDist.dat to get the values of the array dist located in getTree.m which contains all the values returned by getDist.m. It will then find the minimum value in the array and return the index of the minimum.

#include <stdio.h>
#include <stdlib.h>

int exactMIN(void);

int main() {
    int min=exactMIN()+1;
    return min;
}

int exactMIN(void) {
    FILE    *exactDistptr,
            *lengthptr;
    
    int     length,
            num,
            fc,
            i=0,
            min;
    
    float   temp;
    
    lengthptr=fopen("length.dat","r");
    
                //Checks if length.dat opened successfully
                if(lengthptr == 0) {
                    //Displays error message if not opened successfully
                    perror("fopen");
                    //Terminates program
                    exit(1);
                }
    
    //Reads from length.dat and assigns length to length
    fscanf(lengthptr,"%d",&length);
    //Reads from length.dat and assigns num to num
    fscanf(lengthptr,"%d",&num);
    
                //Closes length.dat
                fc=fclose(lengthptr);
                //Checks if length.dat closed successfully
                if (fc != 0) {
                    //Displays error message if not closed successfully
                    perror("fclose");
                    //Terminates program
                    exit(1);
                }
    
    //Opens exactDist.dat to read from it
    exactDistptr=fopen("exactDist.dat","r");
    
    //Check if distances.dat opened successfully
    if(exactDistptr == 0) {
        //Displays error message if not opened successfully
        perror("fopen");
        //Terminates program
        exit(1);
    }
    
    //distances is declared here as length was not initialized until read from length.dat
    float exactDist[num];
    
    //Reads from distances.dat and assigns all values to array distances[]
    while(fscanf(exactDistptr, "%f", &exactDist[i]) != EOF) {
        i++;
    }
                //Closes exactDist.dat
                fc=fclose(exactDistptr);
                //Checks if exactDist.dat closed successfully
                if (fc != 0) {
                    //Displays error message if not closed successfully
                    perror("fclose");
                    //Terminates program
                    exit(1);
                }
    //Finds the smallest value in exactDist
    temp=exactDist[0];
    min=0;
    for(i=1;i<num;i++) {
        if(temp>exactDist[i]) {
            temp=exactDist[i];
            min=i;
        }
    }
    return min;
}
