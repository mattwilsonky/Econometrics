* Lecture 6 stata
use "\\tsclient\C\Users\mattw\Documents\Teaching\Econometrics\Wooldridge Data\Data Sets- STATA\SLEEP75.DTA", replace

* Run a regression, do asymptotic tests by hand and compare to stata output
reg earns74 educ totwrk age sleep 
reg earns74 educ totwrk age sleep  male marr prot south
test male marr prot south

* Example with data rescaling. Show same p-values, etc
gen earns_per_week = earns74 / 52
gen sleep_per_night = sleep / 7
reg earns_per_week educ totwrk age sleep_per_night  male marr prot south
test male marr prot south

* Standardizing variables
egen educ_z = std(educ)
egen work_z = std(totwrk)
egen age_z = std(age)
egen sleep_z = std(sleep)
reg earns74 educ_z work_z age_z sleep_z  male marr prot south

* Phillips curve polynomial
 use "\\tsclient\C\Users\mattw\Documents\Teaching\Econometrics\Wooldridge Data\Data Sets- STATA\phillips.dta", replace

 reg inf inf_1 unem
 gen unem2 = unem^2
 gen unem3 = unem^3
 reg inf inf_1 unem unem2 unem3
 
* Interaction terms
 use "\\tsclient\C\Users\mattw\Documents\Teaching\Econometrics\Wooldridge Data\Data Sets- STATA\countymurders.dta", replace
 gen dens_rpcpi = density*rpcpersinc
 reg murdrate density percmale perc2029 rpcpersinc dens_rpcpi

* Use adjusted R-squared to choose between non-nested models
 reg murdrate density percmale perc2029
 reg murdrate popul percblack perc1019

* Confidence interval for y
 reg murdrate density percmale perc2029 rpcpersinc dens_rpcpi
predict murdrate_predicted
predict ses_y, stdf
gen mr_interval_upper = murdrate_predicted + 2*ses_y
gen mr_interval_lower = murdrate_predicted - 2*ses_y