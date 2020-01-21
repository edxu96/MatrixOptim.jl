
# Markov Decision Process

## 1, Markov Chain

> A Markov process is a stochastic process with the property that, the probability of any particular future behavior of the process, when its current state is known exactly, is not altered by additional knowledge concerning its past behavior. [1]

The stationary transition probability matrix (STPM) or Markov matrix (MM) can be used to describe the behavior of a Markov process.

> A Markov process is completely defined once its transition probability matrix and initial state (or, more generally, the probability distribution of the initial state) are specified. [1]

> Suppose that a transition probability matrix on a finite number of states has the property that when raised to some power `k`, the `k`-step transition probability matrix has all of its elements strictly positive. Such a transition probability matrix, or the corresponding Markov chain, is called regular. The most important fact concerning a regular Markov chain is the existence of a limiting probability distribution, and this distribution is independent of the initial state. [1]

> A transition probability matrix is called doubly stochastic if the columns sum to one as well as the rows. If the matrix is regular, then the unique limiting distribution is the uniform distribution. [1]

### 1.1, Features

* `MarkovChainFamily`
	- `markov_chain` 
	- `stpm`
	- `n`-step `stpm`
	- `limiting_prob_dist`

## 2, References

1. Pinsky, M. and Karlin, S., 2010. An introduction to stochastic modeling. Academic press.
