#!/bin/bash

BACKUP_FILE="$HOME/xfce4-template-full.tar.gz"

export_template() {
    echo "[INFO] Exportando template FULL do XFCE4..."
    tar czvf "$BACKUP_FILE" -C "$HOME/.config" xfce4
    echo "[INFO] Template salvo em: $BACKUP_FILE"
}

apply_template() {
    echo "[INFO] Aplicando template FULL no XFCE4..."
    tar xzvf "$BACKUP_FILE" -C "$HOME/.config/"
    echo "[INFO] Reiniciando serviços XFCE..."
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
