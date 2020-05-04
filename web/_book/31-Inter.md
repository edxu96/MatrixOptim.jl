---
editor_options:
  chunk_output_type: console
---

# (PART) Applications {-}

# Intermediation 

> The central role of firms as intermediaries in establishing and operating markets: "Firms create and manage markets by acting as intermediaries between buyers and sellers." [@spulber1996market]



## Virtual Power Plant (VPP) {#VPP}

> VPP is a cluster of dispersed generating units, flexible loads, and storage systems that are grouped in order to operate as a single entity. [@morales2013integrating]

VPP operators have direct control over all units.

### (a) Components of VPP {-}

- dispatchable generators
- responsive loads
- storage
- stochastic generators

### (b) Operation of VPP: Profit-Maximization Problem {-}

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

### (c) Cost Allocation Problem {-}

The costs and profits must be distributed in a fair way.

### (d) Spatial Models {-}


> Due to the dispersed nature of these resources, there is only one infrastructure “branched” enough to reach all of them: the distribution grid. Consequently, the management of VPPs will also call, among other things, for: [@morales2013integrating]
> 1. The enhancement of the control and monitoring of the distribution network to guarantee the performance, reliability, and security of the electricity supply.
> 2. The modeling, design and test of advanced components acting actively in the grid such as generators, transformers, smart meters, cables, breakers, insulators, power electronics, and converters.
> 3. The development of procedures to identify weaknesses in the distribution grid and propose guidelines for its reinforcement and expansion.

### (e) Franchise Agreements and Cooperative Games {-}

> Cooperative games are often analyzed through the framework of cooperative game theory, which focuses on predicting which coalitions will form, the joint actions that groups take and the resulting collective payoffs. [@wiki:cooperative]



## Dynamic Procurement & Pricing (DPP)

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
