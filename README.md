# Introduction
The codes are for comparing the estimation performance of <br />
**L1 minimization without prior**, <br />
**weighted l1 minimization with prior**, <br />
**weighted l1 minimization with prior Pruning** <br />

The theorem foundation can be found in our ongoing paper: <br />
**Resilient Pruning Observer Design for Cyber-Physical Systems under False Data Injection Attacks**

If you use the whole codes or part of them, please cite the paper:
```
@INPROCEEDINGS{Yu2021resilient,
  author={Zheng, Yu and Anubi, Olugbenga Moses},
  booktitle={2021 American Control Conference (ACC)}, 
  title={Attack-Resilient Weighted L1 Observer with Prior Pruning}, 
  year={2021},
  volume={},
  number={},
  pages={},
  doi={}
```

Any question about the paper, please contact Yu Zheng (*yz19b@fsu.edu*), Dr.Anubi (*anubi@fsu.edu*).

# Simulation results
![resilient_power_system](https://user-images.githubusercontent.com/36635562/153718519-f1f62007-b2bb-4d9e-beac-b286e2a3b3dc.png)


# Entrance:
## total_simulation.m
post-processing entrance
## Visulization.m
generate the figures in paper

# Main functions:
## resilient_estimation_Withoutprior.m
L1-minimization without prior
## resilient_estimation_Withoracle.m
Weighted L1-minimization with oracle
## resilient_estimation_Withpruning.m
Weighted L1-minimization with pruning algorithm based on oracle

# Support functions:
(4) L1_noprior_solver.m               (original l1-minimization solver) <br />
(5) Weighted_L1_solver.m              (weighted l1-minimization solver)<br />
(6) sysGen.m                          (generate full observable (A,C))<br />
(7) gen_attack_channel.m              (FDIA generator)<br />
(8) pruning_algorithm.m               (pruning algorithm)

# Small support functions:
(9) CDF_inv.m                          (generate agreement probability satisfying ROC)<br />
(10) pmf_PB.m                          (calculate pmf of Poisson-binomial distribution)<br />
(11) reliable_num_attacks.m            (for first step in pruning algorithm)
