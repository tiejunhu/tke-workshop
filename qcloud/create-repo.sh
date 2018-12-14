echo "Enter repo user name and press Enter:"
user=$(sed '/^$/q')
echo "Enter repo password and press Enter:"
pass=$(sed '/^$/q')
echo "Enter repo namespace/name and press Enter:"
repo=$(sed '/^$/q')

cat <<EOF > priv-repo.sh
kubectl delete secret privccr
kubectl create secret docker-registry privccr --docker-server=https://ccr.ccs.tencentyun.com --docker-username=$user --docker-password=$pass
EOF

imageid=`sudo docker images | grep node-app | awk '{print $3}'`

cat <<EOF > push-repo.sh
sudo docker login --username $user --password $pass ccr.ccs.tencentyun.com
sudo docker tag $imageid ccr.ccs.tencentyun.com/$repo:latest
sudo docker push ccr.ccs.tencentyun.com/$repo:latest
EOF