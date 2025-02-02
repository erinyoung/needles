# erinyoung/needles

[![GitHub Actions CI Status](https://github.com/erinyoung/needles/actions/workflows/ci.yml/badge.svg)](https://github.com/erinyoung/needles/actions/workflows/ci.yml)
[![GitHub Actions Linting Status](https://github.com/erinyoung/needles/actions/workflows/linting.yml/badge.svg)](https://github.com/erinyoung/needles/actions/workflows/linting.yml)[![Cite with Zenodo](http://img.shields.io/badge/DOI-10.5281/zenodo.XXXXXXX-1073c8?labelColor=000000)](https://doi.org/10.5281/zenodo.XXXXXXX)
[![nf-test](https://img.shields.io/badge/unit_tests-nf--test-337ab7.svg)](https://www.nf-test.com)

[![Nextflow](https://img.shields.io/badge/nextflow%20DSL2-%E2%89%A524.04.2-23aa62.svg)](https://www.nextflow.io/)
[![run with conda](http://img.shields.io/badge/run%20with-conda-3EB049?labelColor=000000&logo=anaconda)](https://docs.conda.io/en/latest/)
[![run with docker](https://img.shields.io/badge/run%20with-docker-0db7ed?labelColor=000000&logo=docker)](https://www.docker.com/)
[![run with singularity](https://img.shields.io/badge/run%20with-singularity-1d355c.svg?labelColor=000000)](https://sylabs.io/docs/)
[![Launch on Seqera Platform](https://img.shields.io/badge/Launch%20%F0%9F%9A%80-Seqera%20Platform-%234256e7)](https://cloud.seqera.io/launch?pipeline=https://github.com/erinyoung/needles)

## Introduction

**erinyoung/needles** is a bioinformatics pipeline to download or use a corresponding pre-built poppunk database to use on input fasta files.

The steps are as follows:

1. Download the poppunk database for taxid (https://www.bacpop.org/poppunk/)
2. Assign fasta files to clusters
3. Visualize (microreact is the default)

## Usage

> [!NOTE]
> If you are new to Nextflow and nf-core, please refer to [this page](https://nf-co.re/docs/usage/installation) on how to set-up Nextflow. Make sure to [test your setup](https://nf-co.re/docs/usage/introduction#how-to-run-a-pipeline) with `-profile test` before running the workflow on actual data.

First, prepare a samplesheet with your input data that looks as follows:

`samplesheet.csv`:

```csv
sample,fasta
sample1,sample1.fasta
```

Each row represents a fasta file.

### Option 1. Downloading a poppunk database

A list of poppunk databases are in json format at (assets/poppunk*db.json)(./assets/poppunk_db.json). The default taxid is `tx:1314` for *Streptococcus pyogenes\*.

Current options for taxid:

- "tx:470" : "Acinetobacter baumannii"
- "tx:520" : "Bordetella pertussis"
- "tx:197" : "Campylobacter jejuni"
- "tx:5476" : "Candida albicans"
- "tx:1351" : "Enterococcus faecalis"
- "tx:1352" : "Enterococcus faecium"
- "tx:562" : "Escherichia coli"
- "tx:727" : "Haemophilus influenzae"
- "tx:210" : "Helicobacter pylori"
- "tx:197911" : "Influenza virus"
- "tx:573" : "Klebsiella pneumoniae"
- "tx:446" : "Legionella pneumophila"
- "tx:1639" : "Listeria monocytogenes"
- "tx:36809" : "Mycobacterium abscessus"
- "tx:1773" : "Mycobacterium tuberculosis"
- "tx:485" : "Neisseria gonorrhoeae"
- "tx:487_2" : "Neisseria meningitidis" from "https://doi.org/10.12688/wellcomeopenres.14826.1"
- "tx:487" : "Neisseria meningitidis" from "https://github.com/bacpop/PopPUNK/issues/267"
- "tx:287" : "Pseudomonas aeruginosa"
- "tx:4932" : "Saccharomyces cerevisiae"
- "tx:590" : "Salmonella sp."
- "tx:1280" : "Staphylococcus aureus",
- "tx:40324" : "Stenotrophomonas maltophilia"
- "tx:1311" : "Streptococcus agalactiae"
- "tx:1334" : "Streptococcus dysgalactiae subspecies equisimilis"
- "tx:28037" : "Streptococcus mitis",
- "tx:1313" : "Streptococcus pneumoniae"
- "tx:1314" : "Streptococcus pyogenes"
- "tx:1307" : "Streptococcus suis"

Now, you can run the pipeline using:

```bash
nextflow run erinyoung/needles \
   -profile <docker/singularity/.../institute> \
   --input samplesheet.csv \
   --taxid <TAXID> \
   --outdir <OUTDIR>
```

### Option 2. Using a pre-downloaded poppunk database

```bash
nextflow run erinyoung/needles \
   -profile <docker/singularity/.../institute> \
   --input samplesheet.csv \
   --db <path/to/poppunk/database/file> \
   --outdir <OUTDIR>
```

> [!WARNING]
> Please provide pipeline parameters via the CLI or Nextflow `-params-file` option. Custom config files including those provided by the `-c` Nextflow option can be used to provide any configuration _**except for parameters**_; see [docs](https://nf-co.re/docs/usage/getting_started/configuration#custom-configuration-files).

## Credits

erinyoung/needles was originally written by Erin Young, and is mostly a wrapper for using [Poppunk](https://github.com/bacpop/PopPUNK).

[Poppunk](https://github.com/bacpop/PopPUNK) can be cited with the following paper:

> Lees JA, Harris SR, Tonkin-Hill G, Gladstone RA, Lo SW, Weiser JN, Corander J, Bentley SD, Croucher NJ. Fast and flexible bacterial genomic epidemiology with PopPUNK. Genome Research 29:304-316 (2019). doi:10.1101/gr.241455.118

This pipeline uses code and infrastructure developed and maintained by the [nf-core](https://nf-co.re) community, reused here under the [MIT license](https://github.com/nf-core/tools/blob/main/LICENSE).

> **The nf-core framework for community-curated bioinformatics pipelines.**
>
> Philip Ewels, Alexander Peltzer, Sven Fillinger, Harshil Patel, Johannes Alneberg, Andreas Wilm, Maxime Ulysse Garcia, Paolo Di Tommaso & Sven Nahnsen.
>
> _Nat Biotechnol._ 2020 Feb 13. doi: [10.1038/s41587-020-0439-x](https://dx.doi.org/10.1038/s41587-020-0439-x).
