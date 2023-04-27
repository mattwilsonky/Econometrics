* load data
use "\\tsclient\C\Users\mattw\Documents\Teaching\Econometrics\Wooldridge Data\Data Sets- STATA\HPRICE3.DTA"

* simple correlations
corr price rooms area baths land inst

* simple regressions individually
reg price rooms
reg price area 
reg price baths
reg price land
reg price inst

* add in variables one at a time, etc.
* which is the best model?
reg price rooms
reg price rooms area
reg price rooms area baths
reg price rooms area baths land
reg price rooms area baths land inst

* show the relationship between rooms and area and bath
reg rooms area baths

* regression with logs
reg lprice rooms larea baths lland linst

* back to the main regression
reg price rooms area baths land inst
* create new variable with the predicted values
predict price_hat
gen resids = price - price_hat
summarize price price_hat resids