
# Parameters and Model Assumptions

## 1. Propagation Model

The project adopts the Al-Hourani air-to-ground (A2G)
propagation model.

The model considers:
- Free-space path loss (FSPL)
- Line-of-Sight (LoS) probability
- Non-Line-of-Sight (NLoS) probability
- Mean excess path loss under LoS and NLoS conditions

## 2. Environment Parameters

| Environment | a | b | eta_LoS (dB) | eta_NLoS (dB) |
|---|---:|---:|---:|---:|
| Suburban | 4.88 | 0.43 | 0.1 | 21 |
| Urban | 9.61 | 0.16 | 1.0 | 20 |

Sources:
- Al-Hourani et al. (2014), IEEE Wireless Communications Letters.
- Bor-Yaliniz et al. (2018), IEEE Transactions on Wireless Communications, Table I.

## 3. Simulation Parameters

| Parameter | Value | Unit | Description |
|---|---:|---|---|
| Carrier frequency | 2.4e9 | Hz | Simulation assumption |
| UAV altitude | 100 | m | Baseline altitude |
| Ground antenna height | 1.5 | m | Assumed antenna height |
| Horizontal distance | 500 | m | Baseline distance |
| Speed of light | 299792458 | m/s | Physical constant |

These are scenario parameters selected for simulation.
They are not universal characteristics of the A2G model.

## 4. Model Equations

### Geometry

d = sqrt(r^2 + (h - hg)^2)

theta_deg = atan2(h - hg, r) * 180 / pi

### Free-Space Path Loss

FSPL_dB = 20 * log10(4 * pi * f_Hz * d_m / c)

### LoS Probability

P_LoS = 1 / (1 + a * exp(-b * (theta_deg - a)))

P_NLoS = 1 - P_LoS

### Path Loss

PL_LoS = FSPL_dB + eta_LoS_dB

PL_NLoS = FSPL_dB + eta_NLoS_dB

PL_avg = P_LoS * PL_LoS + P_NLoS * PL_NLoS

## 5. Assumptions and Limitations

- A single UAV and a fixed ground station are considered.
- The ground antenna height is measured from the same
  reference level as the UAV altitude.
- The sigmoid LoS model is an approximation.
- The model uses mean excess path loss values.
- Small-scale fading, Doppler effects and random shadowing
  are not included.
- Environment parameters are taken from published
  literature and are not universal constants.
- The 2.4 GHz carrier frequency is a scenario assumption.
