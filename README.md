# MRI TogetherThon 2026: the pipeline

The open-source, end-to-end pipeline for placenta diffusion MRI that the
[MRI TogetherThon](https://mritogether.esmrmb.org/26m/) builds, from the
sequence to the analysis. This repository holds every team's pipeline, in the
team's pull request. The hands-on notebooks and data are in the
[environment's repository](https://github.com/mcencini/mritogetherthon).

Everything runs in the TogetherThon's environment: set it up first, as that
repository explains.

## Stages

Every team builds the same five stages, one a day on days 1 to 4, and joins
them end to end on day 5.

| Day | Stage | What it produces |
|---|---|---|
| 1 | [`sequence`](stages/sequence) | A diffusion sequence for the placenta |
| 2 | [`simulation`](stages/simulation), [`reconstruction`](stages/reconstruction) | Simulated data, and the images reconstructed from it |
| 3 | [`postprocessing`](stages/postprocessing) | Images corrected for motion and denoised |
| 4 | [`analysis`](stages/analysis) | Image quality metrics and diffusion maps |
| 5 | Assembly | The whole pipeline, run end to end |

The files each stage reads and writes are still being settled with the
speakers: each stage's folder has the current draft.

## Teams

Each team works in its own fork of this repository and sends its work as a
pull request from the fork's `main` to its own branch here, `team-NN`.
[Working as a team](https://github.com/mcencini/mritogetherthon/blob/main/docs/teams.md)
explains how a team sets it up, and how `submit` sends its work at the end of
each session.

Every team's work is public, in its pull request: a team that did not build a
stage can take another team's, with `team use`.

## Final submission

By the end of day 5, each team's pull request is its final pipeline. What it
must contain, and how the organisers and the tutors will assess it, will be
confirmed during the week. Every team may submit; only teams that developed
all five stages themselves qualify for the prizes.

## For organisers

Create the teams' branches once the teams are numbered, from the state of
`main` the TogetherThon starts from:

```bash
for n in $(seq -w 1 50); do git push origin main:refs/heads/team-$n; done
```

Teams are not given write access to this repository: they send pull requests
from their forks.

To measure a team's pipeline: *Actions → Profile → Run workflow*, with the
number of its pull request. It runs the team's `run_pipeline.sh` in the
environment, on the same kind of GitHub runner for every team, and reports its
exit status, wall time and peak memory in the run's summary.
