#!/usr/bin/env bash

set -e

setup_command()
{
    docker run -it --rm -v ${PWD}/:/module/ ${IMAGE} python setup.py $@
}

python_command() {
    docker run -it --rm -v ${PWD}/:/module/ ${IMAGE} python $@
}

bash_command() {
    docker run -it --rm -v ${PWD}/:/module/ -v ${PWD}/.pypirc:/root/.pypirc ${IMAGE} $@
}

case "$1" in
"python")
    python_command ${@:2}
    ;;
"setup")
    setup_command ${@:2}
    ;;
"bash")
    bash_command ${@:2}
    ;;
*)
    echo -e "\n\n\n$ER [APP] No se especifico un comando valido\n"
    ;;
esac
