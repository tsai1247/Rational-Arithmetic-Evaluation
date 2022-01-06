# Haskell Practice
## Introduction
The project is for the final project of class "Programming Language Design (CE6145*)"

## Question
[Click here and watch part B.](https://hackmd.io/@aaaaares/SkiY16HYK) [(Backup)](https://hackmd.io/vvOiZUT5T9-i5vv-vSTdYQ)

## Explaination
### The main actions are:
* Get one-line input from user (String)
    * e.g. `(3%5) + (7%10) * (5%3)`
* Turn the input to a List ([String])
    * e.g. `[(3%5), +, (7%10), *, (5%3)]`
* Calculate all the * and / operators, from left to right ([String])
    * e.g. `[(3%5), +, 7%6]`
* Calculate all the + and - operators, from left to right (String)
    * e.g. `53%30`
* Print the result

### Input format:
* `Fraction` or followed by one or more ` Operator Fraction`
    * Operator: `+`, `-`, `*`, or `/`
    * Fraction: An `%` between two integers. Wrapped with one pair of `()` is allowed.

### Output format:
* for a positive answer, output the Fraction like `A%B`
* for a negative answer, output the Fraction like `(A)%B`
* if 'divide by zero' occured, throw an exception with message "divide by zero"

### Compile and run the code
* You have to download [ghc]( https://www.haskell.org/ghc/download_ghc_9_0_2.html) first.
* Execute `run.bat` in Windows
* Execute `run.sh` in Linux
