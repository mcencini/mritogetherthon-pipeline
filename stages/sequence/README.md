# Sequence (day 1)

Design a diffusion-weighted EPI sequence for the placenta in Pulseq. The
b-values and diffusion directions are the team's choice.

| | |
|---|---|
| **Reads** | nothing: the day's notebook starts from a bare-bones diffusion EPI with ramp sampling |
| **Writes** | `sequence.seq`, `bvals`, `bvecs` |

- `sequence.seq`: a Pulseq file. Its ADC events split into as many equal
  volumes as there are b-values, acquired one volume after the other.
- `bvals`: FSL's format, one line with the b-value of each volume, in s/mm².
- `bvecs`: FSL's format, three lines with the unit direction of each volume
  (zero for b = 0).

No acceleration. Partial Fourier, if used, is reconstructed by zero filling.
