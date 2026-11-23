# Motion correction and post-processing (day 3)

Correct the reconstructed images for motion, and denoise and post-process
them. The work is on images: no correction of k-space is needed.

| | |
|---|---|
| **Reads** | `dwi.nii.gz`, `bvals`, `bvecs` |
| **Writes** | `dwi.nii.gz`, corrected, in the format the reconstruction stage's contract describes |

A correction that also rotates the diffusion directions writes `bvecs` too:
the stages after it then read the rotated ones.
