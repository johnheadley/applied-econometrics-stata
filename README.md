# Applied econometrics in Stata

Two empirical projects from my BSc Economics & Econometrics at City, University of London: a difference-in-differences policy evaluation and a cross-sectional test of compensating wage differentials. Each folder contains the Stata do-file that produced every result in the report, a README summarising the question, data, method and findings, and the original report as a PDF.

| Project | Method | Headline result | Folder |
|---|---|---|---|
| Effect of the 2009/10 information campaign promoting family-friendly workplaces on US women's labour-market outcomes (EC3017 Applied Econometrics) | Difference-in-differences with year and state fixed effects, individual controls and robust SEs; event-study test of parallel trends | Employment +0.027 (SE 0.003, ≈ +3.3%), annual hours +110 (≈ +7.4%), hourly wage −0.74 (≈ −5.2%); labour income unchanged (not significant) | [`did-family-friendly-campaign/`](did-family-friendly-campaign/) |
| Is there a "sustainability wage discount"? Compensating wage differentials applied to ESG, following Krueger, Metzger & Wu (2024) (EC3019 Labour Economics) | OLS of log hourly wage on a sustainable-job dummy and human-capital controls, robust SEs; table exported with `esttab` | Sustainable-job coefficient −0.049 (SE 0.030), not significant at the 10% level: the discount is not supported on this data | [`sustainability-wage-gap/`](sustainability-wage-gap/) |

## Data note

The datasets were provided by City, University of London for coursework and are **not redistributed** here (`.gitignore` excludes `.dta`, `.csv` and `.xlsx` files). The do-files are published for the method; they cannot be run without the course datasets. Each do-file reads the data from a `global datadir` set at the top of the file.

---

John Headley · BSc Economics & Econometrics, City, University of London
