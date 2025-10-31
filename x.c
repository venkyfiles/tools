#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int editDist(char* word1, char* word2);
int min(int a, int b);
void swap(int* a, int* b);

int min(int a, int b){
  return a < b ? a : b;
}

void swap(int* a, int* b){
  int temp[100];  // Temp array to hold one of the arrays during the swap
  memcpy(temp, a, sizeof(int) * 100);  // Copy contents of 'a' into temp
  memcpy(a, b, sizeof(int) * 100);     // Copy contents of 'b' into 'a'
  memcpy(b, temp, sizeof(int) * 100);  // Copy contents of temp into 'b'
}

int editDist(char* word1, char* word2){
  int word1_len = strlen(word1);
  int word2_len = strlen(word2);

  // Statically allocated arrays with fixed size of 100
  int oldDist[100];  // Declare static to persist between swaps
  int curDist[100];  // Same here

  int i, j, dist;

  // Initialize distances to the length of the substrings
  for(i = 0; i < word2_len + 1; i++){
    oldDist[i] = i;
    curDist[i] = i;
  }

  for(i = 1; i < word1_len + 1; i++){
    curDist[0] = i;
    for(j = 1; j < word2_len + 1; j++){
      if(word1[i-1] == word2[j-1]){
        curDist[j] = oldDist[j - 1];
      } else {
        curDist[j] = min(min(oldDist[j],        // deletion
                             curDist[j-1]),    // insertion
                             oldDist[j-1]) + 1; // substitution
      }
    }

    // Swap oldDist and curDist using the swap function
    swap(oldDist, curDist);
  }

  dist = oldDist[word2_len]; // Using oldDist after the last iteration
  return dist;
}

int main(int argc, char** argv){
  if(argc < 3){
    printf("Usage: %s word1 word2\n", argv[0]);
    exit(1);
  }
  printf("The distance between %s and %s is %d.\n", argv[1], argv[2], editDist(argv[1], argv[2]));

  return 0;
}
