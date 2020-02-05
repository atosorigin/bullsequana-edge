#!/bin/sh

echo "checking ansible prerequisite"
ansible_version=$(ansible --version|grep "ansible python module location")
if [ -z "$ansible_version" ]
then
  echo -e "\033[31mansible is NOT installed\033[0m"
  exit -1
fi

if [ -z $ANSIBLE_CONFIG ]
then
  export ANSIBLE_CONFIG=/etc/ansible/ansible.cfg
fi
echo "your ansible configuration file is $ANSIBLE_CONFIG"

if [ -z $ANSIBLE_INVENTORY ]
then
  export ANSIBLE_INVENTORY=/etc/ansible/hosts #default
fi
echo "your ansible inventory hosts file is $ANSIBLE_INVENTORY"

add_lines()
{
  echo -e "\033[32m---------------------------------------------------------------------------------------\033[0m"
  echo -e "\033[31mPlease change yourself the following configuration in your $ANSIBLE_CONFIG:\033[0m"
  echo "# MANDATORY: for atos module plugin to work, uncomment line at the begining of thefile:"
  echo -e "\033[31mlibrary = /usr/share/ansible/plugins/modules\033[0m"
  echo "# MANDATORY: for atos module utils to work, uncomment line at the begining of thefile:"
  echo -e "\033[31mmodule_utils = /usr/share/ansible/plugins/module_utils\033[0m"
  echo "# OPTION for a better Atos sensors / log / yaml rendering"
  echo -e "stdout_callback = \033[32mmismunixy\033[0m"
  echo "# OPTION if you wish a more human-readable rendering"
  echo "See https://docs.ansible.com/ansible/2.5/plugins/callback.html#managing-adhoc"
  echo -e "bin_ansible_callbacks = \033[32mTrue\033[0m"
  echo "# to enable Atos python3 playbboks"
  echo -e "ansible_python_interpreter = \033[32m/usr/bin/python3\033[0m"
  echo "# if target certificates are self-signed"
  echo "host_key_checking = False"
  echo -e "\033[32m----------------------------------------------------------------------------------------\033[0m"
}

while true; do
    read -p "Do you wish to overwrite your $ANSIBLE_CONFIG file ? y yes / n no: " yn
    case $yn in
        [Yy]* ) cp ansible/inventory/ansible.cfg $ANSIBLE_CONFIG ; break;;
        [Nn]* ) add_lines; break;;
        * ) echo "Please answer yes or no.";;
    esac
done

# add ANSIBLE_PASSWORDS=<your install dir>/ansible/vars/passwords.yml to hosts file
# add ANSIBLE_EXTERNAL_VARS=<your install dir>/ansible/vars/external_vars.yml to hosts file
pwd=$(pwd)
export ANSIBLE_PASSWORDS=$pwd/ansible/vars/passwords.yml
export ANSIBLE_EXTERNAL_VARS=$pwd/ansible/vars/external_vars.yml

# delete old ANSIBLE_PASSWORDS path
grep -q ANSIBLE_PASSWORDS= $ANSIBLE_INVENTORY && sed -i.bak '/ANSIBLE_PASSWORDS=.*/d' $ANSIBLE_INVENTORY
# add the new ANSIBLE_PASSWORDS path
sed -i "/all:vars/a ANSIBLE_PASSWORDS=$ANSIBLE_PASSWORDS" $ANSIBLE_INVENTORY
echo "the following line was added in your $ANSIBLE_INVENTORY:"
echo -e "\033[32mANSIBLE_PASSWORDS=$ANSIBLE_PASSWORDS\033[0m"

# delete old ANSIBLE_EXTERNAL_VARS path
grep -q ANSIBLE_EXTERNAL_VARS= $ANSIBLE_INVENTORY && sed -i.bak '/ANSIBLE_EXTERNAL_VARS=.*/d' $ANSIBLE_INVENTORY
# add the new ANSIBLE_EXTERNAL_VARS path
sed -i "/all:vars/a ANSIBLE_EXTERNAL_VARS=$ANSIBLE_EXTERNAL_VARS" $ANSIBLE_INVENTORY
echo "the following line was added in your $ANSIBLE_INVENTORY :"
echo -e "\033[32mANSIBLE_EXTERNAL_VARS=$ANSIBLE_EXTERNAL_VARS\033[0m"

if [ ! -d "/usr/share/ansible/plugins/callback" ]
then
  mkdir /usr/share/ansible/plugins/callback
fi
cp -r ansible/plugins/callback/ansible_stdout_compact_logger /usr/share/ansible/plugins/callback/ansible_stdout_compact_logger

# ansible plugin inventory is copied in default directory /usr/lib/python<major>.<minor>/site-packages/ansible/modules
# you can adapt it if you have another ansible plugin inventory directory

# ansible plugin module is copied in default shared directory /usr/share/ansible/plugins/modules/
# you can adapt it if you have another ansible plugin module directory

if [ ! -d "/usr/share/ansible" ]
then
  mkdir /usr/share/ansible
fi

if [ ! -d "/usr/share/ansible/plugins" ]
then
  mkdir /usr/share/ansible/plugins
fi

if [ ! -d "/usr/share/ansible/plugins/modules" ]
then
  mkdir /usr/share/ansible/plugins/modules
fi

if [ ! -d "/usr/share/ansible/plugins/module_utils" ]
then
  mkdir /usr/share/ansible/plugins/module_utils
fi

cp ansible/plugins/modules/remote_management/openbmc/atos_openbmc.py        /usr/share/ansible/plugins/modules/atos_openbmc.py
cp ansible/plugins/modules/remote_management/openbmc/atos_openbmc_utils.py  /usr/share/ansible/plugins/module_utils/atos_openbmc_utils.py
cp ansible/plugins/modules/remote_management/openbmc/__init__.py            /usr/share/ansible/plugins/modules/__init__.py
