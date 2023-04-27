* Stata examples for lecture 9
use  "\\tsclient\C\Users\mattw\Documents\Teaching\Econometrics\Wooldridge Data\Data Sets- STATA\big9salary.dta", 

** Regression Error Specification Test (RESET)
** test functional specification
* by hand
reg salary totpge year assoc prof exper pubindx
predict salaryhat
gen salaryhat2 = salaryhat^2
gen salaryhat3 = salaryhat^3
reg salary totpge year assoc prof exper pubindx salaryhat2 salaryhat3, robust
test salaryhat2 salaryhat3
* by command
reg salary totpge year assoc prof exper pubindx, robust
estat ovtest

** Davidson-MacKinnon Test
** test linear vs log
gen logsalary = log(salary)
gen logtotpge = log(totpge)
gen logexper= log(exper)
gen logpubindx = log(pubindx)
reg logsalary logtotpge year assoc prof logexper logpubindx 
predict logsalaryhat
reg  salary totpge year assoc prof exper pubindx logsalaryhat, robust
reg logsalary logtotpge year assoc prof logexper logpubindx salaryhat, robust

** Using a lagged dependent variable as a regressor
bys id: gen salary1 = salary[_n-1]
reg salary totpge year assoc prof exper pubindx salary1

** Missing observations: Missing Indicator Method (MIM)

reg lsalary year logpubindx, robust
reg lsalary lpubindx pubindx0, robust

** Heckit Model

*suppose some schools didnt' participate in 1992
replace salary = . if year == 92 & osu == 1
replace salary = . if year == 92 & mich == 1
replace salary = . if year == 92 & msu == 1

drop logsalary
gen logsalary = log(salary)
replace logsalary = 0 if logsalary == .

gen selected = 0
replace selected = 1 if salary > 0
heckman logsalary logtotpge year assoc prof logexper logpubindx, select(selected = logtotpge year assoc prof logexper logpubindx osu mich msu)

** Studentized Residuals
reg salary totpge year assoc prof exper pubindx, robust
predict sr, rstudent

