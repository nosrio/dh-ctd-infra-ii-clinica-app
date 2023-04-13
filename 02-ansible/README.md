# Ansible

En este ejemplo toda la lógica para instalar java, instalar maven y configurar el servidor para tener la app funcionando se llevo a una playbook de ansible.

Esta playbook usa 2 roles de la comunidad para instalar [java](https://github.com/geerlingguy/ansible-role-java) y [maven](https://github.com/gantsign/ansible-role-maven).

Finalmente, implementa un pequeño role llamado `deploy-app` para configurar la app como un [servicio de systemctl](https://linuxhandbook.com/create-systemd-services/) en linux.

Para verlo en acción, ejecutar el comando `vagrant up`