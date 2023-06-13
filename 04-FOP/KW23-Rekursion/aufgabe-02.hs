--plus x y = case x of
--  Z -> y
--  S x' -> S (plus x' y)

--mal x y = case x of
--  Z -> Z
--  S x' -> plus y (mal x' y)

--hoch x y = case y of
--  Z -> S Z
--  S y' -> mal x (hoch x y')


data N = Z | S N deriving Show

foldN z s n = case n of
    Z    -> z
    S n' -> s (foldN z s n')

plus  = foldN (\y -> y) (\f -> \y -> S (f y))
mal = foldN (\y -> Z) (\f y -> plus (f y) y)
hoch = foldN (\y -> S Z) (\f y -> mal y (f y))


--    plus (S (S Z)) (S (S (S Z)))

--1.  foldN (S (S (S Z))) (S) (S (S Z))
--2.  S (foldN (S (S (S Z))) (S) (S Z))
--3.  S (S (foldN (S (S (S Z))) (S) (Z)))
--4.  S (S (S (S (S Z))))


    mal (S (S Z)) (S (S (S Z)))

--1.  foldN (Z) (plus (S (S Z))) (S (S (S Z)))
--2.  plus (S (S Z)) (foldN (Z) (plus (S (S Z))) (S (S Z)))
--3.  plus (S (S Z)) (plus (S (S Z)) (foldN (Z) (plus (S (S Z))) (S Z)))
--4.  plus (S (S Z)) (plus (S (S Z)) (plus (S (S Z)) (foldN (Z) (plus (S (S Z))) (Z))))
--5.  plus (S (S Z)) (plus (S (S Z)) (plus (S (S Z)) (Z)))
--6.  plus (S (S Z)) (plus (S (S Z)) (foldN (Z) (S) (S (S Z))))
--7.  plus (S (S Z)) (plus (S (S Z)) (S (foldN (Z) (S) (S Z))))
--8.  plus (S (S Z)) (plus (S (S Z)) (S (S (foldN (Z) (S) (Z)))))
--9.  plus (S (S Z)) (plus (S (S Z)) (S (S Z)))
--10. plus (S (S Z)) (foldN (S (S Z)) (S) (S (S Z)))
--11. plus (S (S Z)) (S (foldN (S (S Z)) (S) (S Z)))
--12. plus (S (S Z)) (S (S (foldN (S (S Z))) (S) (Z)))
--13. plus (S (S Z)) (S (S (S (S Z))))
--14. ...
--15. S (S (S (S (S (S Z)))))
--


--    hoch (S Z) (S (S Z))
--
--1.  foldN (S Z) (mal (S (S Z))) (S Z)
--2.  mal (S (S Z)) (foldN (S Z) (mal (S (S Z))) (Z))
--3.  mal (S (S Z)) (S Z)
--4.  foldN (Z) (plus (S (S Z))) (S Z)
--5.  plus (S (S Z)) (foldN (Z) (plus (S (S Z))) (Z))
--6.  plus (S (S Z)) (Z)
--7.  foldN (Z) (S) (S (S Z))
--8.  S (foldN (Z) (S) (S Z))
--9.  S (S (foldN (Z) (S) (Z)))
--10. S (S (Z))



ghci> plus (S (Z)) (S(S Z))
S (S (S Z))
ghci> plus (S (S Z)) (S (S (S Z)))
S (S (S (S (S Z))))
ghci> foldN (S (S (S Z))) (S) (S (S Z))
S (S (S (S (S Z))))
ghci> S (foldN (S (S (S Z))) (S) (S Z))
S (S (S (S (S Z))))
ghci> S (S (foldN (S (S (S Z))) (S) (Z)))
S (S (S (S (S Z))))
ghci> foldN (\y -> y) (\f -> \y -> S (f y))
ghci> foldN (\y -> y) (\f -> \y -> S (f y)) 
ghci> foldN (\y -> y) (\f -> \y -> S (f y)) (S (S Z)) (S (S (S Z)))
S (S (S (S (S Z))))
ghci> 
ghci> (\f -> \y -> S (f y)) (foldN (\y -> y) (\f -> \y -> S (f y)) (S Z)) (S (S (S Z)))
S (S (S (S (S Z))))
ghci> S () 
ghci> 
ghci> S (foldN (\y -> y) (\f -> \y -> S (f y)) (S Z) )
ghci> S (foldN (\y -> y) (\f -> \y -> S (f y)) (S Z) ) (S (S (S Z)))
ghci> S (foldN (\y -> y) (\f -> \y -> S (f y)) (S Z) (S (S (S Z))))
S (S (S (S (S Z))))
ghci> S (foldN (\y -> y) (\f -> \y -> S (f y)) (S Z) (S(S(S Z))))
S (S (S (S (S Z))))
ghci> S (S (foldN (\y -> y) (\f -> \y -> S (f y)) (Z) (S(S(S Z)))))
S (S (S (S (S Z))))
ghci> S (S (foldN ( (S(S(S Z)))))
foldN (\y -> y) (\f -> \y -> S (f y)) (S Z) (S(S(S Z))))
S (S (S (S (S Z))))
ghci> S (S ((\y -> y) (S(S(S Z)))))
S (S (S (S (S Z))))
ghci> hoch (S Z) (S (S Z))
S (S Z)
ghci> hoch (S(S Z)) (S (S Z))
S (S (S (S Z)))
ghci> hoch (S(S Z)) (S(S (S Z)))
S (S (S (S (S (S (S (S (S Z))))))))
ghci> 
