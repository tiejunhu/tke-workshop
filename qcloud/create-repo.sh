echo "Enter repo user name and press Enter:"
user=$(sed '/^$/q')
echo "Enter repo password and press Enter:"
pass=$(sed '/^$/q')
echo "Enter repo namespace and press Enter:"
namespace=$(sed '/^$/q')
echo "Enter repo name and press Enter:"
repo=$(sed '/^$/q')

cat <<EOF > priv-repo.sh
kubectl delete secret privccr
kubectl create secret docker-registry privccr --docker-server=https://ccr.ccs.tencentyun.com --docker-username=$user --docker-password=$pass
EOF

imageid=`sudo docker images | grep node-app | awk '{print $3}'`

cat <<EOF > push-repo.sh
sudo docker login --username $user --password $pass ccr.ccs.tencentyun.com
sudo docker tag $imageid ccr.ccs.tencentyun.com/$namespace/$repo:latest
sudo docker push ccr.ccs.tencentyun.com/$namespace/$repo:latest
EOF

sed -i "s/tiejunhu/$namespace/g" deployment.yaml
sed -i "s/tiejunhu/$namespace/g" deployment-nfs.yaml
sed -i "s/tiejunhu/$namespace/g" deployment-cis.yaml
sed -i "s/node-app-1/$repo/g" deployment.yaml
sed -i "s/node-app-1/$repo/g" deployment-nfs.yaml
sed -i "s/node-app-1/$repo/g" deployment-cis.yaml