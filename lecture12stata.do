* Lecture 12 stata
use "\\tsclient\C\Users\mattw\Documents\Teaching\Econometrics\Wooldridge Data\Data Sets- STATA\MROZ.DTA", clear

*ols equation - interested in educ on wages
reg lwage educ exper expersq hours unem city, robust

* use motheduc as an instrument for educ
* note s.e.s bigger
ivreg lwage (educ = motheduc) exper expersq hours unem city, robust

* include two instruments
ivreg lwage (educ = motheduc fatheduc) exper expersq hours unem city, robust

* Test for weak instruments
reg educ motheduc exper expersq hours unem city, robust
reg educ motheduc fatheduc exper expersq hours unem city, robust
test motheduc fatheduc

* Test for endogeneity: was IV necessary?
predict educ_hat, resid
reg lwage educ exper expersq hours unem city educ_hat, robust


* Show same as OLS if instrument for itself
reg lwage educ exper expersq hours unem city, robust
ivreg lwage (educ = educ) exper expersq hours unem city, robust

* SImultaneous equations, example 16.4 in textbook
 use "\\tsclient\C\Users\mattw\Documents\Teaching\Econometrics\Wooldridge Data\Data Sets- STATA\OPENNESS.DTA", clear
 
 * inflation is a function of income and opnness
 * openness is a function of inflation, income, and land size
 * therefore, can use land as an instrument
ivreg inf (open = lland) lpcinc, robust