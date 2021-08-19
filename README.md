---
Projeto: ansible-debian-workstation
Descrição: O objetivo desse projeto é automatizar a configuração na pós-instalação do sistema 
           GNU/Linux Debian, bem como algumas configurações adicionais e também upgrade de versão do
           sistema, assim nos poupando tempo, esforço e trabalho braçal.
Autor: Glauber GF (@mcnd2)
Atualização: 2021-08-19
---

![Image](https://github.com/glaubergf/ansible-debian-workstation/blob/main/pictures/rio-de-janeiro-swirl-debian.jpg) 

# Configurando o Debian com Ansible

O objetivo desse projeto é executar com o Ansible a configurações pós-instalação do Debian, instalando pacotes, removendo outros, adicionando repositórios, criando usuário etc.

Também podemos executar o update de todos os pacotes do sistema bem como upgrade de versão do sistema, no caso da versão stable "buster" para "bullseye", assim nos poupando tempo, esforço e trabalho braçal.

Veja os posts citando esse projeto no **SempreUpdate**:

**[Pós-instalação do Debian com Ansible](https://sempreupdate.com.br/pos-instalacao-do-debian-com-ansible/)**

**[Upgrade do Debian 10 para Debian 11 com Ansible](https://sempreupdate.com.br/upgrade-do-debian-10-para-Debian-11-com-ansible/)**

## O Projeto

O projeto inicial foi desenvolvido para automatizar uma pós-instalação do **[Debian](https://www.debian.org/)** 10.9 (Stable Buster) em um Notebook Dell Inspiron N5010 core i5 de 1ª geração (2010).

Nesse projeto, foi adicionado o repositório do Debian com a seção 'contrib' e 'non-free' mais outros repositórios de terceiros para uso de aplicações pertinente as necessidades do usuário, executado também as configurações de permissão de uso da VPN, acesso a cloud AWS e mudanças no layout do Xfce4.

Nas últimas atualizações, foi adiconado a role para atualização de todos os pacotes do sistema e também outra role para executar o upgrade de versão do sistema com o lançamento da versão "Bullseye".

Para usar esse projeto, altere as configurações de acordo com seu cenário e necessidade de uso.

## A Automação

Veja uma breve descrição das **tasks** dentro de cada **role**.

Na role **add-repo** é executado a inclusão da seção _contrib_ e _non-free_ no repositórios do Debian. Adicionado também outros reporitórios de terceiros para uso de aplicações.

* tasks:

```
Adiconando Repositorios "contrib" e "non-free";
Atualizando Repositorios;
Instalando o flatpak;
Adicionando Repositorio Flathub Flatpak;
Instalacao GPG-Key;
Adicionando Keys para Validacao dos Repositorios Adicionais;
Adiconando URLs dos Repositorios Adicionais;
Atualizando Repositorios.
```

Na role **uninstall-app** é executado a remoção de algumas aplicações não necessária para o uso e alterações de outras.

* tasks:

```
Removendo pacotes.
```

Na role **install-app** é executado a instalação de aplicações do repositório do Debian bem como do Flatpak e pacotes '.deb' de downlaod da internet.

* tasks:

```
Instalando Pacotes do Repositorio;
Instalando Pacotes Flatpak;
Instalando Pacotes ".deb" da Internet.
```

Na role **install-loffice** é executado o download da versão do LibreOffice stable na versão 7.0.5, descompactando e instalando a mesma. Por esse motivo que o libreoffice foi removido na task _unistall-app_.

* tasks:

```
Download do LibreOffice;
Descompactando Pacotes do LibreOffice;
Criando uma Lista de Pacotes .deb do LibreOffice;
Criando Variavel da Lista dos Pacotes do LibreOffice;
Listando os Pacotes com DEBUG;
Instalando Pacotes .deb do LibreOffice.
```

Na role **create-user** é executado a criação do(s) usuário(s) para uso do sistema necessitando alterar a senha padrão no primeiro acesso.

* tasks:

```
Criando Conta de Usuario(s);
Forca o Usuario a Alterar a Senha no Primeiro Login.
```

Na role **aws-cli** é executado a instalação de pacotes necessários e configuração para acesso e manipulação na AWS.

**Nota:**
_Para executar a role **aws-cli**, lembre-se de executar o **ansible-vault** pois há informações sensíveis nas variáveis assim deixando-as criptografadas. As informações nas referidas variáveis nesse projeto são ficitícias, por esse motivo esta descriptografada._

* comandos:

```
$ ansible-vault encrypt roles/var/main.yml
$ ansible-vault decrypt role/aws-cli/var/main.yml
$ ansible-playbook --ask-vault-pass -i hosts main.yml -t aws_cli
```

* tasks:

```
Instalando o Python3 PIP;
Instalando o boto via PIP;
Instalando a AWS CLI;
Executando AWS Configure inserindo Id, Key, Region e formato no profile Default
Criando o diretório ~/.ssh caso nao exista;
Copiando a chave ssh de acesso na AWS;
Configurando o .bashrc awsgo/alog (SSH) e data no historico.
```

Na role **conf-all** é executado algumas configurações no sistema como alterar a permissão de conexão com a VPN, backup e modificação do layout do xfce4 com um template, cópia de diretório específico replicando no seu nome com data, e download de temas de ícones, fontes e imagens para área de trabalho, assim sendo identificado no sistema.

* tasks:

```
Adicionando permissão para o usuario conectar a VPN com o OpenFortiGUI;
Backup do .config/xfce4 do usuário;
Copiando template do Painel do xfce4;
Download dos pacotes de temas de icones Ardis e Nitrux;
Descompactando os pacotes de temas de icones Ardis e Nitrux;
Copiando os diretorios de temas de icones para o /usr/share/icons;
Download do pacote de fontes Ubuntu;
Descompactando o pacote de fontes Ubuntu;
Copiando os diretorios de fontes Ubuntu para o /usr/share/fonts;
Criando diretorio ~/Imagens/wallpaper se não existir;
Download papel de parede Pexels;
Copiando diretorio BEMOBI;
continuando ...
```

Na role **reboot-system** é executado o reboot no sistema.

* tasks:

```
Reiniciando o sistema com todos os padrões.
```

Na role **update-upgrade-app** é executado a atualização de todo os pacotes do sistema com a versão mais atual do repositório.

* tasks:

```
Atualizando cache do repositorio 'apt-get';
Atualizando todos os pacotes 'apt-get';
Verificando se uma reinicializacao e necessaria para o sistema;
Reinicializando o host Debian.
```

Na role **dist-upgrade** é executado a parada a interface gráfica, a alteração do repositórios do Debian da versão Buster para Bullseye, comentado todos os repositorios de terceiros, a atualização de todo o cache do repositórios Bullseye, a atualização do pacote openssh-server para versão do Bullseye para dar continuidade no upgrade do sistema, o restart do serviço sshd, a atualização de todos os pacotes para a versão do bullseye, o reboot do sistema, a limpeza de cache, o autoremove de pacotes não mais necessários, descomentado os repositórios de terceiros e editado a versão do repositório de terceiro do Buster para Bullseye.

**Nota:**
_Para executar a role **dist-upgrade**, lembre-se de executar a playbook com o parâmetro **-t** [tag] setando apenas a referida role a ser executada. Para checar a execução antes de aplicá-la, use no final do comando o parâmetro **-C** ["c" maiúsculo] conforme demostrado abaixo.

* comandos:

```
$ ansible-playbook -i hosts main.yml -t dist-upgrade
$ ansible-playbook -i hosts main.yml -t dist-upgrade -C
```

* tasks:

```
Parando a interface grafica (GUI);
Editando repositorios do Debian 10 "buster" para o Debian 11 "bullseye";
Editando formato do repositorio de segurança ([buster]bullseye/updates > bullseye-security);
Encontrando repositorios de terceiros;
Debugando repositorios de terceiros;
Comentando repositorios de terceiros em '/etc/apt/sources.list.d/*.list';
Atualizando cache do repositorio 'apt-get update';
Atualizando a versao do 'openssh-server' (bullseye) para executar o upgrade do sistema via 'ssh';
Reiniciando o servico 'sshd';
Atualizando todos os pacotes 'apt-get dist-upgrade';
Verificando se e necessario uma reinicializacao do sistema;
Reiniciando o sistema devido a atualizacao do kernel;
Atualizando novamente o cache do repositorio 'apt-get update';
Atualizando novamente todos os pacotes 'apt-get dist-upgrade';
Reiniciando o sistema 'Pos-Upgrade';
Removendo pacotes inuteis do cache do 'apt';
Removendo dependencias de pacotes que nao sao mais necessarias;
Lendo novamente os repositorios de terceiros;
Descomentando repositorios de terceiros em '/etc/apt/sources.list.d/*.list;
Editando repositorios de Terceiros de 'buster' para 'bullseye'.
```

## Contribuindo

Esse projeto fica disponível para a comunidade. Use e façam modificações de acordo com o cenário e necessidade de cada um.

Para contribuições de melhorias no código, comente ou crie uma issue no projeto com as devidas alterações, deixando a explicação e a alteração a ser aplicada, assim que possível será executado o commit para a branch main.

## Licença

**GNU General Public License** (_Licença Pública Geral GNU_), **GNU GPL** ou simplesmente **GPL**.

[GPLv3](https://www.gnu.org/licenses/gpl-3.0.html)

------

Copyright (c) 2021 Glauber GF (@mcnd2)

Este programa é um software livre: você pode redistribuí-lo e/ou modificar
sob os termos da GNU General Public License conforme publicada por
a Free Software Foundation, seja a versão 3 da Licença, ou
(à sua escolha) qualquer versão posterior.

Este programa é distribuído na esperança de ser útil,
mas SEM QUALQUER GARANTIA; sem mesmo a garantia implícita de
COMERCIALIZAÇÃO ou ADEQUAÇÃO A UM DETERMINADO FIM. Veja o
GNU General Public License para mais detalhes.

Você deve ter recebido uma cópia da Licença Pública Geral GNU
junto com este programa. Caso contrário, consulte <https://www.gnu.org/licenses/>.

*

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>
