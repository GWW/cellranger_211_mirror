#
# Copyright (c) 2017 10x Genomics, Inc. All rights reserved.
#
# Environment setup for package cellranger-2.1.1.
# Source this file before running.
#

# Determine path to this script; resolve symlinks
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do
    DIR="$( cd -P "$( dirname "$SOURCE" )" > /dev/null && pwd )"
    SOURCE="$(readlink "$SOURCE")"
    [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done
DIR="$( cd -P "$( dirname "$SOURCE" )" > /dev/null && pwd )"

#
# Source user's own environment first.
#
# Only source .bashrc if we're being sourced from shell10x script.
# Otherwise, we could end up in an infinite loop if user is
# sourcing this file from their .bashrc.
# Note: .bash_profile is for login shells only.
if [ ! -z $_RUN10X ] && [ -e ~/.bashrc ]; then
    source ~/.bashrc
fi

#
# Modify the prompt to indicate user is in 10X environment.
#
if [ ! -z $_10X_MODPROMPT ]; then
    ORIG_PROMPT=$PS1
    PREFIX=$TENX_PRODUCT
    if [ ! -z $_10XDEV_BRANCH_PROMPT ]; then
        PREFIX="10X:\`pushd $(echo $MROPATH | cut -d : -f1) > /dev/null;git rev-parse --abbrev-ref HEAD;popd > /dev/null\`"
    fi
    export PS1="\[\e[0;34m\]$PREFIX\[\e[m\]>$ORIG_PROMPT"
fi

#
# Set aside environment variables if they may conflict with 10X environment
#

if [ -z "$_TENX_LD_LIBRARY_PATH" ]; then
    export _TENX_LD_LIBRARY_PATH="$LD_LIBRARY_PATH"
    export LD_LIBRARY_PATH=""
fi


#
# Unset environment variables if they may conflict with 10X environment
#

if [ ! -z "$PYTHONPATH" ]; then
    unset PYTHONPATH
fi


#
# Add module binary paths to PATH
#

if [ -z "$PATH" ]; then
    export PATH="$DIR/STAR/5dda596"
else
    export PATH="$DIR/STAR/5dda596:$PATH"
fi
export PATH="$DIR/martian-cs/2.3.2/bin:$PATH"
export PATH="$DIR/lz4/v1.8.0:$PATH"
export PATH="$DIR/cellranger-cs/2.1.1/bin:$PATH"
export PATH="$DIR/cellranger-cs/2.1.1/tenkit/bin:$PATH"
export PATH="$DIR/cellranger-cs/2.1.1/tenkit/lib/bin:$PATH"
export PATH="$DIR/cellranger-cs/2.1.1/lib/bin:$PATH"
export PATH="$DIR/miniconda-cr-cs/4.3.21-miniconda-cr-cs-c9/bin:$PATH"
export PATH="$DIR/cellranger-tiny-ref/1.2.0:$PATH"
export PATH="$DIR/cellranger-tiny-fastq/1.2.0:$PATH"
export PATH="$DIR/samtools_new/1.6:$PATH"


#
# Module-specific env vars
#
# martian-cs

if [ -z "$PYTHONPATH" ]; then
    export PYTHONPATH="$DIR/martian-cs/2.3.2/adapters/python"
else
    export PYTHONPATH="$DIR/martian-cs/2.3.2/adapters/python:$PYTHONPATH"
fi
# cellranger-cs
export MROFLAGS="--vdrmode=rolling"
export LC_ALL="C"
export MROPATH="$DIR/cellranger-cs/2.1.1/mro"

if [ -z "$MROPATH" ]; then
    export MROPATH="$DIR/cellranger-cs/2.1.1/tenkit/mro"
else
    export MROPATH="$DIR/cellranger-cs/2.1.1/tenkit/mro:$MROPATH"
fi
export PYTHONPATH="$DIR/cellranger-cs/2.1.1/lib/python:$PYTHONPATH"
export PYTHONPATH="$DIR/cellranger-cs/2.1.1/tenkit/lib/python:$PYTHONPATH"
export PYTHONUSERBASE="$DIR/cellranger-cs/2.1.1/lib"

