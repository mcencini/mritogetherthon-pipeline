# Simulation (day 2)

Simulate the sequence on one of the placenta phantoms with KomaMRI.

| | |
|---|---|
| **Reads** | `sequence.seq`, `bvals`, `bvecs`, a phantom of the hands-on material's `data/phantoms` |
| **Writes** | `raw.mrd` |

- `raw.mrd`: ISMRMRD raw data. Each acquisition is one k-space line, numbered
  by its counters: `idx.repetition` is its volume, from 0, and
  `idx.kspace_encode_step_1` its line, from 0. Each volume holds each line
  once.
