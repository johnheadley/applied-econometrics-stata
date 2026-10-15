# Compensating wage differentials: is there a "sustainability wage discount"?

EC3019 Labour Economics, Coursework 2 · City, University of London · John Headley

**Files:** [`sustainability_wage_gap.do`](sustainability_wage_gap.do) (Stata do-file reproducing every result below) · [`Labour_Economics_Coursework_2_EC3019.pdf`](Labour_Economics_Coursework_2_EC3019.pdf) (the report).

## Question

Adam Smith's theory of compensating wage differentials says that job characteristics enter workers' utility alongside the wage, so a job with a desirable non-pecuniary amenity can pay less in equilibrium. Krueger, Metzger & Wu (2024) apply this idea to ESG: on Swedish matched employer–employee panel data they find that workers in more sustainable firms accept lower wages — a **sustainability wage gap of 8.7% at the baseline** — which helps explain those firms' stronger free cash flows. Treating the ESG profile of the employer as an amenity, $U = f(w, ESG)$, the prediction is $w_{\text{sustainable}} < w_{\text{unsustainable}}$. This coursework asks whether such a sustainability discount can be detected in a cross-sectional dataset with a sustainable-job indicator.

## Data

Cross-section of **2,033 workers** with the log hourly wage, a string variable identifying sustainable versus unsustainable firms (converted to a dummy), years of schooling, experience, a cognitive test score (`BAS3`), a knowledge-of-the-world-of-work score (`KWW`), gender, race and a rural indicator. The data are not redistributed (see the [data note](../README.md#data-note)).

## Method

OLS of the log hourly wage on the sustainable-job dummy and human-capital and demographic controls, with heteroskedasticity-robust standard errors; the results table is exported with `esttab`:

$$\ln w_i = \beta_0 + \beta_1\, Sustainable_i + \beta_2\, Educ_i + \beta_3\, Exper_i + \beta_4\, Exper_i^2 + \beta_5\, Female_i + \beta_6\, NonWhite_i + \beta_7\, Rural_i + \beta_8\, KWW_i + \beta_9\, BAS3_i + u_i$$

Education, experience and its square, and the two test scores control for human capital that could affect both the choice of a sustainable employer and the wage; the demographic dummies ensure that the gap is not driven by gender, race or rural/urban differences. Hypotheses: $H_1$: $\beta_1 < 0$ and statistically significant (a sustainability discount exists); $H_0$: $\beta_1 \geq 0$ or not significant.

## Results

Table 1 — OLS estimates of the sustainability wage gap (dependent variable: log hourly wage)

| Variable | Coefficient | Robust SE |
|---|---|---|
| Sustainable job | −0.049 | (0.030) |
| Years of schooling | 0.060*** | (0.006) |
| Experience | 0.082*** | (0.010) |
| Experience squared | −0.002*** | (0.000) |
| Intelligence score (BAS3) | 0.002** | (0.001) |
| Female | −0.027 | (0.017) |
| Non-white | −0.084*** | (0.028) |
| Rural area | −0.060** | (0.030) |
| Work knowledge score (KWW) | 0.007*** | (0.001) |
| Constant | 4.590*** | (0.116) |
| Observations | 2,033 | |
| R² | 0.212 | |

\* p < 0.10, \*\* p < 0.05, \*\*\* p < 0.01.

The human-capital variables behave as expected: each year of schooling raises the hourly wage by about 6.0% and each year of experience by about 8.2% (with diminishing returns); non-white workers earn about 8% less and workers in rural areas about 6.0% less. The coefficient on the sustainable-job dummy is negative (−0.049, i.e. sustainable workers earn about 4.9% less) but **not statistically significant at the 10% level**, so the hypothesis of a sustainability discount is not supported on this data.

## Limitations (as discussed in the report)

- The dataset only has a dummy for sustainability, whereas Krueger, Metzger & Wu (2024) use ESG grades; the ESG rating methodology is itself a black box with low visibility.
- The data are a cross-section: individuals cannot be followed over their careers, so individual fixed effects cannot absorb time-invariant unobserved heterogeneity as in the paper's panel. Since innate ability does not change from job to job, the correlation between the change in wage and the change in amenity when a worker switches jobs is a better measure of the compensating differential (Borjas).
- The paper relates switches between sustainable and unsustainable firms to exogenous events, which this cross-section cannot do.
- Neither analysis observes other pecuniary amenities across sectors.

The non-significant result therefore does not invalidate Krueger, Metzger & Wu (2024): the difference in methodology and data is not sufficient to support the paper's finding, but it does not reject the link between compensating wage differentials and a sustainability discount either.

## Reproducing

Set `global datadir` at the top of `sustainability_wage_gap.do` to the folder containing the course dataset (`MainData`), install `estout` once (`ssc install estout`) and run the do-file. The dataset is provided by City, University of London for coursework and is not included in this repository, so the do-file cannot be run without it.

## References

- Atz et al. (2023), on the correlation between companies' ESG ratings and financial performance (cited in the report).
- Borjas, G. J. (2019), *Labor Economics*, McGraw-Hill Education.
- Krueger, Metzger & Wu (2024), the sustainability wage gap on Swedish matched employer–employee data (cited in the report).
