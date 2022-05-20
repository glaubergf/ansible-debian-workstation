---
Projeto: ansible-lmde-workstation
Descrição: O objetivo desse projeto é automatizar a configuração na pós-instalação do sistema
           LMDE (Linux Mint Debian Edition), bem como algumas configurações adicionais e também upgrade de versão do sistema.
Autor: Glauber GF (@mcnd2)
Atualização: 2022-05-18
---

![Image](https://github.com/glaubergf/ansible-debian-workstation/blob/main/pictures/What-is-LMDE.jpg)

# Configurando o LMDE com Ansible

O objetivo desse projeto é executar com o Ansible a configurações pós-instalação do LMDE, instalando pacotes, adicionando repositórios, configurando alguns arquivos do sistema etc.

## O Projeto

O projeto foi desenvolvido para automatizar uma pós-instalação do **[LMDE](https://www.linuxmint.com/download_lmde.php)** 5 (Elsie) em um Notebook Dell Latitude 3400 core i7 de 8ª geração.

Nesse projeto, foi adicionado repositórios de terceiros para uso de aplicações pertinente as necessidades do usuário e configuração para acesso a cloud AWS.

## A Automação

Veja uma breve descrição das **tasks** dentro de cada **role**.

Na role **add-repo** é adicionado outros repositórios, de terceiros, para uso de aplicações.

* tasks:

```
Atualizando Repositorios;
Adicionando Repositorio Flathub Flatpak;
Adicionando Keys para Validacao dos Repositorios de Terceiros;
Adicionando dos Repositorios de Terceiros;
Atualizando Repositorios;
Adicionando Token do Malwarebytes.
```

Na role **aws-cli** é executado a instalação de pacotes e configuração para acesso e utilização dos recursos e serviços na cloud AWS.

**Nota:**
_Para executar a role **aws-cli**, lembre-se de executar o **ansible-vault** pois há informações sensíveis nas variáveis assim deixando-as criptografadas. As informações nas referidas variáveis nesse projeto são fictícias, por esse motivo esta descriptografada._

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

Na role **install-app** é executado a instalação de aplicações do repositório do LMDE bem como do Flatpak e pacotes '.deb' para cliente de VPN.

* tasks:

```
Instalando Pacotes Flatpak;
Download Pacotes ".deb" para VPN FortiClient;
Criando uma Lista de Pacotes ".deb" para VPN FortiClient;
Criando Variavel da Lista dos Pacotes para VPN FortiClient;
Listando os Pacotes com DEBUG;
Instalando o FortiClient e suas dependencias;
Instalando Pacotes ".deb" APPs da Internet;
Instalando Pacotes dos Repositorios;
Parando o AnyDesk;
Desabilitando o autostart do AnyDesk.
```

## Contribuindo

Esse projeto fica disponível para a comunidade. Use e faça modificações de acordo com o cenário e necessidade de cada um.

## Licença

**GNU General Public License** (_Licença Pública Geral GNU_), **GNU GPL** ou simplesmente **GPL**.

[GPLv3](https://www.gnu.org/licenses/gpl-3.0.html)

------

Copyright (c) 2022 Glauber GF (@mcnd2)

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
