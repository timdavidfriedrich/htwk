#include <iostream>
#include <cmath>

double wurzel (double in);
double cosinus (double in);
double sinus (double in);
unsigned long long int fakultaet(int in);


int main () 
{
    double input;
    std::cin >> input;
    std::cout << sinus(input) << std::endl;
}


double wurzel (double in)
{
    double out = 1.0;
    for (int i = 0; i < 10; i++) out = (out/2)+(in/(2*out));
    return out;
}


double cosinus (double in)
{
    double out = 0.0;
    for (int i = 0; i <= 10; i++) out += std::pow(-1.0, i)*std::pow(in, 2.0*i)/fakultaet(2*i);
    return out;
}


double sinus (double in)
{
    double out = 0.0;
    for (int i = 0; i <= 10; i++) out += std::pow(-1.0, i)*std::pow(in, 2.0*i+1)/fakultaet(2*i+1);
    return out;
}


unsigned long long int fakultaet (int in) 
{
    int long long out = 1;
    for(int i = 1; i <= in; i++) out *= i;
    return out;
}