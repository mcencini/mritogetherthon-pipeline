# Analysis (day 4)

Measure the images' quality and fit the diffusion parameters.

| | |
|---|---|
| **Reads** | `dwi.nii.gz`, `bvals`, `bvecs` |
| **Writes** | `adc.nii.gz`, `metrics.json`, and any further maps |

- `adc.nii.gz`: NIfTI, the voxels of `dwi.nii.gz`, in mm²/s, NaN where there
  is no fit.
- `metrics.json`: one JSON object of named numbers (or strings): the image
  quality metrics.
