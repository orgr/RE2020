#include <stdio.h>
#include <string.h>

#define ROAD 	    "road"
#define SETTLEMENT  "settlement"
#define CITY 	    "city"
#define DEVELOPMENT "development"

enum CardType {
	WOOD,
	BRICK,
	WOOL,
	GRAIN,
	ORE,
	CardType_Count
};

void chomp(char *s) {
    while(*s && *s != '\n' && *s != '\r') s++;
 
    *s = 0;
}

int main(int argc, char ** argv) {
	char buffer[255];
	
	int cardAmounts[CardType_Count];
	for (int i=0; i < CardType_Count; i++) {
		cardAmounts[i] = 0;
	}

	while (scanf("%s", buffer) != EOF) {
		chomp(buffer);

		if (strcmp(ROAD, buffer) == 0){
			cardAmounts[WOOD]++;
			cardAmounts[BRICK]++;

		} else if (strcmp(SETTLEMENT, buffer) == 0) {
			cardAmounts[WOOD]++;
			cardAmounts[BRICK]++;
			cardAmounts[WOOL]++;
			cardAmounts[GRAIN]++;

		} else if (strcmp(CITY, buffer) == 0) {
			cardAmounts[GRAIN] += 2;
			cardAmounts[ORE] += 3;

		} else if (strcmp(DEVELOPMENT, buffer) == 0) {
			cardAmounts[WOOL]++;
			cardAmounts[GRAIN]++;
			cardAmounts[ORE]++;
		}
	}

	for (int i=0; i < CardType_Count; i++) {
		char* zeroPad = "";
		if (cardAmounts[i] < 10) {
			zeroPad = "0";
		}
			
		printf("%s%d ", zeroPad, cardAmounts[i]);
	}

}