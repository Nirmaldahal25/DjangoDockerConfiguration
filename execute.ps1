#create basics
PARAM(
    [string]$command
)
$volume_name = "django_volume"
$network_name = "mysqlnetwork"
$app_container_name = "python_app_container"
$app_image_name = "python_app_image"
$mysql_container_name = "mysql_container"
if($command -eq "create")
{
    docker volume create $volume_name
    docker build . -t $app_image_name
    docker network create $network_name
}
elseif ($command -eq "run") {
    docker run --rm -dp 3306:3306 --network $network_name --network-alias mysql  -e MYSQL_ROOT_PASSWORD=secret -e MYSQL_DATABASE=myapp -e MYSQL_USER=user -e MYSQL_PASSWORD=password -v ./${volume_name}:/var/lib/mysql/ --name $mysql_container_name mysql:8.0
    docker exec -it $mysql_container_name mysql -uroot -psecret -e "GRANT ALL PRIVILIGES ON myapp.* TO user;" -e "SET GLOBAL connect_timeout=28800;" -e "SET GLOBAL interactive_timeout=28800;" -e "SET GLOBAL wait_timeout=28800" -e "WITH GRANT OPTION" -e "FLUSH PRIVILIGES"
    docker run --rm -p 0.0.0.0:8000:8000 --network $network_name --name $app_container_name  $app_image_name
}
elseif ($command -eq "remove") {
    docker volume rm -f $volume_name
    docker network rm -f $network_name 
    docker rmi -f $app_image_name
}
elseif($command -eq "stop")
{
    docker container stop $mysql_container_name
    docker container stop $app_container_name
}
elseif($command -eq "list")
{
    Write-Output "Containers"
    docker container ls
    Write-Output "`n"
    Write-Output "Running Containers"
    docker ps -a
    Write-Output "`n"
    Write-Output "Images"
    docker images -a
    Write-Output "`n"
    Write-Output "Volumes"
    docker volume ls
    Write-Output "`n"
    Write-Output "Network"
    docker network ls
}