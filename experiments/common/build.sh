#!/bin/bash

BUILDDIR=../

unikraft_eurosys21_build() {
    unikraft_eurosys21_build_wvmm $1 $2 $3 kvm
}

unikraft_eurosys21_build_wvmm() {
    CONTAINER=uk-tmp-nginx
    # kill zombies
    docker container stop $CONTAINER
    docker rm -f $CONTAINER
    sleep 6
    docker pull hlefeuvre/unikraft-eurosys21:latest
    docker run --rm --privileged --name=$CONTAINER \
			-dt hlefeuvre/unikraft-eurosys21:latest
    
    docker exec -it $CONTAINER bash -c \
	"cd app-${1} && cp configs/${2}.conf .config"
    docker exec -it $CONTAINER bash -c \
	"cd app-${1} && make prepare && make -j"
    docker cp ${CONTAINER}:/root/workspace/apps/app-${1}/build/app-${1}_${4}-x86_64 \
		${3}/unikraft+${2}.kernel
    # special case: for solo5, also copy hvt
    if [ "$4" = "solo5" ]; then
        docker cp ${CONTAINER}:/root/workspace/apps/app-${1}/build/solo5-hvt \
            ${IMAGES}/solo5_hvt
    fi
    docker container stop $CONTAINER
    docker rm -f $CONTAINER
    sleep 6
}

unikraft_eurosys21_build_2() {
    unikraft_eurosys21_build_wvmm_2 $1 $2 $3 kvm
}

unikraft_eurosys21_build_wvmm_2() {
    CONTAINER=uk-tmp-nginx
    # kill zombies
    docker container stop $CONTAINER
    docker rm -f $CONTAINER
    sleep 6
    # docker pull hlefeuvre/unikraft-eurosys21:latest
    docker run --rm --privileged --name=$CONTAINER \
                        -dt unikraft/custom-nginx-builder:latest

    docker exec -it $CONTAINER bash -c \
        "cd app-${1} && cp configs/${2}.conf .config"
    docker exec -it $CONTAINER bash -c \
        "cd app-${1} && make prepare && make -j"
    docker cp ${CONTAINER}:/root/workspace/apps/app-${1}/build/app-${1}_${4}-x86_64 \
                ${3}/unikraft+${2}.kernel
    # special case: for solo5, also copy hvt
    if [ "$4" = "solo5" ]; then
        docker cp ${CONTAINER}:/root/workspace/apps/app-${1}/build/solo5-hvt \
            ${IMAGES}/solo5_hvt
    fi
    docker container stop $CONTAINER
    docker rm -f $CONTAINER
    sleep 6
}

unikraft_new_build() {
    unikraft_new_build_wvmm $1 $2 $3 kvm
}

unikraft_new_build_wvmm() {
    CONTAINER=uk-tmp-nginx
    # kill zombies
    docker container stop $CONTAINER
    docker rm -f $CONTAINER
    sleep 6
    # docker pull hlefeuvre/unikraft-eurosys21:latest
    docker run --rm --privileged --name=$CONTAINER \
                        -dt unikraft/latest-unikraft-build:latest

    docker exec -it $CONTAINER bash -c \
        "cd app-${1} && cp configs/${2}.conf .config"
    docker exec -it $CONTAINER bash -c \
        "cd app-${1} && make prepare && make -j"
    docker cp ${CONTAINER}:/root/workspace/apps/app-${1}/build/app-${1}_${4}-x86_64 \
                ${3}/unikraft+${2}.kernel
    # special case: for solo5, also copy hvt
    if [ "$4" = "solo5" ]; then
        docker cp ${CONTAINER}:/root/workspace/apps/app-${1}/build/solo5-hvt \
            ${IMAGES}/solo5_hvt
    fi
    docker container stop $CONTAINER
    docker rm -f $CONTAINER
    sleep 6
}
