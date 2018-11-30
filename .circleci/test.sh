#!/bin/bash

set -e

# setup
export PATH=${PATH}:${HOME}/miniconda3/bin
source activate grabseqs-test

# basic tests
python bin/grabseqs -v
python bin/grabseqs -h

# more thorough tests
mkdir -p $HOME/tmp_test
## test listing
if [ `python bin/grabseqs sra -l SRP057027 | wc -l` -ne 369 ] ; then
    exit 1
fi
echo "  sample listing test passed"
## test metadata download
python bin/grabseqs sra -m -l -o $HOME/tmp_test/test_metadata/ SRP057027 > /dev/null
if [ `cat $HOME/tmp_test/test_metadata/SRP057027.tsv | wc -l` -ne 371 ] ; then
    exit 1
fi
echo "  metadata test passed"
# test conda install
conda install -c louiejtaylor grabseqs

# cleanup
rm -r $HOME/tmp_test
