* Lecture 8

* Current Population Survey '91
use "\\tsclient\C\Users\mattw\Documents\Teaching\Econometrics\Wooldridge Data\Data Sets- STATA\cps91.dta"

* Regressions with and without robust standard errors
reg faminc educ exper huseduc husexp expersq 
reg faminc educ exper huseduc husexp expersq, robust

* Robust F-test of husband characteristic
reg faminc educ exper huseduc husexp expersq husunion  husblck  hushisp
test husunion hushisp
reg faminc educ exper huseduc husexp expersq husunion  husblck  hushisp, robust
test husunion hushisp

* Breusch-Pagan Test
reg faminc educ exper huseduc husexp expersq husunion  husblck  hushisp
estat hettest

* White Test
estat imtest, white

* Feasible GLS
hetreg faminc educ exper huseduc husexp expersq, twostep het(educ exper huseduc husexp expersq)
hetreg faminc educ exper huseduc husexp expersq husunion  husblck  hushisp, twostep het(educ exper huseduc husexp expersq husunion  husblck  hushisp)

* Model variance as multiplicative function of single variable
* Because hetreg uses exp(), transform with ln()
gen logeduc = ln(educ)
hetreg faminc educ exper huseduc husexp expersq, twostep het(logeduc)