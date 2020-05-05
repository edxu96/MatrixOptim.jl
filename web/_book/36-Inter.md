---
editor_options:
  chunk_output_type: console
---

# Intermediation 

> The central role of firms as intermediaries in establishing and operating markets: "Firms create and manage markets by acting as intermediaries between buyers and sellers." [@spulber1996market]



## Virtual Power Plant (VPP) {#VPP}

> VPP is a cluster of dispersed generating units, flexible loads, and storage systems that are grouped in order to operate as a single entity. [@morales2013integrating]

VPP operators have direct control over all units.

### Components of VPP {-}

- dispatchable generators
- responsive loads
- storage
- stochastic generators

### Operation of VPP: Profit-Maximization Problem {-}

When point forecasts are used, the problem becomes:

$$ \begin{align} \max_{\Xi} \quad & \rho = \sum_{t=1}^{T} \left[ \lambda^{\mathrm{D}}(t) P^{\mathrm{D}}(t) \tau - \sum_{i \in I}\left[C_{i}\left(E_{G i}(t)\right) \right. \right. \\
& \qquad \left.\left.+C_{i}^{\mathrm{SU}}(t) + C_{i}^{\mathrm{SD}}(t) \right] + \sum_{j \in J} U_{j} \left( E_{L j}(t) \right) \right] \\
\text{s.t.} \quad & \sum_{i \in I} E_{G i}(t)+\left(\sum_{q \in Q} \widehat{P}_{W q}(t)+\sum_{k \in K} P_{S k}^{d}(t)\right) \tau = \\
& \qquad \sum_{j \in J} E_{L j}(t) \quad + \left(\sum_{k \in K} P_{S k}^{c}(t)+P^{\mathrm{D}}(t)\right) \tau, \quad \forall t=1, \ldots, T \\
& G_{i}\left(P_{G i}, E_{G i}, v_{i}\right) \leq 0, \quad \forall i \in I \\
& v_{i} \in\{0,1\}^{T}, \quad \forall i \in I \\
& L_{j}\left(P_{L j}, E_{L j}\right) \leq 0, \quad \forall j \in J \\
& S_{k}\left(P_{S k}^{c}, P_{S k}^{d}, E_{S k}\right) \leq 0, \quad \forall k \in K
\end{align} $$

while the problem needs stochastic programming or robust programming when scenarios or interval forecasts are used respectively.

### Cost Allocation Problem {-}

The costs and profits must be distributed in a fair way.

### Spatial Models {-}

- [@molzahn2017survey] Molzahn, D. K., Dörfler, F., Sandberg, H., Low, S. H., Chakrabarti, S., Baldick, R., & Lavaei, J. (2017). A survey of distributed optimization and control algorithms for electric power systems. IEEE Transactions on Smart Grid, 8(6), 2941-2962.
  * independent system operators (ISOs) seek a minimum cost generation dispatch for large-scale transmission systems by solving an optimal power flow (OPF) problem
  * Network models are discussed in part 2.

> Due to the dispersed nature of these resources, there is only one infrastructure “branched” enough to reach all of them: the distribution grid. Consequently, the management of VPPs will also call, among other things, for: [@morales2013integrating]
> 1. The enhancement of the control and monitoring of the distribution network to guarantee the performance, reliability, and security of the electricity supply.
> 2. The modeling, design and test of advanced components acting actively in the grid such as generators, transformers, smart meters, cables, breakers, insulators, power electronics, and converters.
> 3. The development of procedures to identify weaknesses in the distribution grid and propose guidelines for its reinforcement and expansion.

### Franchise Agreements and Cooperative Games {-}

> Cooperative games are often analyzed through the framework of cooperative game theory, which focuses on predicting which coalitions will form, the joint actions that groups take and the resulting collective payoffs. [@wiki:cooperative]

### Cases

- Dominguez, R., Baringo, L., & Conejo, A. J. (2012). Optimal offering strategy for a concentrating solar power plant. Applied Energy, 98, 316-325.
  * Mix stochastic programming and robust programming.
  * The uncertainty of the thermal production of the solar field is represented by a set of uncertain but bounded coefficients
  * ARIMA model to generate scenarios of prices

- Pandžić, H., Morales, J. M., Conejo, A. J., & Kuzle, I. (2013). Offering model for a virtual power plant based on stochastic programming. Applied Energy, 105, 282-292.
  * Since the WPP power output is stochastic, it is modeled using historical scenarios.
  * Historical data is also used to build stochastic trees modeling prices in the day-ahead and balancing markets.

- [@mashhour2011bidding, @mashhour2011bidding2] Mashhour, E., & Moghaddas-Tafreshi, S. M. (2010). Bidding strategy of virtual power plant for participating in energy and spinning reserve markets. IEEE Transactions on Power Systems, 26(2), 949-964.
  * The optimization problem is a nonlinear mixed-integer programming with inter-temporal constraints.
  * GA is used to solve the optimization problem.



## Dynamic Procurement & Pricing (DPP)

- [monahan2004dynamic](https://pubsonline.informs.org/doi/abs/10.1287/msom.1030.0026) Monahan, G. E., Petruzzi, N. C., & Zhao, W. (2004). The dynamic pricing problem from a newsvendor's perspective. Manufacturing & Service Operations Management, 6(1), 73-91.
  * the fundamental question that must be answered each time a demand occurs is whether to accept the demand or to reserve the unit of inventory for possible sale later to a potentially higher-paying customer.
  * Yield management models differ from the dynamic pricing model in their assumption that price is exogenous; thus, their primary focus, in effect, is on inventory control.

### Continuous DPP

- [chan2004coordination](https://link.springer.com/chapter/10.1007/978-1-4020-7953-5_9) Chan, L. M., Shen, Z. M., Simchi-Levi, D., & Swann, J. L. (2004). Coordination of pricing and inventory decisions: A survey and classification. In Handbook of quantitative supply chain analysis (pp. 335-392). Springer, Boston, MA.
- [yano2005coordinated](https://link.springer.com/chapter/10.1007/0-387-25002-6_3) Yano, C. A., & Gilbert, S. M. (2005). Coordinated pricing and production/procurement decisions: A review. In Managing Business Interfaces (pp. 65-103). Springer, Boston, MA.

#### of Perishable Goods {-}

- [chen2014coordinating](https://pubsonline.informs.org/doi/abs/10.1287/opre.2014.1261?casa_token=f1fPl3Q4Uz4AAAAA:6VIIyjCgEovgrVqSoVBOT649okKiLI8i4XSmwm3j4Q6cw6TRxT8W-82O4NaUIFmVz2aU4xSPVQ) Chen, X., Pang, Z., & Pan, L. (2014). Coordinating inventory control and pricing strategies for perishable products. Operations Research, 62(2), 284-300.
- [li2015joint](https://www.tandfonline.com/doi/abs/10.1080/00207543.2014.961206?casa_token=bGyM9znzTw4AAAAA:0MJVwI8N4L2bWAgCJdmeRmbFcH_vwPV2di26d_Vi-XmQxyReDpQh58YW0BkPQIFXOYQdn50leZ9I) Li, S., Zhang, J., & Tang, W. (2015). Joint dynamic pricing and inventory control policy for a stochastic inventory system with perishable products. International Journal of Production Research, 53(10), 2937-2950.

#### of Durable Goods {-}

> The manager indicated to us that the most significant factor leading to increased inventory levels and decreased efficiency in his plant is the unpredictability of demand due to promotional and pricing decisions made by the marketing group [ahn2007pricing](#reference)

- [ahn2007pricing](https://pubsonline.informs.org/doi/abs/10.1287/opre.1070.0411?casa_token=8c1RxdVZ07AAAAAA:ZZNvBOLFtzoVb6a8pw_AT0Nk49U62BbX51ZbK0HRFXkxmvEArGJ3ojyyK7Xw609kGZCfqBv0CQ) Ahn, H. S., Gümüş, M., & Kaminsky, P. (2007). Pricing and manufacturing decisions when demand is a function of prices in multiple periods. Operations Research, 55(6), 1039-1057.
  * Some of the customers entering the system in a given period who cannot afford the product in that period have the patience to wait until the price drops to a level they can afford.
  * Customers do tend to buy it as soon as their budget constraint (i.e., reservation price) is met.
- [elmaghraby2003dynamic](https://pubsonline.informs.org/doi/abs/10.1287/mnsc.49.10.1287.17315?casa_token=luc4f-sEei4AAAAA:XajqTL6fS4bxICkL7diK8kbZw1Xvmu6vGjhwSZYoOOCTH-RpubH-UFH2nXQRpysCvH6xfPovs_M) Elmaghraby, W., & Keskinocak, P. (2003). Dynamic pricing in the presence of inventory considerations: Research overview, current practices, and future directions. Management science, 49(10), 1287-1309.

### Forward DPP of Time-Dependent Products (FDPP)

TDP: Customers are uncertain about their consumption utilities during forward purchase.



### The Process over Time

- __alwan2016dynamic__ The Dynamic Newsvendor Model with Correlated Demand

> Hospitals and blood banks aim to accurately forecast the blood demand each day and then plan and manage their blood inventory.

Demand in different target units need to be satisfied continuously.

### Dynamic Procurement and Cancellation

> The newsvendor can spread her orders over the planning horizon to take advantage of lower ordering costs with early orders and more accurate demand forecasts with late orders. [wang2012multiordering](#reference)

> Resources for balancing, e.g. thermal power plants and flexible demand, become scarce due to finite availability and long ramp-up times. Average marginal costs of available resources are high. Thus, the market tightens up considerably. [garnier2015balancing](#reference)

#### in Intraday Electricity Market {-}

> In an efficient market design, as much as possible of these adjustments would however be done in the intraday market to avoid the use of more expensive flexible resources in real-time balancing. [weber2010adequate](#reference)

> Given that they earn a capacity revenue, power plant operators may then offer lower energy prices on the reserve markets than on the intraday market. If the TSOs use those prices for pricing balancing energy, situations may occur, where the balancing energy price is lower than the intraday market price. [weber2010adequate](#reference)

- __garnier2015balancing__ Balancing forecast errors in continuous-trade intraday markets
- __aid2016optimal__ An optimal trading problem in intraday electricity markets

### Demand Response

> Each retailer is deemed to have sold to its customers the amount of energy that went through their meters. If for any period the aggregate amount over all its customers exceeds the amount that it has contracted to buy, the retailer has to purchase the difference on the spot market at whatever value the spot price reached for that period. Similarly, if the amount contracted exceeds the amount consumed by its customers, the retailer is deemed to have sold the difference on the spot market. [@kirschen2018fundamentals]

> To reduce its exposure to the risk associated with the unpredictability of the spot market prices, a retailer therefore tries to forecast as accurately as possible the demand of its customers. [@kirschen2018fundamentals]

> The decision on energy consumption is ultimately left to the individual consumers, who must weigh cost savings against a potential loss of comfort. [@morales2013integrating]

The first thing to know is always how to obtain enough data to construct the problem.

#### Necessary Infrastructure {-}

> In order to evolve from a setup where supply follows demand to one where demand follows supply, power systems must undergo drastic structural and operational changes. [@morales2013integrating]

#### Time-of-Use Tariff {-}

> However, their relevance is challenged as the penetration of renewables into power systems grows sufficiently large to be able to influence prices in the wholesale electricity markets. Time-of-use tariffs are static, i.e., they are fixed long time in advance, and therefore unable to adapt to the rapid fluctuations of renewables. [@morales2013integrating]

#### Real-Time Dynamic Pricing {-}

Prices are able to adapt dynamically according to the latest forecast of renewable outputs and consumptions.



## Principal-Agent Problem (PA)

> The principal–agent problem, in political science and economics (also known as agency dilemma or the agency problem) occurs when one person or entity (the "agent"), is able to make decisions and/or take actions on behalf of, or that impact, another person or entity: the "principal". This dilemma exists in circumstances where agents are motivated to act in their own best interests, which are contrary to those of their principals, and is an example of moral hazard. [_Principal-Agent Problem, Wikipedia_]

### Application in Management of Energy Efficiency

> The "principal–agent problem" has also been discussed in the context of energy consumption by Jaffe and Stavins in 1994. They were attempting to catalog market and non-market barriers to energy efficiency adoption. In efficiency terms, a market failure arises when a technology which is both cost-effective and saves energy is not implemented. Jaffe and Stavins describe the common case of the landlord-tenant problem with energy issues as a principal–agent problem. "[I]f the potential adopter is not the party that pays the energy bill, then good information in the hands of the potential adopter may not be sufficient for optimal diffusion; adoption will only occur if the adopter can recover the investment from the party that enjoys the energy savings. Thus, if it is difficult for the possessor of information to convey it credibly to the party that benefits from reduced energy use, a principal/agent problem arises." [_Principal-Agent Problem, Wikipedia_]

- __tanaka2007mind__ Mind the gap: quantifying principal-agent problems in energy efficiency
- __jaffe1994energy__ The energy efficiency gap: what does it mean?

### Multiple Principal Problem (MP)

> The multiple principal problem, also known as the common agency problem, the multiple accountabilities problem, or the problem of serving two masters, is an extension of the principal-agent problem that explains problems that can occur when one person or entity acts on behalf of multiple other persons or entities. Specifically, the multiple principal problem states that when one person or entity (the "agent") is able to make decisions and / or take actions on behalf of, or that impact, multiple other entities: the "principals", the existence of asymmetric information and self-interest and moral hazard among the parties can cause the agent's behavior to differ substantially from what is in the joint principals' interest, bringing large inefficiencies. The multiple principal problem has been used to explain inefficiency in many types of cooperation, particularly in the public sector, including in parliaments, ministries, agencies, inter-municipal cooperation, and public-private partnerships, although the multiple principal problem also occurs in firms with multiple shareholders. [_Multiple Principal Problem, Wikipedia_]
