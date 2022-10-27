#include <iostream>
#include <cmath>

using namespace std;

int main() {
    int n = 55;
    int x, y, z;

    for(x=0;x<n;x++)
        for(y=0;y<n;y++)
            for(z=0;z<n;z++)
                if((x*x+y*y+z*z) == n) {
                    cout << x << ' ' << y << ' ' << z;
                    return 1;
                }
    cout << "false";            
    return 0;
}