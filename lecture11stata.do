* Lecture 11 stata notes
* Use Penn World Tables
* Estimate some production functions, see effect of human capital
use "\\tsclient\C\Users\mattw\Documents\Teaching\Econometrics\pwt100.dta", clear

* Declare to be panel data
egen country_id = group(countrycode)
xtset country_id year

* Take logs
gen log_rgdpo = log(cgdpo)
gen log_emp = log(emp)
gen log_ck = log(ck)
gen log_hc = log(hc)


* Pooled cross section
reg log_rgdpo ctfp log_emp log_ck log_hc, robust
reg log_rgdpo ctfp log_emp log_ck log_hc i.year, robust

* FD estimation
xtreg d.log_rgdpo d.ctfp d.log_emp d.log_ck d.log_hc i.year
 
* FE estimation
xtreg log_rgdpo ctfp log_emp log_ck log_hc i.year, fe

* RE estimation
xtreg log_rgdpo ctfp log_emp log_ck log_hc i.year, re

* CRE estimation
bys country_id: egen ctfp_mean = mean(ctfp)
bys country_id: egen log_emp_mean = mean(log_emp)
bys country_id: egen log_ck_mean = mean(log_ck)
bys country_id: egen log_hc_mean = mean(log_hc)
xtreg log_rgdpo ctfp log_emp log_ck log_hc ctfp_mean log_emp_mean log_ck_mean log_hc_mean i.year, re

* Clustered standard errors
xtreg log_rgdpo ctfp log_emp log_ck log_hc i.year, fe vce(robust)
xtreg log_rgdpo ctfp log_emp log_ck log_hc i.year, fe vce(cluster currency_unit)

* Diff in Diff
gen euro = 0
replace euro = 1 if currency_unit == "Euro" & year >= 1999
gen t_99 = 0
replace t_99 = 1 if year >= 1999
xtreg d.log_rgdpo d.ctfp d.log_emp d.log_ck d.log_hc t_99 euro

* Was parallel trends satisfied?
keep if t_99 == 0
gen euro_1 = 0
replace euro_1 = 1 if currency_unit == "Euro" 
xtreg d.log_rgdpo d.ctfp d.log_emp d.log_ck d.log_hc euro_1