echo "Paste Token and press Enter:"
token=$(sed '/^$/q')
echo "Paste Certificate and press Enter:"
cert=$(sed '/^$/q')
echo "$cert" > ca.crt
echo "Paster Server URL and press Enter:"
server=$(sed '/^$/q')

cat <<EOF > config.sh
kubectl config set-credentials qcloud-admin --username=admin --password=$token
kubectl config set-cluster qcloud-cluster --server=$server --certificate-authority=$PWD/ca.crt
kubectl config set-context qcloud-system --cluster=qcloud-cluster --user=qcloud-admin
kubectl config use-context qcloud-system
EOF