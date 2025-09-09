#!/bin/bash

BACKUP_FILE="$HOME/xfce4-template-minimal.tar.gz"

export_template() {
    echo "[INFO] Exportando template mínimo do XFCE4..."
    tar czvf "$BACKUP_FILE" -C "$HOME/.config" \
        xfce4/xfconf/xfce-perchannel-xml \
        xfce4/panel
    echo "[INFO] Template salvo em: $BACKUP_FILE"
}

apply_template() {
    echo "[INFO] Aplicando template mínimo no XFCE4..."
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
