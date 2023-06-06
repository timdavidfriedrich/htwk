data N = Z | S N deriving Show

plus x y = case x of
  Z -> y
  S x' -> S (plus x' y)

mal x y = case x of
  Z -> Z
  S x' -> plus y (mal x' y)

hoch x y = case y of
  Z -> S Z
  S y' -> mal x (hoch x y')