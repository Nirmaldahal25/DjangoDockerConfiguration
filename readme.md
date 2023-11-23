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