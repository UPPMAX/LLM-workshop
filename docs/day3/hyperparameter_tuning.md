---
title: Hyperparameter Tuning
icon: fontawesome/solid/sliders
---

# Hyperparameter tuning
- What could be tuned?
- Overview of basic tuning techniques:
    - Grid search (not recommended)
    - Random search
    - BayesOpt, ... (what others, don't need full coverage)
- Simple example with job-arrays
- (For small tasks use HTC framework like HyperQueue)
- More complex example using Optuna

## Components
- Parameter selection
- Parameter evaluation

## Optimization methods
- Grid search (not recommended)
- Random search
- Bayesian methods
- Bandit methods
- Population based methods

### Grid search
- Typically first thing you can think of
- Inefficient, especially for many hyperparameters

### Random search
- Even simpler than grid search
- Typically also better than grid search

### Bayesian methods
- Update beliefs based on observations
- In theory mathematically optimal
- In practice, choice of distributions very constrained
    - [Conjugate priors](https://www.johndcook.com/CompendiumOfConjugatePriors.pdf)
    - Fixed hyperhyperparameters
- Requires more work and thinking on your part

$$
    P(X|D) = \frac{P(D|X)P(X)}{P(D)}
$$

### Bandit methods
- Focus more resources on promising runs
- Typically about pruning bad runs
    - Is combined with a sampling strategy

### Population based methods
- Evolutionary algorithms
- Genetic algorithms
- Particle swarm optimization
- Ant colony optimization
- ...

## Working with a resource queue
- Overhead and job-size
- Sequential evalution
- Batch evaluation
- Asynchronous workers

### Overhead and job-size
- Launching a job with SLURM has some overhead
    - Preparing node 0-5 minutes
    - Importing python packages ~ 1 minute
    - Loading LLM and/or dataset into memory 1-30 minutes
- But, bigger jobs are harder to schedule
    - Longer queue time
    - Lower overall resource utilization
    - (On Alvis: More likely to hit AssocGrpBillingRunMinutes limit)

### Overhead and job-size: Short and small
<!-- Add image/gantt -->

### Overhead and job-size: Medium length
<!-- Add image/gantt -->

### Overhead and job-size: Big and wide
<!-- Add image/gantt -->

### Sequential evaluation
- One job at the time
<!-- Add image/gantt -->

### Batch evaluation
<!-- Add image/gantt -->

### Asynchronous workers
<!-- Add image/gantt -->

## Hyperparameters
- Model architecture
- Training hyperparameters
- Inference hyperparameters
- Performance hyperparameters
- Possible metrics

### Model architecture
- Base model, very important choice
- Changing base model -> restart hyperparameter search

### Training hyperparameters
- Optimizer choice
- Learning rate and schedule
- Batch size
- Regularisation, momentum, ...
- LoRA etc. and their parameters
- Floating point precision
- RL parameters (KL coefficient, reward model learning rate, ...)

### Inference hyperparameters
- Temparature
- Top-k
- Repetition penalty
- Beam search width
- ...

## Priors
- What are good start values?
- How some variables interacti with each other.

## Types of metrics
- Evaluation: loss, accuracy, ...
- Speed: seq/s, ...
- Compute budget: GPU-h
- Memory use: GB

## Excercises
- Job-arrays and random search
- Optuna
- (Optional: Tiny jobs, hyperqueue (goal=seq/s?))
