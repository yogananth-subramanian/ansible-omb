# ansible-omb
Playbook Automates running OMB using RHOSAK with and without HPO

To deploy RHOSAK and run OMB benchmark
```
VAULT_PASS=<vault password> ansible-playbook kafka.yml
```
>The above command also  deletes the both the Kafka cluster and OMB environment after OMB benchmark is done.

Playbook will by default use `files/dev-vars.yaml` for setting up AWS Kafka cluster, OMB environment and `files/input.csv` as input for running OMB.
`files/secrets-vars.yaml`  contains encrypted credentials related to AWS and OCM.   
`files/requried_var.yaml` contains the list of all the required variables for running the playbook. The secret variables are prefixed with `VAULT_`.

To reuse the playbook, recreate `files/secrets-vars.yaml` with all variables prefixed with `VAULT_` and encrypt the file using ansilbe-valut.
Run the play book with `VAULT_PASS` environment variable set to ansible-vault password used above to encrypt secrets-vars.yaml.

## HPO
To run OMB benchmark with HPO execute playbook with variable  HPO set to true
```
VAULT_PASS=<vault password> ansible-playbook kafka.yml -e hpo=true
```

## Stages
Playbook can be executed in stages.
To just install Kafka and OMB environment and execute benchmark, run:
```
ansible-playbook  kafka.yml --skip-tags cleanup 
```
To clean up the setup run:
```
ansible-playbook  kafka.yml -t cleanup
```
To create kafka cluster run:
```
ansible-playbook  kafka.yml -t kafka_create
```
To create OMB cluster run:
```
ansible-playbook  kafka.yml -t omb_create
```
To install OMB or OMB along with HPO on previously create cluster run:
```
ansible-playbook  kafka.yml -t omb_run
```
