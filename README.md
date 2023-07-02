# docker-invoicing
Invoice ninja in docker- modified to use LISO containers

Permissions fix:
Because 'app' runs as 1500:1500, we need to modify permissions such as:
` chmod -R 777 <folder>/docker/app/