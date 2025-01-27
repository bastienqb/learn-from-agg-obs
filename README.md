# Learning from aggregate observations

<!-- start elevator-pitch -->

This package solves a common challenge in machine learning: making individual-level predictions when only aggregate target data is available.
For example, retailers would like to predict individual household income in neighborhoods around their store, but only average income figures are published to protect privacy.

The package implements a novel approach to this problem, from the paper [___Learning from Aggregate Observations___](https://arxiv.org/abs/2004.06316).
It requires only a minor modification to the objective function and is compatible with any gradient-based learning algorithm, including neural networks and boosted trees.
This approach is designed for scenarios where:

- you need to make predictions at the individual level.
- you have access to individual-level features.
- target values are only available as aggregates (e.g., means, sums), e.g. due to privacy constraints.

<!-- end elevator-pitch -->

## Installation

## Main features
