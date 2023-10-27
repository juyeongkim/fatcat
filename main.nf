#!/usr/bin/env nextflow
nextflow.enable.dsl=2

SOURCE = Channel.fromPath("${params.source}/*.pdb").map {[it.name, it]}
TARGET = Channel.fromPath("${params.target}/*.pdb").map {[it.name, it]}

process FATCAT {
  publishDir "${params.output}", mode: 'link'

  input:
  tuple val(source_id), path(source_file, stageAs: 'source/*'), val(target_id), path(target_file, stageAs: 'target/*')

  output:
  path "*.aln"

  script:
  """
  set +e
  /FATCAT-dist-master/FATCATMain/FATCAT -p1 ${source_file} -p2 ${target_file} -o ${source_id}_${target_id} -m
  exit 0
  """
}

workflow {
  FATCAT(SOURCE.combine(TARGET))
}
