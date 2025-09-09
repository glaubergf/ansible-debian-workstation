Duas soluções (mínimo e full) com script pronto para export e apply

1. Template mínimo (somente essencial)

Inclui:

✔ Painel (estrutura + plugins)
✔ Configurações de aparência (tema GTK, ícones, cursor, fontes)
✔ Papel de parede e ícones da área de trabalho
✔ Config do gerenciador de janelas (xfwm4)
Pastas e arquivos incluídos:

~/.config/xfce4/xfconf/xfce-perchannel-xml/
~/.config/xfce4/panel/

Script: xfce4-template-minimal.sh

#!/bin/bash

TEMPLATE_DIR="$HOME/xfce4-template-minimal"
BACKUP_FILE="$HOME/xfce4-template-minimal.tar.gz"

export_template() {
    echo "[INFO] Exportando template mínimo do XFCE4..."
    mkdir -p "$TEMPLATE_DIR"
    cp -r ~/.config/xfce4/xfconf/xfce-perchannel-xml "$TEMPLATE_DIR/"
    cp -r ~/.config/xfce4/panel "$TEMPLATE_DIR/"
    tar czvf "$BACKUP_FILE" -C "$HOME" "$(basename "$TEMPLATE_DIR")"
    echo "[INFO] Template salvo em: $BACKUP_FILE"
}

apply_template() {
    echo "[INFO] Aplicando template mínimo no XFCE4..."
    tar xzvf "$BACKUP_FILE" -C "$HOME/"
    xfce4-panel --restart
    xfdesktop --reload
    xfsettingsd --replace &
    echo "[INFO] Template aplicado com sucesso!"
}

case "$1" in
    export)
        export_template
        ;;
    apply)
        apply_template
        ;;
    *)
        echo "Uso: $0 {export|apply}"
        ;;
esac

################ 

2. Template full (toda pasta do XFCE4)

Inclui:

✔ Tudo que está no minimal
✔ Config do terminal XFCE
✔ Sessão e autostart
✔ Histórico e caches (que podem ser irrelevantes)
Script: xfce4-template-full.sh

#!/bin/bash

TEMPLATE_DIR="$HOME/xfce4-template-full"
BACKUP_FILE="$HOME/xfce4-template-full.tar.gz"

export_template() {
    echo "[INFO] Exportando template FULL do XFCE4..."
    mkdir -p "$TEMPLATE_DIR"
    cp -r ~/.config/xfce4 "$TEMPLATE_DIR/"
    tar czvf "$BACKUP_FILE" -C "$HOME" "$(basename "$TEMPLATE_DIR")"
    echo "[INFO] Template salvo em: $BACKUP_FILE"
}

apply_template() {
    echo "[INFO] Aplicando template FULL no XFCE4..."
    tar xzvf "$BACKUP_FILE" -C "$HOME/"
    xfce4-panel --restart
    xfdesktop --reload
    xfsettingsd --replace &
    echo "[INFO] Template aplicado com sucesso!"
}

case "$1" in
    export)
        export_template
        ;;
    apply)
        apply_template
        ;;
    *)
        echo "Uso: $0 {export|apply}"
        ;;
esac

################

Qual é mais indicado?

Depende do nível de controle e onde vai aplicar:

    Minimal → Melhor para:
        Ambientes diferentes (monitores diferentes, resoluções diferentes).
        Evitar configs desnecessárias e possíveis bugs.
        Manter apenas aparência, painel e papel de parede.
        Mais limpo, mais seguro para template genérico.

    Full → Melhor para:
        Clonar 100% igual (laboratórios, VMs padronizadas, mesmo hardware).
        Pós-instalação em um parque homogêneo.
        Você não se importa com alguns arquivos inúteis.

A recomendação:
Usar o minimal como padrão. É mais limpo e cobre exatamente o: painel, tema, ícones, papel de parede.
Só use o full se for clonar ambientes idênticos.
