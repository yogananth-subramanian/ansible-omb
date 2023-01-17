# ansible-omb
Playbook Automates running OMB using RHOSAK with and without HPO

To deploy RHOSAK and run OMB benchmark
```
ansible-playbook --ask-vault-pass  kafka.yml
```
Playbook will use `files/input.csv` as parameters for running OMB.
`files/secrets-vars.yaml` contains credentials related to AWS and OCM
