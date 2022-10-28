#!/bin/bash
pod_name=$(kubectl get po -n nextcloud -l app.kubernetes.io/component=app --no-headers -o custom-columns=NAME:metadata.name)

echo "Starting Rails console in pod:" $pod_name

kubectl exec -it $pod_name -n nextcloud -- bash -c "chsh -s /bin/bash www-data | su - www-data"
kubectl exec -it $pod_name -n nextcloud -- bash -c "echo 'php -d memory_limit=512M /var/www/html/occ db:add-missing-indices' | su - www-data"
kubectl exec -it $pod_name -n nextcloud -- bash -c "echo 'php -d memory_limit=512M /var/www/html/occ --no-interaction db:convert-filecache-bigint' | su - www-data"
kubectl exec -it $pod_name -n nextcloud -- bash -c "echo 'php -d memory_limit=512M /var/www/html/occ background:cron' | su - www-data"
kubectl exec -it $pod_name -n nextcloud -- bash -c "echo 'php -d memory_limit=512M /var/www/html/occ app:install richdocuments' | su - www-data"
kubectl exec -it $pod_name -n nextcloud -- bash -c "echo 'php -d memory_limit=512M /var/www/html/occ app:update --all' | su - www-data"