//  MIN.c
//
//  Created by Student on 12/11/18.
//  Copyright © 2018 C. All rights reserved.
//
//  MIN will read length.dat and get num and length. Then it will read distances.dat and get all the values of the D array located in getTree.m which contains all values returned by distFormula.m. It will will then find num minimum values in D and write their indexes to indexes.dat.

#include <stdio.h>
#include <stdlib.h>

void MIN(void);

int main() {
    MIN();
    return 0;
}

void MIN() {
    FILE    *lengthptr,
            *distancesptr,
            *indexesptr;
    
    int     length,
            num,
            fc,
            i=0,
            j,
            max;
    
    float   temp;
    
    //Read Length first which has two values, length and num, both ints
    //Opens length.dat to read from it
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
    
    //Opens distances.dat to read from it
    distancesptr=fopen("distances.dat","r");
    
                //Check if distances.dat opened successfully
                if(distancesptr == 0) {
                        //Displays error message if not opened successfully
                        perror("fopen");
                        //Terminates program
                        exit(1);
                }
    
    //distances is declared here as length was not initialized until read from length.dat
    float distances[length];
    
    //Reads from distances.dat and assigns all values to array distances[]
    while(fscanf(distancesptr, "%f", &distances[i]) != EOF) {
        i++;
    }
                //Closes distances.dat
                fc=fclose(distancesptr);
                //Checks if distances.dat closed successfully
                if (fc != 0) {
                        //Displays error message if not closed successfully
                        perror("fclose");
                        //Terminates program
                        exit(1);
                }
    
    //indexes is declared here as num was not initialized until read from length.dat
    int indexes[num];
    
    //Finds max in D
    temp=distances[0];
    max=0;
    for(i=1;i<length;i++) {
        if(temp<distances[i]) {
            temp=distances[i];
            max=i;
        }
    }
    
    //Finds the indexes of the num smallest values in distances
    for(i=0;i<num;i++) {
        //Sets our temp var to the value of D index 0 element
        temp=distances[0];
        //Sets min[i] to index 0 if index 0 happens to be smallest
        indexes[i]=0;
        //Traverses through D
        for(j=1;j<length;j++) {
            //Checks if the next element in D is smaller than the one in temp
            if(temp>distances[j]) {
                //Changes temp if that is the case
                temp=distances[j];
                //Updates the index in min
                indexes[i]=j;
            }
        }
        //Sets the previously found smallest value in D to the largest value in D
        distances[indexes[i]]=distances[max];
    }
    
    //Opens indexes.dat to read from it
    indexesptr=fopen("indexes.dat","w");
    
                //Checks if indexes.dat opened successfully
                if(indexesptr == 0) {
                    //Displays error message if not opened successfully
                    perror("fopen");
                    //Terminates program
                    exit(1);
                }
    
    //Loops num times to traverse indexes
    for(i=0;i<num;i++) {
        //Adds 1 to each element in indexes and inputs it into the file indexes.dat
        fprintf(lengthptr,"%d\n",indexes[i]+1);
    }
                //Closes indexes.dat
                fc=fclose(indexesptr);
                //Checks if indexes.dat closed successfully
                if (fc != 0) {
                    //Displays error message if not closed successfully
                    perror("fclose");
                    //Terminates program
                    exit(1);
                }
}
