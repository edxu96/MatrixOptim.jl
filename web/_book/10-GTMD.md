---
editor_options:
  chunk_output_type: console
---

# Game Theory and Mechanism design



## Mechanism Design

### Desired Properties

According to section 2.2 in [@mitridati2019design], following four desired properties are defined. A major design challenge is to identify the links and the trade-off between these properties.

\BeginKnitrBlock{definition}<div class="definition"><span class="definition" id="def:unnamed-chunk-2"><strong>(\#def:unnamed-chunk-2) </strong></span>**Efficiency** The social welfare of the agents participating in the mechanism, with respect to the revealed preferences, is maximized, and no agent desires to deviate unilaterally from its dis- patch. In other words, the outcomes of social welfare maximization align with profit-maximization of agents. </div>\EndKnitrBlock{definition}

> The efficiency property can be interpreted as the existence of a Nash equilibrium that coincides with the maximum social welfare, i.e., a Pareto efficient Nash equilibrium. [@mitridati2019design]

\BeginKnitrBlock{definition}<div class="definition"><span class="definition" id="def:unnamed-chunk-3"><strong>(\#def:unnamed-chunk-3) </strong></span>**Incentive Compatibility** Every agent can maximize its utility by acting according to its true preferences. </div>\EndKnitrBlock{definition}

> As the agents hold private information, they might have incentives to misreport their true preferences in order to manipulate the outcomes of the community management problem and increase their profits, or for privacy concerns. Thus, designing a mechanism that motivates the agents to be truthful is a major challenge for the community manager. [@mitridati2019design]

> The incentive compatibility property, also called dominant-strategy incentive compatibility, requires that there exists a truth-revealing dominant-strategy equilibrium, i.e., each agent can achieve its optimal objective, regardless of what the others do, by revealing its true preferences. [@mitridati2019design]

\BeginKnitrBlock{definition}<div class="definition"><span class="definition" id="def:unnamed-chunk-4"><strong>(\#def:unnamed-chunk-4) </strong></span>**Budget Balance (Allocation Efficiency)** The community manager has neither financial deficit nor financial excess.</div>\EndKnitrBlock{definition}

> It guarantees that the community manager is non-profit. [@mitridati2019design]

\BeginKnitrBlock{definition}<div class="definition"><span class="definition" id="def:unnamed-chunk-5"><strong>(\#def:unnamed-chunk-5) </strong></span>**Group Rationality** No group of agents can benefit by splitting from the community.</div>\EndKnitrBlock{definition}
