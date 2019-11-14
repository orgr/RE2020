#include <stdio.h>
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

int strcmpr(char *s1, char *s2)
{
    if ((s1 == NULL) || (s2 == NULL))
        return 1;
    while ((*s1 != '\0') && (*s2 != '\0') && (*s1 == *s2))
    {
        s1++;
        s2++;
    }
    return !(*s1 == *s2);
}

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

		if (strcmpr(ROAD, buffer) == 0){
			cardAmounts[WOOD]++;
			cardAmounts[BRICK]++;

		} else if (strcmpr(SETTLEMENT, buffer) == 0) {
			cardAmounts[WOOD]++;
			cardAmounts[BRICK]++;
			cardAmounts[WOOL]++;
			cardAmounts[GRAIN]++;

		} else if (strcmpr(CITY, buffer) == 0) {
			cardAmounts[GRAIN] += 2;
			cardAmounts[ORE] += 3;

		} else if (strcmpr(DEVELOPMENT, buffer) == 0) {
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