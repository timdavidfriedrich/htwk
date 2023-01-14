int main(int argc, char const *argv[])
{
    printf(computeBonus(2000, 200, 1));
    return 0;
}


int computeBonus (int saldo, int rate, int bonus) {
    int newBonus = bonus;
    if ( (saldo > 1000) && (rate > 100) ) {
        newBonus = newBonus * 5;
    }
    if ( (saldo > 5000) || (newBonus > 50) ) {
        newBonus = newBonus * 2;
    }
    return newBonus;
}