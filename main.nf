#!/usr/bin/env nextflow
nextflow.enable.dsl=2

P1 = Channel.fromPath("${params.p1}/*.pdb").map {[it.name, it]}
P2 = Channel.fromPath("${params.p2}/*.pdb").map {[it.name, it]}

process FATCAT {
  publishDir "${params.output}", mode: 'link'

  input:
  tuple val(p1_id), path(p1_file, stageAs: 'p1/*'), val(p2_id), path(p2_file, stageAs: 'p2/*')

  output:
  path "*.aln"

  script:
  """
  set +e
  /FATCAT-dist-master/FATCATMain/FATCAT -p1 ${p1_file} -p2 ${p2_file} -o ${p1_id}_${p2_id} -m
  exit 0
  """
}

workflow {
  if (params.p2) {
    PAIRS = P1.combine(P2)
  } else {
    PAIRS = P1.toList().flatMap{it.subsequences().findAll {it.size() == 2}.collect {it.flatten()}}
  }
  FATCAT(PAIRS)
}
