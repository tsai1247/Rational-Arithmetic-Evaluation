module Main where

getList :: (Char -> Bool) -> String -> [String]             -- getList (==' ') "(1%2) + (3%4)" -> [ "(1%2)", "+", "(3%4)" ]
getList p s = case dropWhile p s of
  "" -> []
  s' -> w : getList p s'' where (w, s'') = break p s'

getContent :: String -> String                              -- getContent "(5)" -> "5"
getContent str = 
  let tmpContent = (getList (==')') str )!!0
      content = (getList (=='(') tmpContent )!!0
  in content

getChild :: String -> Integer                               -- getChild "3%5" -> 3
getChild str = 
  let content = getContent str
      child = (getList (=='%') content )!!0
  in read(child)::Integer

getParent :: String -> Integer                              -- getParent "3%5" -> 5
getParent str = 
  let content = getContent str
      parent = (getList (=='%') content )!!1
  in read(parent)::Integer

getGCD :: Integer -> Integer -> Integer                     -- getGCD 24 16 -> 8
getGCD a b = 
  if b == 0 then a
  else getGCD b (mod a b)

getFraction :: Integer -> Integer -> String                 -- getFraction 3 9 -> "3%9"
getFraction a b = show(a) ++ "%" ++ show(b)

getFractionList :: String -> [Integer]                      -- getFraction "3%9" -> [3, 9]
getFractionList str = [(getChild str), (getParent str)]

reduce :: String -> String                                  -- reduce "3%6" -> "1%2"
reduce num = 
  let child  = getChild(num)
      parent = getParent(num)
      gcd = getGCD child parent
      returnChild = div child gcd
      returnParent = div parent gcd
  in show(returnChild) ++ "%" ++ show(returnParent)


-- arithmetic
add :: String -> String -> String
add var1 var2 = 
  let frac1 = getFractionList var1
      frac2 = getFractionList var2
      ret = getFraction (frac1!!0 * frac2!!1 + frac1!!1 * frac2!!0) (frac1!!1 * frac2!!1)
  in reduce ret

minus :: String -> String -> String
minus var1 var2 = 
  let frac1 = getFractionList var1
      frac2 = getFractionList var2
      ret = getFraction (frac1!!0 * frac2!!1 - frac1!!1 * frac2!!0) (frac1!!1 * frac2!!1)
  in reduce ret

multiple :: String -> String -> String
multiple var1 var2 = 
  let frac1 = getFractionList var1
      frac2 = getFractionList var2
      ret = getFraction (frac1!!0 * frac2!!0) (frac1!!1 * frac2!!1)
  in reduce ret
  
divide :: String -> String -> String
divide var1 var2 = 
  let frac1 = getFractionList var1
      frac2 = getFractionList var2
      ret = getFraction (frac1!!0 * frac2!!1) (frac1!!1 * frac2!!0)
  in reduce ret
-- end arithmetic

-- calculate + and -
cal :: [String] -> String
cal [x] = x
cal (var1:op:var2:xs) = 
  if var1 == "divide by zero" || var2 == "divide by zero" then error "divide by zero"
  else if op == "+" then cal( (add var1 var2 ) : xs)
  else if op == "-" then cal( (minus var1 var2 ) : xs)
  else error "invalid input"


-- calculate * and /
dealWithMultipleAndDivide :: [String] -> [String]
dealWithMultipleAndDivide [] = []
dealWithMultipleAndDivide [x] = 
  if (getParent x) == 0 then error "divide by zero"
  else [x]
dealWithMultipleAndDivide (var1:op:var2:xs) = 
  if (getParent var1) == 0 || (getParent var2) == 0 then error "divide by zero"
  else if op == "+" || op == "-" then var1 : op : dealWithMultipleAndDivide(var2:xs)
  else if op == "*" then dealWithMultipleAndDivide( (multiple var1 var2 ) : xs)
  else if op == "/" then 
    if (getChild var2)==0 then error "divide by zero"
    else dealWithMultipleAndDivide( (divide var1 var2 ) : xs)
  else error "invalid input"

beautifier :: String -> String
beautifier str = 
  let val = getFractionList str in
    if val!!0 < 0 then
      let child = "(" ++ show(val!!0) ++ ")" in child ++ "%" ++ show(val!!1)
    else
      let child = show(val!!0) in child ++ "%" ++ show(val!!1)

main = do 
  x <- getLine
  let content = getList (==' ') x
      answer = cal( dealWithMultipleAndDivide content )
  putStrLn ( beautifier answer )
