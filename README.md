## Utilitário para instalação do Oracle JDK no Ubuntu (todos)

Clone o projeto para sua máquina, entre na pasta do projeto e execute:

#### Java 7:

    sh install-oracle-jdk.sh -jdk7

#### Java 8:

    sh install-oracle-jdk.sh -jdk8

Para testar se a JDK foi corretamente instalada, digite:

    java -version

Para alterar entre versões do java, utilize o update-alternatives:

    sudo update-alternatives --config java


## Problemas

Caso verifique algum problema com o utilitário, abra um Issue relatando o problema.