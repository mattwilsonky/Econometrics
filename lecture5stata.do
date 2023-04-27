* load data
use "\\tsclient\C\Users\mattw\Documents\Teaching\Econometrics\Wooldridge Data\Data Sets- STATA\WAGE2.DTA", replace

* run a few regressions
* discuss the standard errors and p-values
reg wage hours educ exper tenure age IQ
reg lwage hours educ exper tenure age IQ

gen wagehours = wage/hours
reg wagehours educ exper tenure age IQ
reg wagehours educ exper tenure age IQ black south urban
reg wagehours educ exper tenure age IQ married sibs brthord

* test if sibs and brthord is jointly significant
predict unrestricted_resids, residuals
reg wagehours educ exper tenure age IQ
predict restricted_resids, residuals
egen ssr_ur = total(unrestricted_resids^2)
egen ssr_r = total(restricted_resids^2)

gen f_stat = ((ssr_r - ssr_ur)/2) / (ssr_ur/(852-8-1))
summ f_stat


* Load in external data
* Penn world Table: https://www.rug.nl/ggdc/productivity/pwt/pwt-releases/pwt100
use "\\tsclient\C\Users\mattw\Documents\Teaching\Econometrics\pwt100.dta", clear

* do cross sectional in 2019
keep if year == 2019

reg rgdpo pop emp hc cn ctfp labsh

* What else are we interested in?