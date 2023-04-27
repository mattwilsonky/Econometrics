* Stata notes for Lecure 10, time series

* download data from FRED
* show how to do interactively
* FRED API key: https://fredaccount.stlouisfed.org/apikeys
 import fred CPIAUCSL DGS10, daterange(1945-01-01 2023-04-10) aggregate(monthly,avg)  clear

* tsset
gen month = month(daten)
gen year = year(daten)
tostring month, replace
tostring  year, replace
gen ym = year + "-"  + month
gen monthn = monthly(ym, "YM")
format monthn %tm
tsset monthn
gen cpi = CPIAUCSL
gen r10yr = DGS10

* lagged variables
gen cpi_1 = cpi[_n-1]
gen cpi_2 = cpi[_n-2]
gen r10yr_1 = r10yr[_n-1]
gen r10yr_2 = r10yr[_n-2]

* stationarity and differenced variables
graph twoway line cpi daten
gen pi_cpi = cpi - cpi_1
graph twoway line pi_cpi daten

* Dickey-Fuller test for unit root
dfuller cpi
dfuller cpi, trend
dfuller cpi, drift
dfuller pi_cpi
dfuller pi_cpi, trend
dfuller pi_cpi, drift

* detrending: 3 methods
* Linear:
reg pi_cpi monthn 
predict pi_linear, resid
* HP filter
tsfilter hp pi_hp=pi_cpi, smooth(14400)
* Hamilton (2018)
reg pi_cpi L24.pi_cpi L25.pi_cpi L26.pi_cpi L27.pi_cpi L28.pi_cpi L29.pi_cpi L30.pi_cpi L31.pi_cpi L32.pi_cpi L33.pi_cpi L34.pi_cpi L35.pi_cpi L36.pi_cpi
predict pi_hamilton, resid
* Plot these three
destring year, replace
twoway (line pi_linear monthn) (line pi_hp monthn) (line pi_hamilton monthn) if year > 2000

* AR, MA, ARMA
reg pi_hamilton L1.pi_hamilton L2.pi_hamilton L3.pi_hamilton L4.pi_hamilton L5.pi_hamilton L6.pi_hamilton L7.pi_hamilton L8.pi_hamilton L9.pi_hamilton L10.pi_hamilton L11.pi_hamilton L12.pi_hamilton

arima pi_hamilton, ar(1/12)
arima pi_hamilton, ma(1/12)
arima pi_hamilton, ar(1/12) ma(1/12)

* Durbin-Watson test for serial correlation
reg pi_hamilton r10yr
estat dwatson

* HAC standard errors
newey pi_hamilton r10yr, lag(1)

* VARs
var pi_hamilton r10yr
