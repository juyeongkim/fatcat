#!/usr/bin/env nextflow
nextflow.enable.dsl=2

P1 = Channel.fromPath("${params.p1}/*.pdb")
if (params.p2) {
  P2 = Channel.fromPath("${params.p2}/*.pdb")
  PAIRS = P1.combine(P2)
} else {
  PAIRS = P1.combine(P1).filter{it[0] != it[1]}.map{it.sort()}.unique()
}

process FATCAT {
  publishDir "${params.output}", mode: 'copy'

  input:
  tuple path(p1, stageAs: 'p1/*'), path(p2, stageAs: 'p2/*')

  output:
  path "*.aln"

  script:
  """
  set +e
  /FATCAT-dist-master/FATCATMain/FATCAT -p1 ${p1} -p2 ${p2} -o ${p1.simpleName}__${p2.simpleName} -m
  exit 0
  """
}

workflow {
  FATCAT(PAIRS)
}
