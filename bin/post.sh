TEMPLATE_NAME=ubuntu-$(date +'%Y%m%d')

echo $TEMPLATE_SSH_PUBLIC_KEY > /tmp/ssh_public_key

qm set 9000 --ciuser $TEMPLATE_SSH_USER
qm set 9000 --sshkeys /tmp/ssh_public_key
qm set 9000 --name $TEMPLATE_NAME

rm /tmp/ssh_public_key
qm destroy 8999 --purge

echo "Successfully built template $TEMPLATE_NAME." | pvemailforward
