#!/bin/bash

java_base_folder=/usr/local/java

# Arquivos JDK8
java8_folder=jdk1.8.0_211
java8_file=jdk-8u211-linux-x64.tar.gz

# Arquivos JDK7
java7_folder=jdk1.7.0_80
java7_file=jdk-7u80-linux-x64.tar.gz

option1=$1

downloadJava() {

    if [ -f "$java_file" ]; then
        echo "$java_file exist"
    else 
        wget $http_jdk_download  
    fi

}

installJava() {

    # Criando pasta do Java
    sudo mkdir -p $java_base_folder

    # # Copiando arquivo para pasta do Java
    sudo cp -r $java_file $java_base_folder

    cd $java_base_folder

    # # Extraindo a jdk 8
    sudo tar -xvzf $java_file

    # # Removendo arquivo tar.gz
    sudo rm $java_file

    # Adicionando variáveis de ambiente

    echo "" | sudo tee -a /etc/profile

    echo "JAVA_HOME=${java_base_folder}/${java_folder}" | sudo tee -a /etc/profile
    echo "JRE_HOME=${java_base_folder}/${java_folder}" | sudo tee -a /etc/profile
    echo "PATH=\$PATH:\$JRE_HOME/bin:\$JAVA_HOME/bin" | sudo tee -a /etc/profile
    echo "export JAVA_HOME" | sudo tee -a /etc/profile
    echo "export JRE_HOME" | sudo tee -a /etc/profile
    echo "export PATH" | sudo tee -a /etc/profile


    # Instalando jdk 8 no alternatives

    sudo update-alternatives --install "/usr/bin/java" "java" "${java_base_folder}/${java_folder}/bin/java" 1
    sudo update-alternatives --install "/usr/bin/javac" "javac" "${java_base_folder}/${java_folder}/bin/javac" 1
    sudo update-alternatives --install "/usr/bin/javaws" "javaws" "${java_base_folder}/${java_folder}/bin/javaws" 1

    # # Setando como default

    sudo update-alternatives --set java ${java_base_folder}/${java_folder}/bin/java
    sudo update-alternatives --set javac ${java_base_folder}/${java_folder}/bin/javac
    sudo update-alternatives --set javaws ${java_base_folder}/${java_folder}/bin/javaws

    # Recarregando o profile

    source /etc/profile

    # Testando instalação

    java -version

}


main() {

    case $option1 in 

        -jdk8)
            java_folder=$java8_folder
            java_file=$java8_file

            http_jdk_download=http://192.168.25.234/arquivos/$java_file
            
            downloadJava
            installJava
            break;;
        
        -jdk7)
            java_folder=$java7_folder
            java_file=$java7_file

            http_jdk_download=http://192.168.25.234/arquivos/$java_file
            
            downloadJava
            installJava
            break;;

        *)
            echo "Opção inválida, coloque como argumento -jdk8 para instalar a JDK8 e -jdk7 para instalar a JDK7"
            exit 1
            break;;
    esac

}

main