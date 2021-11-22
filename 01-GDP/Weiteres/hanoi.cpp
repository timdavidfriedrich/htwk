#include <iostream>

enum class Stapel { Eins, Zwei, Drei };


// Deklaration

void ziehe( Stapel von, Stapel nach );
void loeseHanoi( Stapel von, Stapel nach, Stapel hilf, unsigned int anzahlScheiben );

// Implementierung für: std::cout << Stapel::Eins;
std::ostream& operator<<( std::ostream& out, Stapel s );



// Implementierung

std::ostream& operator<<( std::ostream& out, Stapel s )
{
    switch( s )
    {
        case Stapel::Eins:
            out << "Eins";
            break;
        case Stapel::Zwei:
            out << "Zwei";
            break;
        case Stapel::Drei:
            out << "Drei";
            break;
    }
    return out;
}

// Nicht nachmachen: Globaler Zähler
unsigned int zaehler = 0;


/**
 * Gibt einen Zug auf dem Bildschrim aus.
 *
 * @param von Stapel von dem gezogen wird
 * @param nach Stapel auf den gezogen wird
*/
void ziehe( Stapel von, Stapel nach )
{
    ++zaehler;
    std::cout << zaehler << "Ziehe von " << von << " nach " << nach << "\n";
}


/**
 * Löst die Türme von Hanoi
 *
 * @param von Stapel von dem anzahlScheiben gezogen werden
 * @param nach Stapel auf den anzahlScheiben von Stapel von gezogen werden
 * @param hilf Stapel der zuhilfe genommen wird
 * @param anzahlScheiben Die Anzahl an Scheiben, die auf Stapel von liegen und auf Stapel nach gezogen werden.
 */
void loeseHanoi( Stapel von, Stapel nach, Stapel hilf, unsigned int anzahlScheiben )
{
    if( anzahlScheiben == 1 )
    {
        // Rekursionsanfang
        ziehe( von, nach );
    }
    else
    {
       // Rekursionsschritt
    loeseHanoi( von, hilf, nach, anzahlScheiben - 1 );
    ziehe( von, nach );
    loeseHanoi( hilf, nach, von, anzahlScheiben - 1 );
    }
}



int main()
{
    std::cout << "Anzahl Scheiben: ";
    unsigned int N;
    std::cin >> N;
    loeseHanoi(Stapel::Eins, Stapel::Zwei, Stapel::Drei, N);
}
