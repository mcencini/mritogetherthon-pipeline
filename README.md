# MRI TogetherThon 2026: the pipeline

The open-source, end-to-end pipeline for placenta diffusion MRI that the
[MRI TogetherThon](https://mritogether.esmrmb.org/26m/) builds, from the
sequence to the analysis. This repository holds the contract of each stage
and every team's pipeline, in the team's pull request. The hands-on
notebooks and data are in the
[environment's repository](https://github.com/mcencini/mritogetherthon).

Everything runs in the TogetherThon's environment: set it up first, as that
repository explains.

## Stages

Every team builds the same five stages, one a day on days 1 to 4, and joins
them end to end on day 5. Each stage reads files by name from the stages before
it and writes files by name for the stages after it: its contract, in its
folder's README.

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

Every team's work is public, in its pull request: a team that did not build a
stage takes another team's. In the environment, `team use 12 day2/simulation`
copies that folder of team 12's pull request to `~/team`, with a `SOURCE.md`
naming its authors.

## Final submission

By the end of day 5, each team's pull request to its branch, `team-NN`, is its
final pipeline. At its root:

- **`run_pipeline.sh`** runs the whole pipeline, from the sequence to the
  analysis, in the environment, without anyone stepping in. It may read the
  organisers' material from `~/material`, and downloads anything else from a
  public, permanent address.
- **`README.md`** shows a screenshot of the result of each step, for the
  organisers and the tutors to assess.

The pull request's description has a checklist: tick each stage your team
developed itself. A stage not ticked comes from another team, or from the
organisers' material; the README says which.

## Evaluation

The organisers and the tutors assess each pipeline from its README and its
code. Runtime and peak memory, measured by running `run_pipeline.sh`, break
ties. Every team may submit; only teams that developed all five stages
themselves qualify for the prizes.

## For organisers

Create the teams' branches once the teams are numbered, from the state of
`main` the TogetherThon starts from:

```bash
for n in $(seq -w 1 50); do git push origin main:refs/heads/team-$n; done
```

Teams are not given write access to this repository: they send pull requests
from their forks.

To measure a team's pipeline: *Actions → Profile → Run workflow*, with the
number of its pull request. It runs `run_pipeline.sh` in the environment, on the
same kind of GitHub runner for every team, and reports its exit status, wall
time and peak memory in the run's summary.
