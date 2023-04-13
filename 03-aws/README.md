# AWS

Este tercer ejemplo, crea reutiliza 2 modulos de terraform vistos anteriormente en clase para crear por un lado una VPC y por el otro una instancia EC2.

Hay que editar el file `03-aws/terraform/clinica-app/user-data.sh` con una clave publica generada usando el comando `ssh-keygen`. De esta manera, se podra usar la clave privada para configurar el servidor usando la playbook del ejemplo anterior.

Para esto, luego de crear la infra, editar el archivo `03-aws/ansible/hosts` con la ip publica de la instancia EC2  y ejecutar el siguiente comando

```
ansible-playbook --user ubuntu --private-key ~/.ssh/id_rsa -i ansible/hosts ../02-ansible/configure-app.yml
```