# inflector
Development repository for the master thesis of Tomáš Sourada at MFF CUNI.

Before running any experiments, you need to:
1) create venv and install dependencies: `python3 m venv .venv && .venv/bin/pip install --no-cache-dir -r requirements.txt`
2) download and resplit data: `bash preprocess.sh` (for running this, you already need to have installed the venv in the path .venv)




TO RUN EVALUATION (and comparison) on SIGMORPHON data:
- specify hyperparams to use in `run_on_sigmorphon.sh` (either predefined args set in `PARAMS` or specifically set)
- run it in metacentrum by submitting the job `qsub job_run_on_sigmorphon.sh` (be careful with time limit, now it is set to 20hrs, if you increase the number of epochs or another hyperparams, increase also the time limit).
- it will print comparison table on SIG22 DEV/TEST to results/sigmorphon/22/large-trainset-feats-overlap/comparison
- hopefully, it will also print a nice comparison table for SIG23 both DEV/TEST comparing all the competing systems, and SIG22 table comparing all the competing systems
- copy the results from metacentrum running `bash sync-res.sh`

git@github.com:tomsouri/inflector.git
