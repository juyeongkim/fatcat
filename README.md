# FATCAT Nextflow Pipeline

A Nextflow pipeline based on [FATCAT](https://github.com/GodzikLab/FATCAT-dist).

## Running Nextflow

### Install Nextflow

Follow this to install Nextflow: https://www.nextflow.io/docs/latest/getstarted.html

### Pull Nextflow pipeline

```sh
nextflow pull juyeongkim/fatcat
```

Downloaded pipeline are stored in the folder `$HOME/.nextflow/assets`.

### Run pipeline

#### A) Locally

```sh
cd /where/you/want/to/store/logs/and/intermediate/files
nextflow pull juyeongkim/fatcat
```

If your input directory has $N$ number of pdb files, this will run FATCAT on all combinations - ${N \choose 2}$. For example:

| `--p1` | `--output` |
| ------ | ---------- |
| 1.pdb  | 1__2.aln   |
| 2.pdb  | 1__3.aln   |
| 3.pdb  | 1__4.aln   |
| 4.pdb  | 2__3.aln   |
|        | 2__4.aln   |
|        | 3__4.aln   |

```sh
nextflow run juyeongkim/fatcat -r main --p1 /your/input/dir --output /your/output/dir
```

Or if you would like to compare these files against another set of files - $M$, this will run FATCAT on all pairs - $N \times M$. For example:

| `--p1` | `--p2` | `--output` |
| ------ | ------ | ---------- |
| 1.pdb  | x.pdb  | 1__x.aln   |
| 2.pdb  | y.pdb  | 1__y.aln   |
| 3.pdb  |        | 2__x.aln   |
| 4.pdb  |        | 2__y.aln   |
|        |        | 3__x.aln   |
|        |        | 3__y.aln   |
|        |        | 4__x.aln   |
|        |        | 4__y.aln   |

```sh
nextflow run juyeongkim/fatcat -r main --p1 /your/input/dir --p2 /your/other/input/dir --output /your/output/dir
```


#### B) Cluster

Alternatively, you can run the pipeline on HPC with slurm. First, load the environment modules if they are available. If not, please follow the Apptainer and Nextflow documentation to install them first.

```sh
module load Apptainer
module load Nextflow
cd /where/you/want/to/store/logs/and/intermediate/files
nextflow pull juyeongkim/fatcat
nextflow run juyeongkim/fatcat -r main -profile cluster --p1 /your/input/dir --output /your/output/dir
nextflow run juyeongkim/fatcat -r main -profile cluster --p1 /your/input/dir --p2 /your/other/input/dir --output /your/output/dir
```
