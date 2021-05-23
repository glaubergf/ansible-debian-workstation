---
Projeto: ansible-debian-workstation
Descrição: O objetivo desse projeto é automatizar a configuração na pós-instalação do sistema 
           GNU/Linux Debian (debian-10.9.0-amd64-xfce-CD-1.iso), assim nos poupando tempo e de
           todo trabalho braçal.
Autor: Glauber GF (mcnd2)
Atualização: 2021-05-23
---

![Image](https://github.com/glaubergf/ansible-debian-workstation/blob/main/pictures/rio-de-janeiro-swirl-debian.jpg) 

# Pós-instalação do Debian com Ansible

O objetivo desse projeto é executar após uma instalação do Debian com Ansible instalando pacotes, removendo outros, adicionando repositórios, criando usuário etc, assim nos poupando tempo e de todo trabalho braçal.

Veja o post desse projeto no **[SempreUpdate](https://sempreupdate.com.br/pos-instalacao-do-debian-com-ansible/)**.

## O Projeto

Esse projeto foi desenvolvido para automatizar uma pós-instalaçãodo do **[Debian](https://www.debian.org/)** 10.9 (Stable Buster) em um Notebook Dell Inspiron N5010 core i5 de 1ª geração com 10 anos idade.

Nesse projeto, foi adicionado para o repositório do Debian a seção contrib e não-free mais outros repositórios de terceiros para uso de aplicaçoes pertinente as necessidades do usuário e também as configurações no sistema para uso de VPN e mudanças no layout do Xfce4.

Altere as configiurações implantadas na playbook de acordo com as necessidades para o uso do sistema.

## A Automação

Veja uma breve descrição da task dentro de cada role:

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

Na role **uninstall-app** é executado a remoção de algumas aplicações não necessária para para o uso e alterações de outras.

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

Na role **create-user** é executado a criação do usuário para uso do sistema necessitando alterar a senha padrão no primeiro acesso.

* tasks:

```
Criando Conta de Usuario(s);
Forca o Usuario a Alterar a Senha no Primeiro Login.
```

Na role **aws-cli** é executado a instalação de pacotes necessários para acesso a AWS bem como exeção de comandos aws.

**Nota:**
Para executar a role _'aws-cli'_, lembre-se de executar o ansible-vault pois há informações sensíveis nas variáveis assim deixando-as criptografadas.

* Exemplos de comandos:

```
$ ansible-vault encrypt roles/var/main.yml
$ ansible-vault decrypt role/aws-cli/var/main.yml
$ ansible-playbook --ask-vault-pass -i hosts main.yml -t aws_cli
```

Lembre-se que as informações nas referidas variáveis nesse projeto são ficitícias, por esse motivo esta descriptografada.

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

Na role **conf-all** é executado algumas configurações no sistema como alterara permissão de conexão com a VPN, backup e modificação do layout do xfce4 com uma template, cópia de diretório específico replicando no seu nome com a data, e ainda download de temas de ícones, fontes e imagens para área de trabalho descompactando-as e inserindo para ser identificadas no sistema.

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

Na role **rebbot-system** é executado o reboot no sistema.

* tasks:

```
Reiniciando o sistema com todos os padrões.
```

## Contribuindo

Esse projeto fica disponível para a comunidade utilizar de acordo com a necessidades para cada vertente.

Para contribuições de melhorias no código, comente ou crie uma issue no projeto com as devidas alterações deixando a explicação e a alteração a ser aplicada, e assim que possível será executado o commit para a branch main.

## Licença

**GNU General Public License** (_Licença Pública Geral GNU_), **GNU GPL** ou simplesmente **GPL**.

[GPLv3](https://www.gnu.org/licenses/gpl-3.0.html)

------

Copyright (c) 2021 Glauber GF (mcnd2)

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
