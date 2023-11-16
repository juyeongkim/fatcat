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

| `--p1` | `--output`      |
| ------ | --------------- |
| 1.pdb  | 1.pdb_2.pdb.aln |
| 2.pdb  | 1.pdb_3.pdb.aln |
| 3.pdb  | 1.pdb_4.pdb.aln |
| 4.pdb  | 2.pdb_3.pdb.aln |
|        | 2.pdb_4.pdb.aln |
|        | 3.pdb_4.pdb.aln |

```sh
nextflow run juyeongkim/fatcat -r main --p1 /your/input/dir --output /your/output/dir
```

Or if you would like to compare these files against another set of files - $M$, this will run FATCAT on all pairs - $N \times M$. For example:

| `--p1` | `--p2` | `--output`      |
| ------ | ------ | --------------- |
| 1.pdb  | x.pdb  | 1.pdb_x.pdb.aln |
| 2.pdb  | y.pdb  | 1.pdb_y.pdb.aln |
| 3.pdb  |        | 2.pdb_x.pdb.aln |
| 4.pdb  |        | 2.pdb_y.pdb.aln |
|        |        | 3.pdb_x.pdb.aln |
|        |        | 3.pdb_y.pdb.aln |
|        |        | 4.pdb_x.pdb.aln |
|        |        | 4.pdb_y.pdb.aln |

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
