# dp-sourada-dev
Development repository for the master thesis of Tomáš Sourada at MFF CUNI.

To prepare venv and data and run a toy training, run:
`bash init.sh`

This:
1) creates the venv and installs dependencies, 
2) downloads and re-splits the data, 
3) prints the re-split statistics to a file `data-stats.<datetime>.txt` (this should be the same as the provided `stats.txt`)
4) runs a toy example of monolingual and multilingual training on 2 languages

For actually running some experiments, uncomment the appropriate lines in `example_run.sh` (bottom of the file) and run it (you need to have the venv and data prepared first).

To inspect what is being done, look into `example_run.sh`. 


git@github.com:tomsouri/dp-sourada-dev.git







## evaluation on sigmorphon data:
- specify hyperparams to use in `run_on_sigmorphon.sh` (either predefined args set in `PARAMS` or specifically set)
- run it in metacentrum by submitting the job `qsub job_run_on_sigmorphon.sh` (be careful with time limit, now it is set to 20hrs, if you increase the number of epochs or another hyperparams, increase also the time limit).
- it will print comparison table on SIG22 DEV/TEST to results/sigmorphon/22/large-trainset-feats-overlap/comparison
- hopefully, it will also print a nice comparison table for SIG23 both DEV/TEST comparing all the competing systems, and SIG22 table comparing all the competing systems
- copy the results from metacentrum running `bash sync-res.sh`
