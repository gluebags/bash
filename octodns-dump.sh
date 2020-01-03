
#!/bin/bash
subscriptions=(az account list --query '[].[id]' -o tsv)

for subscription in "${subscriptions[@]}";
do
        az account set --subscription $subscription
zones=(az network dns zone list --query "[].{resource:resourceGroup, name:name}" -o tsv)
for zone in "${zones[@]}";
do
        (octodns-dump --config-file /opt/dns/config/production.yaml --output-dir /opt/dns/zones --split dev.website.com azuredns)
done
done
