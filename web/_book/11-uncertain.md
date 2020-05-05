---
editor_options:
  chunk_output_type: console
---

# (PART) Operations Research {-}

# Decision Making under Uncertainty

> Decision outcomes need to be characterized not only by their expected values but also by their variability levels, thus risk control of outcome volatility is needed and can be achieved using appropriate risk measures. [@conejo2010decision]



## Bayesian Decision Analysis

Decision analysis is designed to address the kinds of decision making in the face of great uncertainty that ordinary sensitivity analysis in subsection \@ref{LP-Sense} is not sufficient.

\BeginKnitrBlock{definition}\iffalse{-91-100-101-99-105-115-105-111-110-32-97-110-97-108-121-115-105-115-32-102-114-97-109-101-119-111-114-107-93-}\fi{}<div class="definition"><span class="definition" id="def:unnamed-chunk-5"><strong>(\#def:unnamed-chunk-5)  \iffalse (decision analysis framework) \fi{} </strong></span>1. The decision maker needs to choose one of the decision alternatives.  
2. Nature then would choose one of the possible states of nature.  
3. Each combination of a decision alternative and state of nature would result in a payoff, which is given as one of the entries in a payoff table.  
4. This payoff table should be used to find an optimal alternative for the decision maker according to an appropriate criterion.</div>\EndKnitrBlock{definition}

\BeginKnitrBlock{definition}\iffalse{-91-66-97-121-101-115-105-97-110-32-100-101-99-105-115-105-111-110-32-114-117-108-101-93-}\fi{}<div class="definition"><span class="definition" id="def:unnamed-chunk-6"><strong>(\#def:unnamed-chunk-6)  \iffalse (Bayesian decision rule) \fi{} </strong></span>Using the best available estimates of the probabilities of the respective states of nature (currently the prior probabilities), calculate the expected value of the payoff for each of the possible decision alternatives. Choose the decision alternative with the maximum expected payoff.</div>\EndKnitrBlock{definition}

> In some scenarios, data is sparse and often observational and not from designed experiments. Furthermore direct data-based information about many important features of the problem is simply not available. So expert judgements have to be elicited for at least some components of the problem. [@smith2010bayesian]

> Applications of decision analysis commonly involve a partnership between the managerial decision maker (whether an individual or a group) and an analyst (whether an individual or a team) with training in OR. Some companies do not have a staff member who is qualified to serve as the analyst. Therefore, a considerable number of management consulting firms specializing in decision analysis have been formed to fill this role. [@hillier2012introduction]

### Bayesian Statistics

> When looking for a subjective methodology which can systematically incorporate expert judgements and preferences the obvious prime candidate to try out first is currently the Bayesian framework. [@smith2010bayesian]



## Stochastic Programming

> Stochastic programming is a framework for modeling optimization problems that involve uncertainty, if the probability distributions governing the data are known or can be estimated. The goal here is to find some policy that is feasible for all (or almost all) the possible data instances and maximizes the expectation of some function of the decisions and the random variables.

> Stochastic dynamic programming deals with problems in which the current period reward and/or the next period state are random, i.e. with multi-stage stochastic systems. The decision maker's goal is to maximize expected (discounted) reward over a given planning horizon.

> It assumes that probability distributions can be estimated for the random variables in the problem and then these distributions are heavily used in the analysis. [@hillier2012introduction]

### with Chance Constraints

> It might not be possible to accurately identify an upper and lower bound for an uncertain parameter. In fact, it might not even have an upper and lower bound. This is the case, for example, when the underlying probability distribution for a parameter is a normal distribution, which has long tails with no bounds. Chance constraints are designed largely to deal with parameters whose distribution has long tails with no bounds. [@hillier2012introduction]



## Robust Programming

> The seriousness of these unfortunate consequences depends somewhat on whether there is any latitude in the functional constraints in the model. It is useful to make the following distinction between these constraints.  
> - A soft constraint is a constraint that actually can be violated a little bit without very serious complications.  
> - A hard constraint is a constraint that must be satisfied.  
>
> Robust optimization is especially designed for dealing with problems with hard constraints. [@hillier2012introduction]

> The goal of robust optimization is to find a solution for the model that is virtually guaranteed to remain feasible and near optimal for all plausible combinations of the actual values for the parameters. [@hillier2012introduction]



## Newsvendor Problem

The most prototypical decision making under uncertainty problem is the newsvendor problem.

### Uncertainty: Unresponsive Demand

The demand is assumed to be unresponsive, so the pricing problem is not considered.

The selling season of the product is assumed to be very short.

#### Underage Cost and Salvage Cost {-}

> On the one hand, if realized demand exceeds the supply, then the newsvendor will sell its entire stock, but at the expense of having excess demand go unsatisfied; on the other hand, if the supply exceeds the realized demand, then the newsvendor will satisfy demand completely, but at the expense of having leftovers. [@dada2007newsvendor]

Any unsatisfied demand will be lost and incur an underage cost, and any leftover inventory will be disposed (or salvaged) with an overage cost. Suppose the cost of overage is $c_o$ and the cost of underage is $c_u$.

$$
C(Q_{t+1}) = c_{o} \max \left\{Q_{t+1} - d_{t+1}, 0\right\} + c_{u} \max \left\{d_{t+1} - Q_{t+1}, 0\right\}
$$

Currently, the cost of underage is $c_u$ in electricity supply, which can be called value of lost load (VoLL), is super high compared to market prices of electricity. VoLL is the estimated amount that customers receiving electricity with firm contracts would be willing to pay to avoid a disruption in their electricity service. [@VoLL, Wikipedia] So retailers tend to procure extra electricity in order to satisfy customers' demand, and generation companies build more backup generators.

### Fixed-Lead One-Time Procurement

standard newsvendor problem

### Optimal Stopping One-Time Procurement

For procurements of goods, companies may not have the ability to make decisions regard target units only, and the demand in target units may be uncertain. The delivery of goods procured takes time, and it may be uncertain. That is, the lead time of procurements may be uncertain. For goods instead of services, they are storable. So it's better for companies to receive the goods early when the lead time varies.

> Moreover, the procurement lead times are often uncertain. Delays can occur for many reasons, including transportation-infrastructure issues in rapidly-developing economies, congestion in foreign and domestic ports, customs inspections, and logistical issues involving export quotas. [@wang2009wait]

> Ordering earlier reduces the “lateness” risk associated with uncertain lead times but it also increases the firms’ demand risk, i.e., the potential mismatch between the quantity procured and the realized demand. [@wang2009wait]

### Cases

- [@bucher2015quantification] TSOs procure control reserve resources.
  * Transmission system operators are responsible for power system balancing.
  * two-stage adaptive robust optimization model

- [@pandvzic2013offering] VPPs participate in day-ahead market and manage assets.
  * Networks are not considered.

- chapter 8 in [@morales2013integrating] VPPs participate in day-ahead market and manage assets.
  * Networks are not considered.
