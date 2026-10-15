# Difference-in-differences: a family-friendly workplace campaign and women's labour-market outcomes

EC3017 Applied Econometrics, Coursework 2 · City, University of London · John Headley

**Files:** [`did_family_friendly.do`](did_family_friendly.do) (Stata do-file reproducing every result below) · [`Coursework_2_EC3017.pdf`](Coursework_2_EC3017.pdf) (the report).

## Question

Did the 2009/10 information campaign promoting family-friendly workplaces improve US women's labour-market outcomes — employment, annual hours worked, hourly wage and labour income? The expected mechanism is a positive labour-supply shock: if a family-friendly workplace is a non-pecuniary amenity, utility $U = f(w, a)$ depends on the wage $w$ and on the amenity $a$, so the campaign raises the attractiveness of family-friendly employers and shifts the labour supply curve to the right. The report tests three hypotheses: (1) an employment effect (higher employment and hours), (2) a wage effect (with short-run inelastic demand, the supply shift lowers the hourly wage), and (3) a compensating-differential effect (workers trade part of their wage for the amenity).

## Data

A dataset of **191,020 US women observed between 2005 and 2014** (`CW2_main_2025_26_core.dta`), plus an extended version of the same data for the event study. Treatment group: women working in a family-friendly workplace (`FF = 1`, 48% of the sample); post-period: years from 2010 onwards. Outcomes: employment status (mean 0.82), total hours worked last year (mean 1,455), hourly wage (mean $14.85) and total annual labour income (mean $32,859). Controls: number of children under 5 and aged 5–17, marital status, race/ethnicity, education (five categories), potential experience and its square. The data are not redistributed (see the [data note](../README.md#data-note)).

## Method

Difference-in-differences with year ($\tau_t$) and state ($\theta_s$) fixed effects and heteroskedasticity-robust standard errors.

Regression 1 (baseline):

$$y_{ist} = \alpha\, FF_i + \beta\,(FF_i \times Post_t) + \tau_t + \theta_s + \varepsilon_{ist}$$

Regression 2 (with individual controls), estimated for each of the four outcomes:

$$y_{ist} = \alpha\, FF_i + \beta\,(FF_i \times Post_t) + \gamma' X_{ist} + \tau_t + \theta_s + \varepsilon_{ist}$$

where $X_{ist}$ contains children under 5, children aged 5–17, married, race/ethnicity, education, potential experience and its square. $\beta$ is the DiD estimator. Percentage effects divide $\beta$ by the pre-campaign mean of the outcome in family-friendly workplaces.

**Parallel trends.** On the extended dataset, the treatment indicator is interacted with a full set of year dummies, with 2009 as the base year (state fixed effects included):

$$y_{ist} = \sum_{j \neq 2009} \eta_j\,(FF_i \times \mathbf{1}[t = j]) + \tau_t + \theta_s + \varepsilon_{ist}$$

The pre-treatment coefficients are statistically insignificant — for 2007 and 2008, $p = 0.787$ and $p = 0.945$ — which supports the parallel-trends assumption.

## Results

| | (1) Employment | (2) Employment | (3) Annual hours | (4) Hourly wage | (5) Labour income |
|---|---|---|---|---|---|
| DiD estimator ($FF \times Post$) | 0.0261 | **0.0270** | **110.15** | **−0.736** | −138.88 |
| Robust SE | (0.0030) | (0.0029) | (8.942) | (0.0864) | (202.02) |
| Percentage effect | | +3.3% | +7.4% | −5.2% | −0.4% (n.s.) |
| Observations | 191,020 | 191,020 | 191,020 | 124,527 | 124,527 |
| R² | 0.210 | 0.262 | 0.152 | 0.284 | 0.287 |
| Controls | No | Yes | Yes | Yes | Yes |

Columns (2)–(5) use the Regression 2 specification. The employment, hours and wage effects are significant at the 1% level; the labour-income effect is not statistically significant.

**Interpretation.** The campaign acted as a positive labour-supply shock: women in family-friendly workplaces became more likely to be employed (+3.3%) and worked more hours (+7.4%), consistent with the amenity raising the utility derived from work. Because labour demand is relatively inelastic in the short run, the outward shift in supply lowered the hourly wage (−5.2%); total labour income is unchanged because the wage decrease is offset by the increase in hours worked.

## Limitations (as discussed in the report)

- The data stop in 2014, so the long-run evolution of wages after the initial decrease cannot be observed.
- An information campaign changes how people perceive family-friendly workplaces but does not oblige or incentivise firms to change; measures that constrain or incentivise firms could have a larger impact.
- The analysis does not examine who was reached by the campaign (for example whether it reached only the upper class) or whether its impact was unequal across groups.

## Reproducing

Set `global datadir` at the top of `did_family_friendly.do` to the folder containing `CW2_main_2025_26_core.dta` and `CW2_main_2025_26_extended.dta`, install `coefplot` once (`ssc install coefplot`) and run the do-file. The datasets are provided by City, University of London for coursework and are not included in this repository, so the do-file cannot be run without them.

## References

- Borjas, G. J. (2019), *Labor Economics*, McGraw-Hill Education.
- U.S. Bureau of Labor Statistics (2024), https://www.bls.gov.
- Wooldridge, J. (2024), *Introductory Econometrics*.
