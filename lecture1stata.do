* Commands for stata examples, lecture 1

* load in a dataset
use "\\tsclient\C\Users\mattw\Documents\Teaching\Econometrics\Wooldridge Data\Data Sets- STATA\ncaa_rpi.dta", replace

* get mean, median, percentiles of variables
summarize wins losses coachexper, detail

* counts of certain conditions
count 
count if wins > 20
count if tourney == 1
count if tourney 

* See distribution of discrete variable
tab coachexper

* mean and median by conditional of variables
summarize winperc if coachexper > 25
summarize winperc if coachexper <= 25


* mean and meadian by subsets
gen idvar = 0
replace idvar = 1 if coachexper > 25
bysort idvar: summarize wins losses tourney

* create mean, sd and store it as new variable
egen meanwin = mean(winperc)
egen sdwin = sd(winperc)
bysort idvar: egen meanwin2 = mean(winperc)

* Label new variables
label var meanwin "Mean Winning Percentage, Full Sample"
label var sdwin "S.D. Winning Percentage, Full Sample"
label var meanwin2 "Mean Winning Percentage, by Coach Experience"

* quickly view new variables
tab meanwin 
tab sdwin 
tab meanwin2

* Download some external data
* Personal Income and Employment by State, 2021 https://apps.bea.gov/itable/?ReqID=70&step=1#eyJhcHBpZCI6NzAsInN0ZXBzIjpbMSwyNCwyOSwyNSwzMSwyNiwyNywzMF0sImRhdGEiOltbIlRhYmxlSWQiLCIyMSJdLFsiQ2xhc3NpZmljYXRpb24iLCJOb24tSW5kdXN0cnkiXSxbIk1ham9yX0FyZWEiLCIwIl0sWyJTdGF0ZSIsWyIwIl1dLFsiQXJlYSIsWyJYWCJdXSxbIlN0YXRpc3RpYyIsWyItMSJdXSxbIlVuaXRfb2ZfbWVhc3VyZSIsIkxldmVscyJdLFsiWWVhciIsWyIyMDIxIl1dLFsiWWVhckJlZ2luIiwiLTEiXSxbIlllYXJfRW5kIiwiLTEiXV19
* save as 'bea_table.csv'
* remove first 3 rows
 import delimited "\\tsclient\C\Users\mattw\Downloads\bea_table.csv", varnames(1) rowrange(5) clear 