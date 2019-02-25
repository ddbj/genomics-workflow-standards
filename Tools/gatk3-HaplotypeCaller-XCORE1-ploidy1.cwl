#!/usr/bin/env cwl-runner

class: CommandLineTool
id: gatk3-HaplotypeCaller-local-3.7.0
label: gatk3-HaplotypeCaller-local-3.7.0
cwlVersion: v1.0

$namespaces:
  edam: 'http://edamontology.org/'

hints:
  - class: DockerRequirement
    dockerPull: 'broadinstitute/gatk3:3.7-0'
    
requirements:
  - class: ShellCommandRequirement
  - class: ResourceRequirement
    ramMin: 6300

baseCommand: [ ln ]

inputs: 
  - id: in_bam
    type: File
    format: edam:format_2572
    inputBinding:
      prefix: -s
      position: 13
    doc: input BAM alignment file
  - id: in_bai
    type: File
    inputBinding: 
      prefix: -s
      position: 17
    doc: index for input BAM alignment file
  - id: nthreads
    type: int
    inputBinding:
      prefix: -nct
      position: 31
    doc: number of cpu cores to be used
  - id: reference
    type: File
    format: edam:format_1929
    inputBinding:
      position: 1
      prefix: -s
    doc: FastA file for reference genome
  - id: reference_fai
    type: File
    inputBinding:
      position: 5
      prefix: -s
    doc: FAI index file for reference genome
  - id: reference_dict
    type: File
    inputBinding:
      position: 9
      prefix: -s
    doc: DICT index file for reference genome
  - id: outprefix
    type: string
    
outputs:
  - id: vcf
    type: File
    format: edam:format_3016
    outputBinding: 
      glob: $(inputs.outprefix).chrX_core1.g.vcf.gz
  - id: vcf_tbi
    type: File
    outputBinding:
      glob: $(inputs.outprefix).chrX_core1.g.vcf.gz.tbi
  - id: log
    type: stderr

stderr: $(inputs.outprefix).chrX_core1.g.vcf.gz.log

arguments:
  - position: 2
    valueFrom: "reference.fa"
  - position: 3
    valueFrom: "&&"
  - position: 4
    valueFrom: "ln"
  - position: 6
    valueFrom: "reference.fa.fai"
  - position: 7
    valueFrom: "&&"
  - position: 8
    valueFrom: "ln"
  - position: 10
    valueFrom: "reference.dict"
  - position: 11
    valueFrom: "&&"
  - position: 12
    valueFrom: "ln"
  - position: 14
    valueFrom: "reads.bam"
  - position: 15
    valueFrom: "&&"
  - position: 16
    valueFrom: "ln"
  - position: 18
    valueFrom: "reads.bam.bai"
  - position: 19
    valueFrom: "&&"
  - position: 20
    valueFrom: "mkdir"
  - position: 21
    prefix: -p
    valueFrom: "temp"
  - position: 22
    valueFrom: "&&"
  - position: 23
    valueFrom: "export"
  - position: 24
    prefix: "JAVA_TOOL_OPTIONS="
    valueFrom: "temp"
  - position: 25
    valueFrom: "&&"
  - position: 26
    valueFrom: "java"
  - position: 27
    valueFrom: "-Xmx98G"
  - position: 28
    valueFrom: "-jar"
  - position: 29
    valueFrom: "/usr/GenomeAnalysisTK.jar"
  - position: 30
    prefix: -T
    valueFrom: "HaplotypeCaller"
  - position: 32
    prefix: -R
    valueFrom: "reference.fa"
  - position: 33
    prefix: -I
    valueFrom: "reads.bam"
  - position: 34
    prefix: -L
    valueFrom: "X:2699521-88456801"
  - position: 35
    prefix: -ploidy
    valueFrom: "1"
  - position: 36
    prefix: -o
    valueFrom: $(inputs.outprefix).chrX_core1.g.vcf.gz
  - position: 37
    prefix: --emitRefConfidence
    valueFrom: "GVCF"
  - position: 38
    valueFrom: "&&"
  - position: 39
    valueFrom: "rm"
  - position: 40
    valueFrom: "reference.fa"
  - position: 41
    valueFrom: "reference.fa.fai"
  - position: 42
    valueFrom: "reference.dict"
  - position: 43
    valueFrom: "reads.bam"
  - position: 44
    valueFrom: "reads.bam.bai"
  - position: 45
    valueFrom: "&&"
  - position: 46
    valueFrom: "rm"
  - position: 47
    prefix: -rf
    valueFrom: "temp"


