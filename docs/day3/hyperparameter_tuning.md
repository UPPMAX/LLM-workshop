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
- In theory optimal
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
![Overhead and small jobs](figures/slurm_gantt_small.svg)
- For small tasks overhead can be noticeable

### Overhead and job-size: Medium length
![Overhead and small jobs](figures/slurm_gantt_medium.svg)
- When overhead is large, combine tasks

### Overhead and job-size: Big and wide
![Overhead and small jobs](figures/slurm_gantt_big.svg)
- Long and/or wide jobs are hard to schedule
- If you can run a multi-GPU job as several single-GPU jobs, do so

### Sequential evaluation
![Sequential jobs](figures/slurm_gantt_sequential.svg)
- One job at the time, no parallelisation

### Batch evaluation
![Sequential jobs](figures/slurm_gantt_batch.svg)
- Worse parameter selection than sequential
- Runs in parallel
- Possibly long time between batches

### Asynchronous workers
![Sequential jobs](figures/slurm_gantt_asynchronous.svg)
- Worse parameter selection than sequential
- Best parallelisation

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

### Flat prior
- $p(\theta) \propto 1$
- In practice a uniform distribution
- When you're uncertain about exact place in a  range
<!-- Add plot of pdf -->

### Reciprocal prior
- $p(\theta) \propto 1/\theta$
- In practice a loguniform distribution
- When you're uncertain about order of magnitude
<!-- Add plot of pdf -->

## Types of metrics
- Evaluation: loss, accuracy, ... <!-- Add perpexity -->
- Speed: seq/s, ...
- Compute budget: GPU-h
- Memory use: GB
- Multi-objectives and/or constraints

## Excercises
- Job-arrays and random search
- Optuna
- (Optional: Tiny jobs, hyperqueue (goal=seq/s?))
