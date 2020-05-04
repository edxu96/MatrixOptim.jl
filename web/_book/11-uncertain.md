---
editor_options:
  chunk_output_type: console
---

# (PART) Operations Research {-}

# Decision Making Under Uncertainty

> Decision outcomes need to be characterized not only by their expected values but also by their variability levels, thus risk control of outcome volatility is needed and can be achieved using appropriate risk measures. [@conejo2010decision]



## Stochastic Programming

> Stochastic programming is a framework for modeling optimization problems that involve uncertainty, if the probability distributions governing the data are known or can be estimated. The goal here is to find some policy that is feasible for all (or almost all) the possible data instances and maximizes the expectation of some function of the decisions and the random variables.

> Stochastic dynamic programming deals with problems in which the current period reward and/or the next period state are random, i.e. with multi-stage stochastic systems. The decision maker's goal is to maximize expected (discounted) reward over a given planning horizon.



## Robust Programming



## Newsvendor Problem


### Stochastic Unresponsive Demand

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


### Optimal Stopping Procurement

For procurements of goods, companies may not have the ability to make decisions regard target units only, and the demand in target units may be uncertain. The delivery of goods procured takes time, and it may be uncertain. That is, the lead time of procurements may be uncertain. For goods instead of services, they are storable. So it's better for companies to receive the goods early when the lead time varies.

> Moreover, the procurement lead times are often uncertain. Delays can occur for many reasons, including transportation-infrastructure issues in rapidly-developing economies, congestion in foreign and domestic ports, customs inspections, and logistical issues involving export quotas. [@wang2009wait]

> Ordering earlier reduces the “lateness” risk associated with uncertain lead times but it also increases the firms’ demand risk, i.e., the potential mismatch between the quantity procured and the realized demand. [@wang2009wait]

### Cases

- [@bucher2015quantification] TSOs procure control reserve resources.
  * Transmission system operators are responsible for power system balancing.
  * two-stage adaptive robust optimization model
