********************************************************************************
* Compensating wage differentials and the "sustainability wage discount":
* OLS of log hourly wage on a sustainable-job dummy and human-capital controls
*
* Author : John Headley
* Module : EC3019 Labour Economics, Coursework 2
*          BSc Economics & Econometrics, City, University of London
* Date   : academic year 2025/26
* Data   : MainData.dta (cross-section, N = 2,033). Provided by City,
*          University of London for coursework - not redistributed.
*          The do-file cannot be run without it.
*
* Variables used
*   lwage        log hourly wage (dependent variable)
*   unsus        string: "sustainable" / "unsustainable" (firm type)
*   educ         years of schooling
*   exper        years of experience
*   BAS3         cognitive (intelligence) test score
*   KWW          knowledge-of-the-world-of-work score
*   gender       string: "male" / "female"
*   race         1 if non-white
*   rural        1 if rural area
*   enrol        enrolment indicator (stored as a string in the raw data)
********************************************************************************

* Set this to the folder containing the course dataset
global datadir "PATH_TO_COURSE_DATA"

* One-off installation of the table-export command
* ssc install estout

*-------------------------------------------------------------------------------
* 1. Data inspection
*-------------------------------------------------------------------------------
use "$datadir/MainData", clear

* Look at the data to understand the variables of interest and their state
describe
summarize

*-------------------------------------------------------------------------------
* 2. Data cleaning
*-------------------------------------------------------------------------------
* Several numeric variables are stored as strings: convert them
destring educ age exper, replace
summarize educ age exper

* Gender is a string ("male"/"female"): build a dummy, 1 = female, 0 = male
gen female_dummy = (gender == "female")
tab female_dummy

* Enrolment is also stored as a string
destring enrol, replace

* Firm type is a string ("sustainable"/"unsustainable"): build a dummy,
* 1 = sustainable, 0 = unsustainable
gen sustainable = (unsus == "sustainable")
tab sustainable

* Experience squared captures diminishing returns to experience
gen expersq = exper * exper

*-------------------------------------------------------------------------------
* 3. OLS estimation of the sustainability wage gap (questions c and d)
*-------------------------------------------------------------------------------
* log(wage) on the sustainable-job dummy plus human-capital and demographic
* controls, heteroskedasticity-robust standard errors
regress lwage i.sustainable educ exper expersq BAS3 i.female_dummy i.race ///
    i.rural KWW, robust
estimates store model1

*-------------------------------------------------------------------------------
* 4. Results table (Table 1 of the report)
*-------------------------------------------------------------------------------
esttab model1 using "ResultsTable.rtf", replace ///
    b(3) se(3) r2(3) ///
    star(* 0.10 ** 0.05 *** 0.01) ///
    nobaselevels ///
    label ///
    title("Table 1: OLS Estimates of the Sustainability Wage Gap") ///
    mtitles("Log Hourly Wage") ///
    coeflabels( ///
        1.sustainable   "Sustainable Job" ///
        educ            "Years of Schooling" ///
        exper           "Experience" ///
        expersq         "Experience Squared" ///
        BAS3            "Intelligence Score" ///
        1.female_dummy  "Female" ///
        1.race          "Non-White" ///
        1.rural         "Rural Area" ///
        KWW             "Work Knowledge Score" ///
        _cons           "Constant" ///
    ) ///
    addnotes("Standard errors in parentheses")
