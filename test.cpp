#include <iostream>
using namespace std;

int main() {
    int sign;
    int count = 0;
    int sum = 0; 
    int n = 1234;
    int n1 = n;

    while(n1!=0) {
        count++;
        n1 = n1/10;
    }

    if(count%2 == 0) {
        sign = -1;
    }
    else {
        sign = 1;
    }

    while(n!=0) {
        sum = sum + (n%10)*sign;
        sign = sign * (-1);
        n = n / 10;
    }
    cout << sum;
}