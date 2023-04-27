* load in data
use "", clear

* summary statistics of y and x, where x is a binary treatment
summarize y
summarize x

* summary of y, grouped by x = 0 and x = 1
bysort x: summarize y

* generate the ATE


* run the simple regression, compare to ATE
reg y x

* run the regression without beta_0
reg y x, noconstant 
