# erinyoung/needles: Output

## Introduction

This document describes the output produced by the pipeline. Most of the plots are intended to be used with [microreact](https://microreact.org/), for which more information is available in [poppunk's documentation](https://poppunk.readthedocs.io/en/latest/visualisation.html#microreact).

The directories listed below will be created in the results directory after the pipeline has finished. All paths are relative to the top-level results directory.

## Pipeline overview

The pipeline is built using [Nextflow](https://www.nextflow.io/) and [PopPUNK]():

```bash
needles
├── clusters
│   ├── clusters_clusters.csv
│   ├── clusters.dists.npy
│   ├── clusters.dists.pkl
│   ├── clusters.h5
│   └── clusters_unword_clusters.csv
├── Haemophilus_influenzae_v2_refs
│   ├── Haemophilus_influenzae_v2_refs_clusters.csv
│   ├── Haemophilus_influenzae_v2_refs_dbscan.png
│   ├── Haemophilus_influenzae_v2_refs_distanceDistribution.png
│   ├── Haemophilus_influenzae_v2_refs.dists.npy
│   ├── Haemophilus_influenzae_v2_refs.dists.pkl
│   ├── Haemophilus_influenzae_v2_refs_fit.npz
│   ├── Haemophilus_influenzae_v2_refs_fit.pkl
│   ├── Haemophilus_influenzae_v2_refs.h5
│   ├── Haemophilus_influenzae_v2_refs_refined_fit.png
│   ├── Haemophilus_influenzae_v2_refs.refs
│   ├── Haemophilus_influenzae_v2_refs.refs_graph.gt
│   └── Haemophilus_influenzae_v2_refs_unword_clusters.csv
├── pipeline_info
│   ├── execution_report_2024-11-05_12-15-31.html
│   ├── execution_timeline_2024-11-05_12-15-31.html
│   ├── execution_trace_2024-11-05_12-15-31.txt
│   ├── params_2024-11-05_12-15-32.json
│   ├── pipeline_dag_2024-11-05_12-15-31.html
│   └── pipeline_software_mqc_versions.yml
└── viz
    ├── viz_core_NJ.nwk
    ├── viz.microreact
    ├── viz_microreact_clusters.csv
    └── viz_perplexity20.0_accessory_mandrake.dot
```

### Downloaded database

- `db`
  - this directory is `Haemophilus_influenzae_v2_refs` in the example, but will be the extracted database [downloaded for poppunk]()

### Assign clusters

- `clusters`
  - results from [poppunk assign](https://poppunk.readthedocs.io/en/latest/query_assignment.html)

### Visualize

- `viz`
  - results from [poppunk_visualize](https://poppunk.readthedocs.io/en/latest/query_assignment.html)
  - defaults are for `--microreact`, but that can be updated using a config file and changing `${task.args}`.

### Pipeline information

- `pipeline_info/`
  - Reports generated by Nextflow: `execution_report.html`, `execution_timeline.html`, `execution_trace.txt` and `pipeline_dag.dot`/`pipeline_dag.svg`.
  - Reports generated by the pipeline: `pipeline_report.html`, `pipeline_report.txt` and `software_versions.yml`. The `pipeline_report*` files will only be present if the `--email` / `--email_on_fail` parameter's are used when running the pipeline.
  - Reformatted samplesheet files used as input to the pipeline: `samplesheet.valid.csv`.
  - Parameters used by the pipeline run: `params.json`.

[Nextflow](https://www.nextflow.io/docs/latest/tracing.html) provides excellent functionality for generating various reports relevant to the running and execution of the pipeline. This will allow you to troubleshoot errors with the running of the pipeline, and also provide you with other information such as launch commands, run times and resource usage.
