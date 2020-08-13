# Code Template for HorsePower

## Experiment 1: TPC-H Queries

Note: Find a clearn folder to run the following code

Step 1: Download HorsePower

    git clone git@github.com:Sable/HorsePower.git

Step 2: Set up environment

    cd HorsePower && git checkout improve-code && source ./setup_env.sh

Step 3: Deplpy library and data

    ./deploy.sh

Jump back to the parent folder

    cd ..

Step 4: Download this repo

    git clone git@github.com:wukefe/horse-code-template.git code-template

Step 5: Generate optimized code and run

    cd code-template && ./make.sh code opt && ./run-all.sh 1

Step 6: Fetch results from the log folder, e.g. `log/run1`

    ./run-all.sh 1 report 1      # T1
    ./run-all.sh 1 report 2      # T2
    ./run-all.sh 1 report 4      # T4
    ./run-all.sh 1 report 8      # T8
    ./run-all.sh 1 report 16     # T16




