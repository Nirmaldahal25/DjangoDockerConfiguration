# Contents

<p> This project contents docker multi-container setup of django and mysql database. The powershell script is there for docker management. However, this can be done solely with **Docker Compose**. The table 1 contains information about script commands.</p>  

## Execute Script
`.\execute <command>`<br>
|\<command\>|     Task|
|    :---   |     ---:|
| create    | create volume, build django image, create network|
| run       | start mysql and django container|
| stop      | stop django and mysql container |
| remove    | remove volume, django image and network|


## Some Important Things To Remember
- `--network-alias mysql` is used in starting mysql container for aliasing hostname. In django database configuration, set `"HOST":"mysql"`.
- The mysql doesn't grant priviliges to the user at initial, thus permissions has to be granted manually.
- The volume location on windows is `\\wsl$\docker-desktop-data\data\docker\volumes`

## Building Django Application With Docker Compose
- `docker compose build` images with compose.yml settings.
- `docker compose up` tries to start django server and fails at first. 
- Mysql user permissions has to be given manually. `mysql -uroot -p<password_root> -e "GRANT ALL PRIVILIGES on <database_name>.* TO <username>" -e "FLUSH PRIVILIGES"`
- Run django migrations with `docker exec -it python manage.py migrate --no-input`. This has to be done only once.
- Superuser can be created with `docker exec -it python manage.py createsuperuser`.