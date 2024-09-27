# Optimal Control of Virtual Power Plant (VPP)

This repository provides MATLAB scripts for the optimal control of a Virtual Power Plant (VPP) with the use of several optimization techniques including Steepest Descend (SD), Particle Swarm Optimization (PSO), Genetic Algorithm (GA), Tasmanian Devil Optimization (TDO). This system models the power control in distributed energy resources of a VPP, such as wind turbine generators (WTG), electric vehicles (EV), and storage systems (STS).

## Overview of the Project
The project investigates the control of the inputs to WTG, EV, and STS for a VPP in order to minimize the cost function of the power generation. The cost function is the difference between the generated power and load demand. Optimization methods will be used to find the optimal inputs that minimize the cost.

## Main Components
- **Virtual Power Plant Model**: In this section, the VPP model is developed using linear state-space equations, and it is simulated for a variety of kinds of input.
  - **Files**: `VPP_fitness.m`, `VPP.slx`
 - The modelled system in the present system will be in state-space, which comprises matrices (A), (B), (C) and(D); the cost function depends upon the squared error between the generated power and the load.

- **Optimization Methods**: Use of several optimization methods to reduce the cost function.
  - **Particle Swarm Optimization (PSO)**: Optimizes the system inputs to minimize the cost function.
    - Files: `Three_optimizer.m`, `plotting_res.m`
  - **Genetic Algorithm (GA)**: Another optimization method to find the optimal solution
    - Files: `GA.m`
  - **Tasmanian Devil Optimization (TDO)**: Population-based algorithm for VPP optimization problem.
- **Files**: `TDO.m`

## Simulation and Results
- **State Trajectories**: Simulations plot the system's state trajectories over a 24-hour period, showing the optimal inputs and the corresponding states.
  - **Files**: `Try.m`, `SD.m`, `plotting_res.m`
  - Results include optimal inputs for WTG, EV, and STS over time, as well as power generation and load comparison.

This project illustrates how optimization algorithms can be used to control power generation and demand in a Virtual Power Plant.
