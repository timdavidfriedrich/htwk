import qualified Prelude
import Test.LeanCheck
import GHC.Generics
import Test.LeanCheck.Generic


-- Spezifikation für min und max:
-- min (x + y) y == y && min x (x + y) == x
-- max x (x + y) == x + y && max (x + y) y == x + y


-- Datentyp für Peano-Zahlen
data N = Z | S N deriving (Prelude.Eq, Generic, Prelude.Show)

-- Listable für N, damit LeanCheck mit N funktioniert 
instance Listable N where tiers :: [[N]]
                          tiers = genericTiers;

-- Implementierung Addition
plus :: N -> N -> N
plus Z y = y ; plus (S x) y = S (plus x y)

-- Implementierung Subtraktion
minus :: N -> N -> N
minus x Z = x ; minus (S x) (S y) = minus x y; minus Z x = Z

-- Implementierung Maximum
max :: N -> N -> N
max x y = plus (minus x y) y

-- LeanCheck-Test für Maximum
max_check :: N -> N -> Prelude.Bool
max_check = \ x y -> max (plus x y) y Prelude.== plus x y Prelude.&& max x (plus x y) Prelude.== plus x y;

-- Implementierung Minimum
min :: N -> N -> N
min x y = minus (max x y) (max (minus x y) (minus y x))

-- LeanCheck-Test für Minimum
min_check :: N -> N -> Prelude.Bool
min_check = \ x y -> min (plus x y) y Prelude.== y Prelude.&& min x (plus x y) Prelude.== x;

-- Implementierung Median für 3 Argumente
median :: N -> N -> N -> N
median x y z = minus (minus (plus x (plus y z)) (max (max x y) z)) (min (min x y) z)

-- LeanCheck-Test für Median
median_check :: N -> N -> N -> Prelude.Bool
median_check = \ x y z -> median x y z Prelude.== median y x z Prelude.&& median x y z Prelude.== median x z y Prelude.&& median x y z Prelude.== median y z x Prelude.&& median x y z Prelude.== median z x y Prelude.&& median x y z Prelude.== median z y x Prelude.&& median x y z Prelude.== median (median x y z) (median x y z) (median x y z);

-- Manuelle Tests für Median
median_manuell_check = do
    Prelude.map (\ (x, y, z, s) -> median x y z Prelude.== s) median_test_faelle;


-- Test-Fälle für median_manuell_check
median_test_faelle :: [(N, N, N, N)]
median_test_faelle = 
            [ (S Z, S (S Z), S (S (S Z)), S (S Z))
            , (S (S (S Z)), S (S Z), S Z, S (S Z))
            , (S (S Z), S (S (S Z)), S Z, S (S Z))
            , (S (S (S Z)), S Z, S (S Z), S (S Z))
            , (S (S Z), S Z, S (S (S Z)), S (S Z))
            , (S Z, S (S (S Z)), S (S Z), S (S Z))
            , (S (S Z), S (S Z), S (S Z), S (S Z))
            , (S Z, S Z, S (S Z), S Z)
            , (S (S Z), S Z, S Z, S Z)
            , (S Z, S(S Z), S Z, S Z)
            , (Z, Z, Z, Z)
            ];
