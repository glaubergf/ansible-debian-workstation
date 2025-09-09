<!---
# ================================================================
Projeto:    ansible-debian-workstation
---
Descrição:  Automatiza a pós-instalação do sistema GNU/Linux Debian,
incluindo instalação/remoção de pacotes, adição de repositórios, 
configurações de ambiente, criação de usuários e upgrade de versão.
---
Autor:      Glauber GF (mcnd2)
Criado em:  2021-03-10
Atualizado: 2025-09-09
# ================================================================
--->

# Configurar o Debian com Ansible

![Image](https://github.com/glaubergf/ansible-debian-workstation/blob/main/pictures/rio-de-janeiro-swirl-debian.jpg)

![Image](https://github.com/glaubergf/ansible-debian-workstation/blob/main/pictures/debian-trixie-after.jpg)

![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)

## 📜 Sobre o Projeto

Este projeto utiliza o **Ansible** para automatizar a configuração do **Debian GNU/Linux** (pós instalação e/ou upgrade de release) poupando tempo e trabalho manual.

## 🪄 O que ele realiza

- Atualização completa do sistema e upgrade de versão (*Bookworm → Trixie*).
- Instalação e remoção de pacotes do APT, Flatpak e `.deb` externos.
- Inclusão de repositórios oficiais com todos os componentes (`contrib`, `non-free`, `non-free-firmware`) e repositórios de terceiros.
- Configuração do ambiente gráfico (Xfce4), temas, fontes e wallpapers.
- Integração com **AWS CLI** para gerenciamento de nuvem.
- Criação de usuários e ajuste de permissões.

## 🧩 Tecnologias Utilizadas

![Ansible](https://img.shields.io/badge/Ansible-EE0000?logo=ansible&logoColor=white&style=for-the-badge)  
- [Ansible](https://www.ansible.com/) — Automação de configuração e provisionamento.  

![Debian](https://img.shields.io/badge/Debian-A81D33?logo=debian&logoColor=white&style=for-the-badge)  
- [Debian GNU/Linux](https://www.debian.org/) — Sistema operacional do guest.  

## 💡 Motivação

O projeto inicial foi desenvolvido para automatizar uma pós-instalação do Debian 10.9 (Stable Buster) em um Notebook Dell Inspiron N5010 core i5 de 1ª geração (2010).

Com isso, o projeto vem servindo para automatizar o sistema operacional Debian em novos lançamentos de release Stable, usando a playbook completa para update de versão e configurações ou usando tags para role única.

Com o moderno repositórios no formato DEB822 (*.sources*) no Trixie ainda segue o default (*.list*), foi executado a conversão para usar o novo formato de configuração do repositório. Tem caso que pacotes de terceiros criam o repositório (*.list*) em script postinst, no entanto, foi mapeado quais pacotes criavam esses repositórios automático e alterado o atributos especiais desses arquivos para que não seja mais aplicado e não duplique entrada para o apt.

Para usar esse projeto, altere as configurações de acordo com seu cenário e necessidade de uso.

## 🛠️ Pré-requisitos

- ✅ Ansible instalado no host.
- ✅ Usuário com permissão de root no guest.
- ✅ SSH configurado para acesso ao guest.

## 📂 Estrutura do Projeto

```
ansible-debian-workstation
├── group_vars
│   └── all.yml
├── pictures
│   ├── debian-trixie-after.png
│   ├── debian-trixie-before.png
│   ├── lightdm-debian-trixie-after.png
│   ├── lightdm-debian-trixie-before.png
│   └── rio-de-janeiro-swirl-debian.jpg
├── roles
│   ├── add-repo
│   │   ├── files
│   │   │   └── sources.list
│   │   ├── tasks
│   │   │   ├── add_repo.yml
│   │   │   └── main.yml
│   │   └── vars
│   │       └── main.yml
│   ├── aws-cli
│   │   ├── tasks
│   │   │   ├── aws_cli.yml
│   │   │   └── main.yml
│   │   ├── vars
│   │   │   └── main.yml
│   │   └── aws-references.txt
│   ├── conf-all
│   │   ├── files
│   │   │   ├── lightdm-gtk-greeter
│   │   │   │   ├── Gas-Soldier-with-Weapon-64x64.png
│   │   │   │   ├── lightdm-gtk-greeter.conf
│   │   │   │   ├── solarized-wallpaper-debian.png
│   │   │   │   └── TheMandalorian_BabyYoda_StarWars.jpeg
│   │   │   ├── custom_bashrc.sh
│   │   │   ├── readme-template-xfce4.txt
│   │   │   ├── xfce4-template-full.sh
│   │   │   ├── xfce4-template-full.tar.gz
│   │   │   ├── xfce4-template-minimal.sh
│   │   │   └── xfce4-template-minimal.tar.gz
│   │   ├── tasks
│   │   │   ├── conf_all.yml
│   │   │   └── main.yml
│   │   └── vars
│   │       └── main.yml
│   ├── create-user
│   │   ├── tasks
│   │   │   ├── create_user.yml
│   │   │   └── main.yml
│   │   └── vars
│   │       └── main.yml
│   ├── dist-upgrade
│   │   ├── tasks
│   │   │   ├── dist_upgrade.yml
│   │   │   └── main.yml
│   │   └── vars
│   │       └── main.yml
│   ├── install-app
│   │   ├── tasks
│   │   │   ├── install_app.yml
│   │   │   └── main.yml
│   │   └── vars
│   │       └── main.yml
│   ├── install-loffice
│   │   ├── tasks
│   │   │   ├── install_loffice.yml
│   │   │   └── main.yml
│   │   └── vars
│   │       └── main.yml
│   ├── remove-user
│   │   ├── tasks
│   │   │   ├── main.yml
│   │   │   └── remove_user.yml
│   │   └── vars
│   │       └── main.yml
│   ├── uninstall-app
│   │   ├── tasks
│   │   │   ├── main.yml
│   │   │   └── uninstall_app.yml
│   │   └── vars
│   │       └── main.yml
│   └── update-upgrade-app
│       ├── tasks
│       │   ├── main.yml
│       │   └── update_upgrade_app.yml
│       └── vars
│           └── main.yml
├── ansible.cfg
├── hosts
├── LICENSE
├── main.yml
└── README.md
```

## 🚀 Tasks por Role em ordem de execução

- ✅ **update-upgrade-app**
```
- Atualizar cache do APT (apt-get update)
- Atualizar todos os pacotes (apt-get upgrade). Aguarde...
- Verificar necessidade de reiniciar o sistema operacional
- Reiniciar o sistema operacional (se necessário)
```

- ✅ **dist-upgrade**
```
- Detectar serviço ativo de interface gráfica
- Parar GUI ativa (se houver)
- Substituir repositório Bookworm por Trixie no sources.list
- Localizar repositórios de terceiros (.list)
- Exibir repositórios de terceiros (.list)
- Comentar repositórios de terceiros para upgrade de release
- Garantir que debconf-utils esteja instalado
- Detectar disco de boot ou raiz para configurar GRUB (compatível com NVMe, LVM, etc)
- Exibir disco detectado
- Pré-configurar o GRUB para não-interativo
- Atualizar cache do APT (apt-get update)
- Atualizar todos os pacotes para a nova release (apt-get dist-upgrade). Aguarde...
- Reiniciar o sistema para aplicar as mudanças
- Remover pacotes obsoletos (apt-get autoremove)
- Verificar versão do Debian
- Garantir que o sistema esteja na nova versão antes de continuar
- Descomentar linhas dos repositórios de terceiros (.list)
- Substituir Bookworm por Trixie nos repositórios de terceiros (.list)
- Modernizar todos os repositórios para o formato DEB822 (.list → .sources) de forma não-interativa
- Localizar todos os repositórios (.sources)
- Habilitar (Enabled yes) em todos os repositórios (.sources)
- Atualizar cache do APT (update) e registrar saída
- Detectar repositórios com erro crítico na URL
- Localizar repositórios (.sources)
- Ler conteúdo dos repositórios (.sources)
- Garantir lista de arquivos desabilitados
- Desabilitar repositórios com erro crítico na URL
- Construir lista dos repositórios desabilitados
- Listar os repositórios desabilitados
```

- ✅ **add-repo**
```
- Verificar se existem repositórios em formato .sources
- Definir fato se usando formato .sources
- Aplicar novo sources.list com todos os componentes
- Atualizar cache do APT (apt-get update)
- Instalar pacotes keyrings, Debian e curl
- Baixar e converter chaves GPG de terceiros
- Verificar se já existe arquivo .sources correspondente
- Fazer backup de arquivos .sources existentes antes de recriar
- Criar repositórios de terceiros (.list)
- Instalar Flatpak
- Adicionar Repositório Flathub
- Converter todos os repositórios (.list) para o formato DEB822 moderno (.sources)
- Localizar todos os repositórios (.sources)
- Garantir que "Enabled yes" esteja definido nos repositórios .sources
- Atualizar cache do APT (apt-get update) e registrar saída
- Detectar URLs dos repositórios com erro crítico
- Localizar repositórios (.sources)
- Ler conteúdo dos repositórios (.sources)
- Inicializar lista de repositórios desabilitados
- Desabilitar repositórios com erro crítico
- Construir lista dos repositórios desabilitados
- Listar os repositórios desabilitados
- Remover arquivos .list (Google Chrome e MEGAsync) existentes (se houver)
- Criar arquivos .list (Google Chrome e MEGAsync) vazios
- Definir atributo imutável para os arquivos .list (Google Chrome e MEGAsync)
```

- ✅ **uninstall-app**
```
- Remover pacotes default que nao serão usados
```

- ✅ **install-app**
```
- Atualizar cache do APT (apt-get update)
- Instalar aplicações dos repositórios APT. Aguarde...
- Instalar tldr via pipx globalmente
- Baixar e instalar Postman e Drawio (flatpak). Aguarde...
- Parar e desabilitar o autostart do Anydesk
```

- ✅ **install-loffice**
```
- Remover pacotes LibreOffice existentes
- Criar diretório para LibreOffice em Downloads
- Baixar pacotes LibreOffice (.tar.gz) com verificação de checksum
- Descompactar arquivos LibreOffice
- Criar lista de pacotes .deb do LibreOffice
- Registrar variavel da lista de pacotes do LibreOffice
- Listar os pacotes do LibreOffice com DEBUG
- Instalar pacotes .deb do LibreOffice
```

- ✅ **conf-all**
```
- Garantir pacotes necessários
- Verificar se o diretório xfce4 existe
- Backup do ~/.config/xfce4 (tar.gz com timestamp)
- Verificar se o arquivo lightdm-gtk-greeter.conf existe
- Backup do /etc/lightdm/lightdm-gtk-greeter.conf (cópia com timestamp)
- Copiar template XFCE4
- Extrair template XFCE4 no diretório correto
- Reiniciar XFCE4 serviços para aplicar mudanças
- Remover arquivo template XFCE4 após aplicar
- Copiar templates do LightDM GTK+ Greeter
- Criar diretório temporário para downloads
- Baixar temas de ícones e cursores
- Descompactar os temas em /usr/share/icons
- Copiar subpastas internas de temas para /usr/share/icons (somente onde necessário)
- Listar temas de cursor disponíveis
- Mostrar temas encontrados
- Criar diretório ~/.icons/default
- Criar arquivo index.theme com tema do cursor
- Criar ou atualizar arquivo .Xresources com tema do cursor
- Baixar fontes Ubuntu
- Descompactar fontes Ubuntu
- Remover pasta __MACOSX após extração (se existir)
- Atualizar cache de fontes
- Criar diretório ~/Imagens/wallpapers do usuário
- Baixar wallpapers
- Backup do .bashrc (cópia com timestamp)
- Copiar script custom_bashrc.sh para o guest
- Executar script custom_bashrc.sh no guest
- Remover script custom_bashrc.sh após aplicar
- Garantir 1 linha em branco antes de inserir HISTORY_TIME (no EOF)
- Inserir data e hora no histórico do bash (no EOF)
- Reiniciar sistema para aplicar mudanças na interface gráfica
```

- ✅ **aws-cli**
```
- Instalar Python3 pip
- Verificar se EXTERNALLY-MANAGED existe
- Fazer backup do EXTERNALLY-MANAGED
- Remover arquivo EXTERNALLY-MANAGED original
- Instalar boto e awscli
- Testar AWS CLI
- Mostrar versão do AWS CLI
- Criar diretório ~/.aws
- Criar arquivo de credenciais AWS com multiplos perfis
- Criar arquivo de configuração AWS com multiplos perfis
- Criar diretório ~/.ssh
- Copiar chave SSH
```

- ✅ **create-user**
```
- Debug new_user
- Criar conta de usuários
- Forçar usuários a alterar a senha no primeiro login
```

- ✅ **uninstall-app**
```
- Debug delete_user
- Remover contas de usuários
```

## 📄 Ordem de execução das Roles

- **Atualizar release Debian 12 / Debian 13** → update-upgrade-app | dist-upgrade
 - **Pós instalar Debian 13** → add-repo | uninstall-app | install-app | install-loffice | conf-all | aws-cli
 - **Administrar sistema** → create-user | remove-user

## ▶️ Fluxo de Funcionamento

1. Clonar o repositório.

```
git clone https://github.com/glaubergf/ansible-debian-workstation.git
cd ansible-debian-workstation
```

2. Editar o inventário (hosts) e variáveis conforme o ambiente.

3. Executar o playbook completo. Comente a linha no arquivo *main.yml* caso não queira que alguma role seja executada.

```
ansible-playbook -i hosts main.yml
```

4. Executar role específica (ex: install-loffice).

```
ansible-playbook -i hosts main.yml -t install_loffice
```

5. Usar ansible-vault para roles com variáveis sensíveis (ex.: aws-cli).

```
ansible-vault encrypt roles/aws-cli/vars/main.yml
ansible-playbook --ask-vault-pass -i hosts main.yml -t aws_cli
```

## 🤝 Contribuições

Contribuições são bem-vindas!

## 📜 Licença

Este projeto está licenciado sob os termos da **[GNU General Public License v3](https://www.gnu.org/licenses/gpl-3.0.html)**.

### 🏛️ Aviso Legal

```
Copyright (c) 2025

Este programa é software livre: você pode redistribuí-lo e/ou modificá-lo
sob os termos da Licença Pública Geral GNU conforme publicada pela
Free Software Foundation, na versão 3 da Licença.

Este programa é distribuído na esperança de que seja útil,
mas SEM NENHUMA GARANTIA, nem mesmo a garantia implícita de
COMERCIALIZAÇÃO ou ADEQUAÇÃO A UM DETERMINADO FIM.

Veja a Licença Pública Geral GNU para mais detalhes.
```
