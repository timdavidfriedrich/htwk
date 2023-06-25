-- y ist strikt
f x y z = case y || x of
    False -> y
    True -> case z && y of
        False -> z
        True -> False

-- x ist strikt
g x y z = case x || y of
    False -> y
    True -> case z || y of
        False -> z
        True -> False

-- x und y sind strikt
h x y z = case x < y of
    False -> x + y + z
    True -> case x + y == y || z > x of
        False -> x + z
        True -> y
