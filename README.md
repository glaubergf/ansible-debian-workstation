---
Projeto: ansible-debian-workstation
Descrição: O objetivo desse projeto é automatizar a configuração na pós-instalação do sistema 
           GNU/Linux Debian, bem como algumas configurações adicionais e também upgrade de versão do
           sistema, assim nos poupando tempo, esforço e trabalho braçal.
Autor: Glauber GF (@mcnd2)
Atualização: 2023-08-15
---

![Image](https://github.com/glaubergf/ansible-debian-workstation/blob/main/pictures/rio-de-janeiro-swirl-debian.jpg) 

# Configurando o Debian com Ansible

O objetivo desse projeto é executar com o Ansible a configurações pós-instalação do Debian, instalando pacotes, removendo outros, adicionando repositórios, criando usuário etc.

Também podemos executar o update de todos os pacotes do sistema bem como upgrade de versão do sistema, no caso da versão stable "bullseye" para "bookworm", assim nos poupando tempo, esforço e trabalho braçal.

Veja os posts citando esse projeto no **SempreUpdate**:

**[Pós-instalação do Debian com Ansible](https://sempreupdate.com.br/pos-instalacao-do-debian-com-ansible/)**

**[Upgrade do Debian 10 para Debian 11 com Ansible](https://sempreupdate.com.br/upgrade-do-debian-10-para-Debian-11-com-ansible/)**

## O Projeto

O projeto inicial foi desenvolvido para automatizar uma pós-instalação do **[Debian](https://www.debian.org/)** 10.9 (Stable Buster) em um Notebook Dell Inspiron N5010 core i5 de 1ª geração (2010).

Nesse projeto, foi adicionado o repositório do Debian (Bookworm) com o componente 'contrib', 'non-free' e 'non-free-firmware', além de outros repositórios de terceiros para uso de aplicações pertinente as necessidades do usuário, executado também as configurações de permissão de uso da VPN, acesso a cloud AWS e mudanças no layout do Xfce4.

Na última atualização, foi revisado todas as roles para atualização de todos os pacotes do sistema e upgrade de versão do sistema com o lançamento da versão "Bookworm".

Para usar esse projeto, altere as configurações de acordo com seu cenário e necessidade de uso.

## A Automação

Veja uma breve descrição das **tasks** dentro de cada **role**.

Na role **add-repo** é executado a inclusão dos componentes _contrib_ , _non-free_ e _non-free-firmware_ no repositórios do Debian. Adicionado também outros reporitórios de terceiros para uso de aplicações.

* tasks:

```
Adicionando "source.list" com componentes "contrib", "non-free" e "non-free-firmware";
Atualizando Cache do Repositorio APT "apt-get update";
Instalando o "Debian Keyring" para chaves GPG;
Baixando Chaves GPG de Repositorios de Tercerios;
Criando diretorio "/etc/apt/sources.list.d/backup" caso nao exista;
Movendo os Repositórios de Terceiros "/etc/apt/sources.list.d/" para o diretorio "backup";
Importando Chaves GPG de Repositorios de Terceiros e adicionando os Repositorios;
Instalando o flatpak;
Adicionando Repositorio Flathub Flatpak;
Atualizando Repositorios;
```

Na role **uninstall-app** é executado a remoção de algumas aplicações não necessária para o uso e alterações de outras.

* tasks:

```
Removendo pacotes default com não serao usados;
```

Na role **install-app** é executado a instalação de aplicações do repositório do Debian bem como do Flatpak e pacotes '.deb' de downlaod da internet.

* tasks:

```
Baixando e instalando Pacotes "Flatpak" [Postman e Drawio];
Baixando Pacote [.deb] "VPN FortiClient" e dependencias. Aguarde ...;
Criando uma Lista de Pacotes [.deb] para "VPN FortiClient";
Gerando Variavel da Lista dos Pacotes para "VPN FortiClient";
Listando os Pacotes com DEBUG;
Instalando o "FortiClient" e suas dependencias;
Baixando e instalando Pacote [.deb] (Franz 5.9.2). Aguarde ...;
Instalando Aplicacoes do Repositorio APT;
Parando e desabilitando o autostart do "AnyDesk";
Parando e desabilitando o autostart do "FortiClient";
```

Na role **install-loffice** é executado o download da versão do LibreOffice stable na versão 7.4.7, descompactando e instalando o mesmo. Por esse motivo que o libreoffice foi removido na task _unistall-app_.

* tasks:

```
Baixando o "LibreOffice 7.4.7". Aguarde ...;
Descompactando Pacotes do LibreOffice 7.4.7;
Criando Lista de Pacotes [.deb] do "LibreOffice 7.4.7";
Gerando Variavel da Lista de Pacotes do "LibreOffice 7.4.7";
Listando os Pacotes do "LibreOffice 7.4.7" com DEBUG;
Instalando Pacotes [.deb] do "LibreOffice 7.4.7";
```

Na role **create-user** é executado a criação do(s) usuário(s) para uso do sistema necessitando alterar a senha padrão no primeiro acesso.

* tasks:

```
Criando Conta de Usuario(s);
Forca o Usuario a Alterar a Senha no Primeiro Login;
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
Verificar se o arquivo "EXTERNALLY-MANAGED" existe;
O arquivo EXISTE;
O arquivo NAO EXISTE;
Renomeando o arquivo "EXTERNALLY-MANAGED";
Instalando o "boto e awscli" via PIP. Aguarde ...;
Criando diretorio "/home/$user/.aws" caso nao exista
Criando arquivo de "Credencias da AWS";
Criando arquivo de "Configuracao da AWS";
Testando a "AWS CLI (aws --version)";
Resultado do "teste AWS CLI";
Criando diretorio "/home/$user/.ssh" caso nao exista;
Copiando a chave ssh de acesso na AWS;
Configurando o ".bashrc" com registro de "data e hora" no comando "history"
```

Na role **conf-all** é executado algumas configurações no sistema como backup e modificação do layout do Xfce4 com template, cópia de diretório específico replicando no seu nome com data, e download de temas de ícones, fontes e imagens para área de trabalho, assim sendo identificado no sistema.

* tasks:

```
Backup do ".config/xfce4" do usuario;
Copiando template do Painel do xfce4;
Backup do "lightdm-gtk-greeter.conf" do sistema;
Copiando template do utilitario de configuracao de login LightDM GTK+ Greeter;
Baixando os pacotes de temas de icones "Ardis" e "Nitrux";
Descompactando os pacotes de temas de icones "Ardis" e "Nitrux"
Copiando os diretorios de temas de icones para o "/usr/share/icons";
Baixando o pacote de "fontes Ubuntu";
Descompactando o pacote de "fontes Ubuntu";
Copiando os diretorios de fontes Ubuntu para o "/usr/share/fonts";
Criando diretorio "/home/$user/Imagens/wallpaper" se não existir;
Baixando "papel de parede Pexels";
Copiando diretorio de DADOS;
Reiniciando o Sistema devido as mudanças de arquivos de configuracoes [xfce4-panel e lightdm];
```

Na role **reboot-system** é executado o reboot no sistema.

* tasks:

```
Reiniciando o sistema com todos os padrões.
```

Na role **update-upgrade-app** é executado a atualização de todo os pacotes do sistema com a versão mais atual do repositório.

* tasks:

```
Atualizando cache do repositorio "apt-get";
Atualizando todos os pacotes "apt-get";
Verificando se uma "reinicializacao" e necessaria para o sistema;
Reboot do host Debian.
```

Na role **dist-upgrade** é executado a parada a interface gráfica, a alteração do repositórios do Debian da versão Bullseye para Bookworm, comentado todos os repositorios de terceiros, a atualização de todo o cache do repositórios Bookworm, a atualização de todos os pacotes para a versão do Bookworm, o reboot do sistema, a limpeza de cache, o autoremove de pacotes não mais necessários, descomentado os repositórios de terceiros e editado a versão do repositório de terceiro do Bullseye para Bookworm.

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
Editando repositorios do Debian 11 "bullseye" para o Debian 12 "bookworm";
Adicionar componente "non-free-firmware" no repositorio "sources.list";
Vasculhando Repositorios de Terceiros;
Debugando Repositorios de Terceiros;
Comentando Repositorios de Terceiros "/etc/apt/sources.list.d/*.list";
Atualizando cache do Repositorio APT "apt-get update";
Atualizando todos os pacotes "apt-get dist-upgrade". Aguarde ... ;
Verificando se eh necessario uma reinicializacao do sistema;
Reiniciando o sistema devido a atualizacao do kernel;
Removendo dependencias de pacotes que nao sao mais necessarias;
Lendo novamente os Repositorios de Terceiros;
Descomentando Repositorios de Terceiros "/etc/apt/sources.list.d/*.list";
Executando o 'apt-get update' direcionando para o "/root/apt-get-update.txt";
Filtrando as Chaves GPG não disponível para o arquivo "/root/no_pubkey.txt";
Ler o conteúdo do arquivo no_pubkey.txt;
DEBUG;
Importar em lotes todas as Chaves GPG ausentes;
Atualizando Cache do Repositorio APT "apt-get update"
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
