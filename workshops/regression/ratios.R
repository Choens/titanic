## #############################################################################
## Ratios.R
##
## Risk ratio & odds ratio for male passengers aboard Titanic.
##
## #############################################################################



## Died ------------------------------------------------------------------------
## We don't usually calculate risk/odds ratios for good things, so it might be
## easier to think of this as calculating the risk factor of dieing.
## So, we need a variable, "died".
train$died <- 1
train$died[train$survived == 1] <- 0

## We can confirm this worked because these next two commands should produce
## OPPOSITE results.
table(train$survived)
table(train$died)

## 2x2 Tables ------------------------------------------------------------------
## We need a 2x2 table, and the proportions of the that 2x2 table.

## We will call the 2x2 table "t".
## This is backwards to how it is usually taught because the exposed group (men)
## with the disease (died) is in the lower right corner.
t <- table(train$died, train$sex, dnn=c("died","sex"))
t

## OR . . . if you prefer . . . .
## If you want to go all bio on it . . . just remember male is the same
## as exposed here. Calculations are the same either way.
t <- table(train$died, train$sex, dnn=c("diseased","exposed"))
t



## -----------------------------------------------------------------------------
## Odds Ratio (OR)
## Remember, our 2x2 table is NOT in the usual order.
## -----------------------------------------------------------------------------

## The code below implements the OR three different ways, based on "t".
## Confirm these are, in fact, the same!

## OR 1: Manual
(468*233) / (81*109)

## OR 2: Index
(t[2,2]*t[1,1]) / (t[1,2]*t[2,1])

## OR 3: Filtered
(t["1","male"]*t["0","female"]) / (t["1","female"]*t["0","male"])

## Unless I made a mistake, those are all the same!

## Connection to logistic regression:
## The log of a OR is ~ the same as the coefficient in logistic regression
## on the same categorical variable.
log((468*233) / (81*109))


## -----------------------------------------------------------------------------
## Risk Ratio (RR)
## -----------------------------------------------------------------------------

## To calculate the RR, we need to divide the proportion of men we died with the
## proportion of women who died. Both numbers are on the second row of "p".

## We will call the proportions of the 2x2 table "p".
## Again, this is backwards, but that's OK.
p <- prop.table(t, margin=2)
p

## The code below implements the RR three different ways, based on "p".
## Confirm these are, in fact, the same!

## RR 1: Manual

0.8110919 / 0.2579618

## RR 2: Index
p[2,2] / p[2,1]

## RR 3: Filtered
## This is a little difference from what we did earlier, because p is
## really stored as a matrix, not a data.frame.
p["1","male"] / p["1","female"]


## As you can see, all three are the same.


## Because death was _not_ A rare outcome, the OR and RR are NOT approximately equal.
