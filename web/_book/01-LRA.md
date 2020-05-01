---
editor_options:
  chunk_output_type: console
---

# (PART) Statistics {-}

# Linear Regression Analysis (LRA) {#LRA}



Following packages and functions are used in this chapter:


```r
## basic packages
library(knitr)
library(kableExtra)
library(tidyverse)
library(conflicted)
library(magrittr)
library(broom)
## paticular packages for this project
library(lmtest)
library(corrr)
library(tseries)
library(corrplot)
library(car)
library(perturb)
source("../src/funcs.R")
source("../src/tests.R")
```

**To-Learn**

- [x] Confidence Interval
- [x] MSA
- [ ] Likelihood Ratio Test
- [ ] ANOVA
- [ ] Orthogonalization

## Summary of Data and Models

### Dataset `1980-us-census-part`


```
#> Warning: Missing column names filled in: 'X1' [1]
```

```
#> Parsed with column specification:
#> cols(
#>   X1 = col_character(),
#>   Part = col_double(),
#>   schooling = col_double()
#> )
```



### Dataset `1980-us-census`


```
#> Warning: Missing column names filled in: 'X1' [1]
```

```
#> Parsed with column specification:
#> cols(
#>   X1 = col_character(),
#>   age = col_double(),
#>   hrswork1 = col_double(),
#>   uhrswork = col_double(),
#>   incwage = col_double(),
#>   ran = col_double(),
#>   wageW = col_double(),
#>   LwageW = col_double(),
#>   educ = col_double()
#> )
```



###

The data set is defined as follows based on file `recs.csv`:


```r
set.seed(6)
dat_recs <-
  read_csv("../data/recs.csv") %>%
  dplyr::slice(sample(nrow(.), 300)) %>%
  mutate(y = log(KWH / NHSLDMEM)) %>%
  mutate(x8 = TOTROOMS + NCOMBATH + NHAFBATH) %>%
  dplyr::select(y, x2 = NHSLDMEM, x3 = EDUCATION, x4 = MONEYPY, x5 = HHSEX,
    x6 = HHAGE, x7 = ATHOME, x8) %>%
  mutate_at(seq(2, 8), as.integer) %>%  # make continuous variables discrete
  mutate(x5 = - x5 + 2)
```

Models used in the context are:


```r
mods_recs <- list()
mods_recs[[1]] <- lm(y ~ x2 + x3 + x4 + x5 + x6 + x7, data = dat_recs)
mods_recs[[2]] <- lm(y ~ x2 + x3 + x4 + x6 + x7, data = dat_recs)
mods_recs[[3]] <- lm(y ~ x2 + x4 + x6 + x7, data = dat_recs)
```

The dataset `delivery` is from [@montgomery2012introduction]:


```r
dat_delivery <- 
  readxl::read_xls("../data/delivery.xls", col_names = c("i", "time", "case",
    "dist"), skip = 1)
```

The dataset `acetylene` is from [@montgomery2012introduction]:


```r
dat_acetylene <-
  readxl::read_xls("../data/acetylene.xls", col_names = c("i", "p", "t_raw",
    "h_raw", "c_raw"), skip = 1) %>%
  mutate(t = (t_raw - 1212.5) / 80.623) %>%
  mutate(h = (h_raw - 12.44) / 5.662) %>%
  mutate(c = (c_raw - 0.0403) / 0.03164) %>%
  select(i, p, t, h, c)
```

<!-- ```{r child = '../docs/LRA-visual.Rmd'} -->
<!-- ``` -->

<!-- ```{r child = '../docs/LRA-MSA.Rmd'} -->
<!-- ``` -->

<!-- ```{r child = '../docs/LRA-multi.Rmd'} -->
<!-- ``` -->

<!-- ```{r child = '../docs/LRA-model.Rmd'} -->
<!-- ``` -->

<!-- ```{r child = '../docs/LRA-factor.Rmd'} -->
<!-- ``` -->



## Statistical Inference

### Hypothesis Tests

> The __null hypothesis__, denoted by $\mathrm{H}_{0}$, is a statement about a population parameter. The __alternative hypothesis__ is denoted by $\mathrm{H}_{1}$. The null hypothesis will be rejected if it appears to be inconsistent with the sample data and will not be rejected otherwise. The rejection of the null hypothesis $\mathrm{H}_{0}$ is a strong statement that $\mathrm{H}_{0}$ does not appear to be consistent with the observed data. The result that $\mathrm{H}_{0}$ is not rejected is a weak statement that should be interpreted to mean that $\mathrm{H}_{0}$ is consistent with the data. [@ross2017introductory]

> A __test statistic__ is a statistic whose value is determined from the sample data. Depending on the value of this test statistic, the null hypothesis will be rejected or not. The __critical region__, also called the __rejection region__, is that set of values of the test statistic for which the null hypothesis is rejected. [@ross2017introductory]

> The classical procedure for testing a null hypothesis is to fix a small __level of significance__ $\alpha$ and then require that the probability of rejecting $\mathrm{H}_{0}$ when $\mathrm{H}_{0}$ is true is less than or equal to $\alpha$. [@ross2017introductory]

Critical values are calculated by:

```R
c <- qchisq(1 - alpha, df, lower.tail = TRUE, log.p = FALSE)
```

The hypothesis should be rejected if `stat >= c` is true.

Alternatively, `p_value` can be computed first:

```R
1 - pchisq(stat, df1)
```

and compared to `alpha`. The hypothesis should be rejected if `p_value >= alpha` is true.
 
#### (a) Design of Hypothesis Tests {-}

> If you are trying to establish a certain hypothesis, then that hypothesis should be designated as the alternative hypothesis. Similarly, if you are trying to discredit a hypothesis, that hypothesis should be designated the null hypothesis. [@ross2017introductory]

\BeginKnitrBlock{example}<div class="example"><span class="example" id="exm:unnamed-chunk-8"><strong>(\#exm:unnamed-chunk-8) </strong></span>Thus, for instance, if the tobacco company is running the experiment to prove that the mean nicotine level of its cigarettes is less than $1.5,$ then it should choose for the null hypothesis

$$ \mathrm{H}_{0}: \mu \geq 1.5 $$

and for the alternative hypothesis

$$ \mathrm{H}_{1}: \mu<1.5 $$

Then the company could use a rejection of the null hypothesis as "proof" of its claim that the mean nicotine content was less than 1.5 milligrams.</div>\EndKnitrBlock{example}

#### (b) Interpretation of Test Result {-}

> When conducting a statistical test, the thought experiment is that our sample is drawn from some hypothetical population distribution that could have generated the data. Our sample is then compared with hypothetical samples drawn from that hypothetical population distribution. [@hendry2007econometrics :4.3.2 Interpreting the Test Result]

### Student's t-Test (test-t) {#test-t}

- [One-Sided Hypothesis Test with T-Statistic in R?, Stack Overflow](https://stackoverflow.com/questions/13811472/one-sided-hypothesis-test-with-t-statistic-in-r)
- [t-tests, Quick-R](https://www.statmethods.net/stats/ttest.html)
- [Inference about Slope coefficient in R](https://stackoverflow.com/questions/8089797/inference-about-slope-coefficient-in-r)

### Likelihood Ratio Test (test-LLR) {#test-LLR}

> Likelihood ratio tests are well suited for making inferences about restrictions on a well-specified model, where we are able, and willing, to maximize the likelihood function in the unrestricted model as well as the restricted model. [@hendry2007econometric]

From section 1-3-4, 2-3-2 in [@hendry2007econometric]:

$$ \mathrm{Q} = \frac{\max _{\theta \in \Theta_{R}} \mathrm{L}_{Y_{1}, \ldots, Y_{n}}(\theta)}{\max _{\theta \in \Theta_{U}} \mathrm{L}_{Y_{1}, \ldots, Y_{n}}(\theta)} $$

$$ \mathrm{LR} = -2 \log \mathrm{Q} = 2 \left\{\max _{\theta \in \Theta_{U}} \ell_{Y_{1}, \ldots, Y_{n}}(\theta)-\max _{\theta \in \Theta_{R}} \ell_{Y_{1}, \ldots, Y_{n}}(\theta)\right\} $$

where the closer $\mathrm{LR}$ is to zero, the more likely it is that $\theta$ could satisfy the restriction.

A statistical test can now be constructed as a decision rule. If $\mathrm{Q}$ is (close to) unity, and correspondingly $\mathrm{LR}$ is small, the restricted maximum likelihood estimate would be (nearly) as likely as the unrestricted estimate, so in that case, we would fail to reject the hypothesis.

#### (a) Signed LLR-Test {-#LLR-Test-Sign}

- [If and how to use one-tailed testing in multiple regression](https://stats.stackexchange.com/questions/325354/if-and-how-to-use-one-tailed-testing-in-multiple-regression)


```r
test_llr(mods_part[[1]], mods_part[[2]]) %>% tab_ti()
```

<table class="table table-condensed table-responsive" style="width: auto !important; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;"> whi </th>
   <th style="text-align:left;"> stat </th>
   <th style="text-align:left;"> df1 </th>
   <th style="text-align:left;"> df2 </th>
   <th style="text-align:left;"> p_value </th>
   <th style="text-align:left;"> prob </th>
   <th style="text-align:left;"> if_reject </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> logLik </td>
   <td style="text-align:left;"> 309.8 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 7183 </td>
   <td style="text-align:left;"> 0 </td>
   <td style="text-align:left;"> 0.05 </td>
   <td style="text-align:left;"> TRUE </td>
  </tr>
</tbody>
</table>


```r
test_llr_sign(mods_part[[1]], mods_part[[2]], T) %>% tab_ti()
```

<table class="table table-condensed table-responsive" style="width: auto !important; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;"> whi </th>
   <th style="text-align:left;"> stat </th>
   <th style="text-align:left;"> df1 </th>
   <th style="text-align:left;"> df2 </th>
   <th style="text-align:left;"> p_value </th>
   <th style="text-align:left;"> prob </th>
   <th style="text-align:left;"> if_reject </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> logLik-sign </td>
   <td style="text-align:left;"> 17.6 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 7183 </td>
   <td style="text-align:left;"> 2.724e-05 </td>
   <td style="text-align:left;"> 0.05 </td>
   <td style="text-align:left;"> TRUE </td>
  </tr>
</tbody>
</table>

#### (b) LLR-Test for One Parameter {-#LLR-Test-1}

Likelihood ratio tests for restricting one parameter can be performed by using partial correlations.




```
#> Registered S3 methods overwritten by 'lme4':
#>   method                          from
#>   cooks.distance.influence.merMod car 
#>   influence.merMod                car 
#>   dfbeta.influence.merMod         car 
#>   dfbetas.influence.merMod        car
```

<table class="table table-condensed table-responsive" style="width: auto !important; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;"> term </th>
   <th style="text-align:left;"> estimate </th>
   <th style="text-align:left;"> std.error </th>
   <th style="text-align:left;"> statistic </th>
   <th style="text-align:left;"> p.value </th>
   <th style="text-align:left;"> p.r.squared </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) </td>
   <td style="text-align:left;"> 8.615613 </td>
   <td style="text-align:left;"> 0.200829 </td>
   <td style="text-align:left;"> 42.9002 </td>
   <td style="text-align:left;"> 2.434e-128 </td>
   <td style="text-align:left;"> 0.8626622 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> x2 </td>
   <td style="text-align:left;"> -0.259971 </td>
   <td style="text-align:left;"> 0.029144 </td>
   <td style="text-align:left;"> -8.9203 </td>
   <td style="text-align:left;"> 5.153e-17 </td>
   <td style="text-align:left;"> 0.2135731 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> x3 </td>
   <td style="text-align:left;"> -0.081468 </td>
   <td style="text-align:left;"> 0.037994 </td>
   <td style="text-align:left;"> -2.1442 </td>
   <td style="text-align:left;"> 3.284e-02 </td>
   <td style="text-align:left;"> 0.0154493 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> x4 </td>
   <td style="text-align:left;"> 0.064473 </td>
   <td style="text-align:left;"> 0.019196 </td>
   <td style="text-align:left;"> 3.3586 </td>
   <td style="text-align:left;"> 8.869e-04 </td>
   <td style="text-align:left;"> 0.0370726 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> x5 </td>
   <td style="text-align:left;"> -0.034200 </td>
   <td style="text-align:left;"> 0.072129 </td>
   <td style="text-align:left;"> -0.4742 </td>
   <td style="text-align:left;"> 6.357e-01 </td>
   <td style="text-align:left;"> 0.0007667 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> x6 </td>
   <td style="text-align:left;"> 0.007251 </td>
   <td style="text-align:left;"> 0.002403 </td>
   <td style="text-align:left;"> 3.0173 </td>
   <td style="text-align:left;"> 2.774e-03 </td>
   <td style="text-align:left;"> 0.0301358 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> x7 </td>
   <td style="text-align:left;"> 0.013147 </td>
   <td style="text-align:left;"> 0.017798 </td>
   <td style="text-align:left;"> 0.7387 </td>
   <td style="text-align:left;"> 4.607e-01 </td>
   <td style="text-align:left;"> 0.0018588 </td>
  </tr>
</tbody>
</table>


```r
mods_recs[[1]] %>% tab_tidy(T) %>%
  {.[5, 6]} %>%
  as.numeric() %>%
  {- 299 * log(1 - .)} %>%
  {1 - pchisq(., 1)}
```

```
#> [1] 0.6320156
```

<table class="table table-condensed table-responsive" style="width: auto !important; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;"> whi </th>
   <th style="text-align:left;"> stat </th>
   <th style="text-align:left;"> df1 </th>
   <th style="text-align:left;"> df2 </th>
   <th style="text-align:left;"> p_value </th>
   <th style="text-align:left;"> prob </th>
   <th style="text-align:left;"> if_reject </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> logLik </td>
   <td style="text-align:left;"> 0.2301 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 299 </td>
   <td style="text-align:left;"> 0.6314 </td>
   <td style="text-align:left;"> 0.05 </td>
   <td style="text-align:left;"> FALSE </td>
  </tr>
</tbody>
</table>

The `deviance` is the residual sum of square:

<table class="table table-condensed table-responsive" style="width: auto !important; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;"> r.squared </th>
   <th style="text-align:left;"> adj.r.squared </th>
   <th style="text-align:left;"> sigma </th>
   <th style="text-align:left;"> statistic </th>
   <th style="text-align:left;"> p.value </th>
   <th style="text-align:left;"> df </th>
   <th style="text-align:left;"> logLik </th>
   <th style="text-align:left;"> AIC </th>
   <th style="text-align:left;"> BIC </th>
   <th style="text-align:left;"> deviance </th>
   <th style="text-align:left;"> df.residual </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 0.3159 </td>
   <td style="text-align:left;"> 0.3018 </td>
   <td style="text-align:left;"> 0.6122 </td>
   <td style="text-align:left;"> 22.54 </td>
   <td style="text-align:left;"> 7.957e-22 </td>
   <td style="text-align:left;"> 7 </td>
   <td style="text-align:left;"> -274.9 </td>
   <td style="text-align:left;"> 565.9 </td>
   <td style="text-align:left;"> 595.5 </td>
   <td style="text-align:left;"> 109.8 </td>
   <td style="text-align:left;"> 293 </td>
  </tr>
</tbody>
</table>

#### (c) LLR-Test for More Parameters {-#LLR-Test-N}

Likelihood tests for restricting more than one parameter can be only performed by using values of log likelihood in the original and restricted models. For example, to test the hypothesis that coefficients for `x5` and `x7` are both 0 in `mods_recs[[1]]`, following calculation can be conducted. We cannot reject the hypothesis according the function output.

<table class="table table-condensed table-responsive" style="width: auto !important; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;"> whi </th>
   <th style="text-align:left;"> stat </th>
   <th style="text-align:left;"> df1 </th>
   <th style="text-align:left;"> df2 </th>
   <th style="text-align:left;"> p_value </th>
   <th style="text-align:left;"> prob </th>
   <th style="text-align:left;"> if_reject </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> logLik </td>
   <td style="text-align:left;"> 5.178 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 298 </td>
   <td style="text-align:left;"> 0.07509 </td>
   <td style="text-align:left;"> 0.05 </td>
   <td style="text-align:left;"> FALSE </td>
  </tr>
</tbody>
</table>

The above three test statistics are related in an additive manner, so models with multiple regressors can be reduced in a step-wise procedure. During every step, partial correlations for regressors can be used as the indication of the next term to be reduced.


```
#> [1] TRUE
```

### Confidence Interval

> By choosing a 95% coverage, we accept that with 5% confidence we reach the false conclusion that the true parameter is not in the confidence interval. [@hendry2007econometrics :2.3.1 Confidence Intervals]




```
#>                    2.5 %      97.5 %
#> (Intercept)  8.220362250  9.01086394
#> x2          -0.317328785 -0.20261313
#> x3          -0.156243666 -0.00669182
#> x4           0.026693277  0.10225333
#> x5          -0.176156322  0.10775608
#> x6           0.002521419  0.01198065
#> x7          -0.021881524  0.04817554
```
