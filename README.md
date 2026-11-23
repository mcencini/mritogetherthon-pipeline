# MRI TogetherThon 2026: the pipeline

The open-source, end-to-end pipeline for placenta diffusion MRI that the
[MRI TogetherThon](https://mritogether.esmrmb.org/26m/) builds, from the
sequence to the analysis. This repository holds the contract of each stage,
every team's work, and, after the vote, the pipeline itself. The hands-on
notebooks and data are in the
[environment's repository](https://github.com/mcencini/mritogetherthon).

Everything runs in the TogetherThon's environment: set it up first, as that
repository explains.

## Stages

Every team works through the same five stages, one after the other. Each reads
files by name from the stages before it and writes files by name for the stages
after it: its contract, in its folder's README.

| Stage | Day | Reads | Writes |
|---|---|---|---|
| [`sequence`](stages/sequence) | 1 | | `sequence.seq`, `bvals`, `bvecs` |
| [`simulation`](stages/simulation) | 2 | `sequence.seq`, `bvals`, `bvecs`, a phantom | `raw.mrd` |
| [`reconstruction`](stages/reconstruction) | 2 | `raw.mrd`, `sequence.seq`, `bvals`, `bvecs` | `dwi.nii.gz` |
| [`postprocessing`](stages/postprocessing) | 3 | `dwi.nii.gz`, `bvals`, `bvecs` | `dwi.nii.gz` |
| [`analysis`](stages/analysis) | 4 | `dwi.nii.gz`, `bvals`, `bvecs` | `adc.nii.gz`, `metrics.json` |

The contracts are a draft until the speakers confirm them.

## Teams

Each team works in its own fork of this repository, in a folder for each day,
`day1` to `day4`, at its root, and sends its work as a pull request from the
fork's `main` to its own branch here, `team-NN`. The teams' pull requests never
meet. [Working as a team](https://github.com/mcencini/mritogetherthon/blob/main/docs/teams.md)
explains how a team sets it up.

The best implementation of each stage is voted by the organisers, the tutors and
the speakers, and copied to [`pipeline/`](pipeline).

## For organisers

Create the teams' branches once the teams are numbered, from the state of
`main` the TogetherThon starts from:

```bash
for n in $(seq -w 1 25); do git push origin main:refs/heads/team-$n; done
```

Teams are not given write access to this repository: they send pull requests
from their forks.

After the vote, record for each winning stage the team's fork, the fork's commit
at the time of the vote (on the team's pull request, under *Commits*), and the
folder of the stage, such as `day2/simulation`. A team keeps pushing to its fork,
so the commit pins what won. On a branch, not on `main`:

```bash
tools/promote simulation alice 3f2a9c1 day2/simulation
```

copies that folder to `pipeline/simulation/`, with a `SOURCE.md` naming the fork,
the commit and the authors, and commits it with the authors as co-authors. One
pull request of all the stages then goes to `main`.
