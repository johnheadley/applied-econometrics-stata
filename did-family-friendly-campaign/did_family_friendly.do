********************************************************************************
* Difference-in-differences evaluation of the 2009/10 information campaign
* promoting family-friendly workplaces: effects on US women's labour-market
* outcomes (employment, annual hours, hourly wage, labour income)
*
* Author : John Headley
* Module : EC3017 Applied Econometrics, Coursework 2
*          BSc Economics & Econometrics, City, University of London
* Date   : academic year 2025/26
* Data   : CW2_main_2025_26_core.dta (191,020 observations of US women,
*          2005-2014) and CW2_main_2025_26_extended.dta (event study).
*          Provided by City, University of London for coursework -
*          not redistributed. The do-file cannot be run without them.
*
* Variables used
*   myemp            1 if employed
*   hours_last_year  total hours worked last year
*   wage             hourly wage rate (USD)
*   income           total annual labour income (USD)
*   FF               1 if the workplace is family friendly (treatment group)
*   post             1 if year >= 2010 (post-campaign)
*   year, statefip   year and state identifiers (fixed effects)
*   nchlt5, nch517   number of children under 5 / aged 5-17
*   married          1 if married
*   race_ethnicity   race/ethnicity categories
*   educ             education category (1 = high school ... 5 = advanced)
*   pexp, pexp2      potential experience and its square
********************************************************************************

* Set this to the folder containing the two course datasets
global datadir "PATH_TO_COURSE_DATA"

* One-off installation of the coefficient-plot command used in the event study
* ssc install coefplot

*-------------------------------------------------------------------------------
* 1. Data and descriptive statistics
*-------------------------------------------------------------------------------
use "$datadir/CW2_main_2025_26_core.dta", clear

describe
summarize

* Descriptive statistics table of the variables used in the analysis
summarize myemp hours_last_year wage income FF post nchlt5 married educ

*-------------------------------------------------------------------------------
* 2. Difference-in-differences estimator
*-------------------------------------------------------------------------------
* Interaction term FF x Post (the DiD estimator)
generate did_term = FF * post

* Regression 1 - baseline specification with year and state fixed effects
* (year and statefip are treated as dummy variables), robust SEs
regress myemp FF did_term i.year i.statefip, robust

* Regression 2 - adds individual-level controls (children, marital status,
* race/ethnicity, education, potential experience and its square)
regress myemp FF did_term i.year i.statefip nchlt5 nch517 married ///
    i.race_ethnicity i.educ pexp pexp2, robust

*-------------------------------------------------------------------------------
* 3. Other outcomes (Regression 2 specification) and percentage effects
*-------------------------------------------------------------------------------
* Annual hours worked
regress hours_last_year FF did_term i.year i.statefip nchlt5 nch517 married ///
    i.race_ethnicity i.educ pexp pexp2, robust
* Pre-policy mean for the treated group (denominator of the percentage effect):
* average hours in family-friendly workplaces (FF = 1) before the campaign (post = 0)
summarize hours_last_year if FF == 1 & post == 0

* Hourly wage
regress wage FF did_term i.year i.statefip nchlt5 nch517 married ///
    i.race_ethnicity i.educ pexp pexp2, robust
summarize wage if FF == 1 & post == 0

* Total labour income
regress income FF did_term i.year i.statefip nchlt5 nch517 married ///
    i.race_ethnicity i.educ pexp pexp2, robust
summarize income if FF == 1 & post == 0

*-------------------------------------------------------------------------------
* 4. Parallel trends: event study on the extended dataset
*-------------------------------------------------------------------------------
use "$datadir/CW2_main_2025_26_extended.dta", clear

* Interact FF with every year, using 2009 as the reference year.
* The coefficients on 1.FF#2005.year ... 1.FF#2008.year should be
* statistically insignificant (close to 0) if trends were parallel.
regress myemp i.FF##ib2009.year i.statefip, robust

coefplot, keep(1.FF#*) vertical yline(0) drop(_cons) ///
    xline(2009.5) ///
    title("Event Study: Impact on Employment") ///
    xtitle("Year") ytitle("Estimate")
