cluster_create :
	[[ -d  "/home/ci/mk-performance-tests" ]] || cd /home/ci;git clone https://gitlab.cee.redhat.com/mk-bin-packing/mk-performance-tests.git;cd mk-performance-tests/;git submodule update --init --recursive --force ;git submodule update --remote --merge;sed -i 's/--aws-access-key/--count  9 --aws-access-key/' /home/ci/mk-performance-tests/scripts/kas_osd_provision.sh
	timeout 90m /home/ci/mk-performance-tests/scripts/kas_osd_provision.sh  

kafka_create : kafka_delete
	cp /home/ci/mk-performance-tests/kafka-config ~/.kube/config
	python3 -u /opt/tools/scripts/ocm.py "oc_login" -c "$${KAFKA_CLUSTER_NAME}"
	timeout 15m /opt/tools/scripts/kas_installer.sh

kafka_delete :
	cp /home/ci/mk-performance-tests/kafka-config ~/.kube/config
	python3 -u /opt/tools/scripts/ocm.py "oc_login" -c "$${KAFKA_CLUSTER_NAME}"
	if [  -f /opt/tools/kas-installer/managed_kafka.sh ] && [ ! -z `cd '/opt/tools/kas-installer'; ./managed_kafka.sh --list | jq -r .items[0].id` ] ;then cd '/opt/tools/kas-installer'; ./managed_kafka.sh --delete `cd '/opt/tools/kas-installer'; ./managed_kafka.sh --list | jq -r .items[0].id`; while [ `cd '/opt/tools/kas-installer'; ./managed_kafka.sh --list | jq -r .items[0].id` !=  null ]; do sleep 2;done;cd /opt/tools/kas-installer;./uninstall.sh || true; fi

enable_std :
	sed -e '/^#/! {/KAS_FLEETSHARD_OPERATOR_SUBSCRIPTION_CONFIG/ s/^/#/}' /opt/tools/scripts/kas_fleet_manager_params.sh
	sed -e '/^#/! {/REGISTERED_USERS_PER_ORGANISATION/ s/^/#/}' /opt/tools/scripts/kas_fleet_manager_params.sh

setup_omb :
	timeout 10m /home/ci/mk-performance-tests/scripts/kas_test_preparation.sh

cluster_delete :
	/opt/tools/scripts/osd-provision.sh  --delete  -n $${KAFKA_CLUSTER_NAME}  --cloud-token-file /home/ci/mk-performance-tests/token-file
	cd /opt/tools/benchmark/driver-kafka/deploy/hdd-deployment/aws; terraform destroy --auto-approve	

.PHONY : cluster_create kafka_create enable_std setup_omb cluster_delete
