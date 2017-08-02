SCRIPT CAMBIADOR DE CLAVES EN SERVIDORES MASIVO.

Intrucciones:

Edita el archivo servidores.txt con los accesos de todos los servers a los cuales les quieras
hacer el cambio de clave. Ten en cuenta el siguiente formato.

usuario@ip-o-fqdn
Ejemplo:

root@172.16.30.38

Luego ejecuta archivo changepass_client.sh y el automaticamente copiara el fichero change_pass_server.sh en 
todos los servidores que colocaste en el fichero servidores.txt (posiblemente pida clave para copiar)

Adicionalmente el script ejecuta las acciones necesarias para cambiar la clave.
