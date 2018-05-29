#include <stdio.h>

int add(int a, int b) {
	int result;
	result = a + b;
	return result;
}

int main() {
	int a = 4;
	int b = 5;
	int r = add(a, b);
	
	return 0;
}
