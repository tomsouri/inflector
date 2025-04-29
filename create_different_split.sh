#!/bin/bash

#for i in 1 2; do
for i in 1; do
  for split in "lemma-disjoint-uniform" "lemma-disjoint-weighted"; do
    for ratio in "lemmata-by-counts" "lemmata-ignoring-counts"; do
#  for split in "lemma-disjoint-uniform"; do
#    for ratio in "lemmata-by-counts"; do
      dir="run${i}_${split}_split_${ratio}_ratio"
      #dir="${split}_split_${ratio}_ratio"
      datadir=data/experimenting/$dir/
#      for corpus in UD_Basque-BDT UD_Breton-KEB UD_Czech-PDT UD_English-EWT UD_Spanish-AnCora; do
#        .venv/bin/python3 preprocess.py --corpus $corpus --datadir $datadir --split_type $split --split_ratio_type $ratio
#      done
      .venv/bin/python3 compute_statistics.py --datadir $datadir > data/experimenting/stats/$dir.txt
      #.venv/bin/python3 compute_statistics.py --datadir $datadir --corpora UD_Spanish-AnCora > ${datadir}/stats.txt
    done
  done
done