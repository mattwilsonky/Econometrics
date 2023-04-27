* Stata code for lecture 2

* load in a dataset
use "\\tsclient\C\Users\mattw\Documents\Teaching\Econometrics\Wooldridge Data\Data Sets- STATA\beveridge.dta", clear

* get summary statistics for main variables
summarize vrate urate

* scatterplot the two variables
graph twoway scatter vrate urate

* compute simple correlation coefficient
corr vrate urate

* simple regression model
reg vrate urate

* try some nonlinear specifications- which is the best?
gen urate2 = urate^2
gen lnurate = ln(urate)
gen lnvrate = ln(vrate)
gen urate1 = 1/urate

reg vrate urate2
reg vrate urate1
reg vrate lnurate
reg lnvrate lnurate

* put regression line on scatterplot
graph twoway (scatter vrate urate) (lfit vrate urate)

