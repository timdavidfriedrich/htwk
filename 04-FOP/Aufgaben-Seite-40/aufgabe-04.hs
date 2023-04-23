import qualified Prelude
-- import Test.LeanCheck

data N = Z | S N deriving Prelude.Show

plus :: N -> N -> N
plus Z y = y ; plus (S x) y = S (plus x y)

minus :: N -> N -> N
minus x Z = x ; minus (S x) (S y) = minus x y; minus Z x = Z

max :: N -> N -> N
max x y = plus (minus x y) y

min :: N -> N -> N
min x y = minus (max x y) (max (minus x y) (minus y x))

median :: N -> N -> N -> N
median x y z = minus (minus (plus x (plus y z)) (max (max x y) z)) (min (min x y) z)


-- forall x :: N, y :: N : min (plus x y) y = y
-- forall x :: N, y :: N : min x (plus x y) = x

-- forall x :: N, y :: N : max (plus x y) y = plus x y
-- forall x :: N, y :: N : max x (plus x y) = plus x y 
