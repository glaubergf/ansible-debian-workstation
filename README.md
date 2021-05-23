---
Projeto: ansible-vagrante-debian-zabbix
Descrição: O objetivo desse projeto é provisionar uma ou mais VMs, assim podendo ser 
           modificadas as suas variáveis nos parâmetros que atendam as suas espectativas.
Autor: Glauber GF (mcnd2)
Atualização: 2021-05-02
---

![Image](https://github.com/glaubergf/ansible-vagrant-debian-zabbix/blob/main/start_zabbix.png) 

# Instalar e Configurar o Zabbix com o Ansible

O **Zabbix** é um software de nível corporativo ideal para o monitoramento em tempo real de milhões de métricas coletadas de dezenas de milhares de servidores, máquinas virtuais e dispositivos de rede, além de ser de código aberto é também gratuito.

O **Ansible** trabalha com os conceitos de inventário (_lista de máquinas que serão gerenciadas_), playbooks (_comandos ou passo-a-passo a ser executado_) e roles (_modularização do código_). Atualmente o Ansible pertence a **Red Hat**.

## O Host

Para esse projeto local, foi utilizado o Host com o Sistema Operacional **[Debian 10 Buster](https://www.debian.org/)** e realizado a instalação dos seguintes programas (ferramentas) para a execução do projeto:

**[Vagrant](https://www.vagrantup.com/docs)** para provisionar a(s) VM(s) (_máquina virtual_) com o **Debian Buster**. Lembrando que o _Vagrantfile_ utilizado nesse projeto está configurado para o uso do provider **[libvirt](https://libvirt.org/)** com o gerenciador gráfico **[Virtual Machine Manager](https://virt-manager.org/)**.

**[Ansible](https://docs.ansible.com/ansible/latest/index.html)** para executar o gerenciamento de automação na máquina alvo, a VM com o Debian.

O Artigo que faz referência a este Projeto esta no **[SempreUpdate](https://sempreupdate.com.br/como-instalar-e-configurar-o-zabbix-5-no-debian-10-com-ansible/)**.

## A Automação

Veja uma breve descrição da task dentro de cada role:

Na role **config_initial** é executado o ajuste do timezone, alterado o idioma do sistema, alterado o layout do teclado, instalado, configurado e habilitado o ntp.

* tasks:

```
Ajustando o timezone do sistema;
Alterando o idioma do sistema;
Alterando o layout do teclado do sistema;
Removendo arquivo '/var/lib/dpkg/lock-frontend' se existir;
Executando 'apt-get update';
Instalando o ntp / ntpdate;
Parando o ntp;
Copiando o arquivo de configuração do ntp;
Ajustando a hora e habilitando o ntp;
Iniciando o ntp.
```

Na role **db-mariadb** é executado a instalação e configuração necessária para o banco de dados mariadb.

* tasks:

```
Instalando o MariaDB Database Server;
Verificando se o MariaDB está em execução e inicia no boot;
Conectando ao servidor usando 'login_unix_socket';
Removendo contas de usuários 'anônimos' para localhost;
Removendo usuários 'zabbix' para o localhost se existir;
Removendo o MySQL 'test database';
Altera o plugin de autenticação do usuário 'root' do MariaDB para mysql_native_password;
Privilégios de liberação para usuário 'root';
Criando usuário 'zabbix' para o MariaDB;
Criando banco de dados com nome 'zabbix'.
```

Na role **mon-zabbix** é executado a adição do repositório zabbix, a instalação e configuração necessárias para que o zabbix carregue sem problemas.

* tasks:

```
Adicionando o repositório do Zabbix Server;
Executando o update nos repositórios;
Instalando o Zabbix com frontend e suporte ao banco de dados MariaDB/MySQL;
Importando arquivo.sql similar para mariadb/mysql -u <user> -p <password> < arquivo.sql;
Configuração do zabbix /etc/zabbix/zabbix_server.conf e inserindo os dados de conexão do banco;
Configurando timezone do Nginx para os parâmetros que o Zabbix usa;
Reiniciando o Zabbix Server, Zabbix Agente, Nginx e PHP;
Configurando o Nginx;
Mudando a porta default do Nginx para não colidir com a do Zabbix;
Alterando permissões no diretório raiz do Zabbix;
Reiniciando o Nginx.
```

Explore as _tasks_ e sinta-se a vontade para melhorá-la.

## Contribuindo

Esse foi um projeto inicial de estudo e para contribuição de melhorias no código, comente ou crie uma issue no projeto com as devidas alterações deixando com a explicação e assim que for possível será executado o commit e o merge para a branch main.

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
