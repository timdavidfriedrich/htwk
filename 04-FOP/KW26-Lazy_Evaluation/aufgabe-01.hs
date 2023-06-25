-- y ist strikt
f x y z = case y || x of
    False -> y
    True -> case z && y of
        False -> z
        True -> False

g x y z = case x || y of
    False -> y
    True -> case z || y of
        False -> z
        True -> False

h x y z = case x < y of
    False -> x + y + z
    True -> case x + y == y || z > x of
        False -> x + z
        True -> y
