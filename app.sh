# Create container
function auto_deploy(){
    # create container
    docker run -d --name php7.3-dev -v $PWD/share:/share -p 80:80 -p 8080:8080 --privileged php:7.3.7-apache-stretch
    # config apache
    if test $? -eq 0
    then

        docker exec -it php7.3-dev bash /share/configure.sh
        docker restart php7.3-dev 
	return 0
    else
	    echo "Container config failed"
	    return 1
    fi
}


# Check docker if installed
function auto_install_docker(){
if test !  -e /usr/bin/docker
then
        # check os distribute for install docker
        osd=$(awk -F\" '/^NAME/{print $2}' /etc/os-release)
        #if centos
        if [[ ${osd} =~ 'CentOS' ]]
        then
	    # echo 'Will install '${osd}
	    # replace software sources
	    mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
	    cp ./osdv/yum/CentOS7-Base-163.repo /etc/yum.repos.d/CentOS-Base.repo
	    bash ./osdv/get-centos-docker.sh
	    # deploy wechat
            return 0
        fi
        #if debian
        if [[ ${osd} =~ 'Debian' ]]
        then
	    # echo 'Will install '${osd}
	    # Replace software sources
	    mv /etc/apt/sources.list /etc/apt/sources.list.backup
	    cp ./osdv/apt/sources.list /etc/apt/sources.list
	    bash ./osdv/get-debian-docker.sh
            return 0
        fi
    else
	    return 0
    fi
}

# start deploy
function app(){
    # check if docker installed
    if test -e /usr/bin/docker
    then
	    # create container
	    auto_deploy
	    if test $? -eq 0
	    then
		    echo " WeChat is deploy succesed"
	    else
		    echo "WeChat app deploy failed"
	    fi
    else
	    # install docker
	    auto_install_docker
	    # create container
	    if test -e /usr/bin/docker
	    then
		    auto_deploy
		    if test $? -eq 0
		    then
			    echo "Wechat app deploy successed"
		    else
			    echo "WeChat app deploy failed"
		    fi
	    fi
    fi
}

app
