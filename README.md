# Introduction
The codes are for comparing the estimation performance of <br />
**L1 minimization without prior**, <br />
**weighted l1 minimization with oracle**, <br />
**weighted l1 minimization with Pruning** <br />

The theorem foundation can be found in our ongoing paper: <br />
**Resilient Pruning Observer Design for Cyber-Physical Systems under False Data Injection Attacks**

If you use the whole codes or part of them, please cite the paper:
```
@proceeding{Yu2020resilient,
  author={Zheng, Yu and Anubi, Olugbenga Moses},
  title= "{Resilient Pruning Observer Design for Cyber-Physical Systems under False Data Injection Attacks}",
  series = {},
  volume={},
  number={},
  pages={},
  year={2020},
  publisher={}
}
```

Any question about the paper, please contact Yu Zheng (*yz19b@fsu.edu*), Dr.Anubi (*anubi@fsu.edu*).

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
