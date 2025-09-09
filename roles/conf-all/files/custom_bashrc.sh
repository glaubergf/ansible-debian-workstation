#!/bin/bash

BASHRC="$HOME/.bashrc"
PS1_MARKER="# PS1 customizado pelo role conf_all do Ansible"

# PS1 customizado (duas linhas)
CUSTOM_PS1_START='    PS1="┌──────── \[\e[0;36m[\u@\h]\e[m\] \[\e[0;35m[\t]\e[m\] \[\e[1;33m[\w]\e[m\] ➤ \`if [ \$? = 0 ]; then echo -e '\''\e[32m😀 ✔\e[m'\'' ; else echo '\''\e[31m🙁 ✘\e[m'\'' ; fi\` \n└─── ➤➤➤ \$ "'

# Se já foi modificado, não faz nada
if grep -q "$PS1_MARKER" "$BASHRC"; then
    echo "PS1 já foi modificado anteriormente. Nada a fazer."
    exit 0
fi

# Flags de estado
inside_if=0
ps1_handled=0

TEMP_BASHRC=$(mktemp)

while IFS= read -r line; do
    trimmed="$(echo "$line" | sed 's/^[[:space:]]*//')"

    # Detecta início do bloco "if [ "$color_prompt" = yes ]; then"
    if [[ "$trimmed" == 'if [ "$color_prompt" = yes ]; then' ]]; then
        inside_if=1
    fi

    # Dentro do bloco: quando encontrar o PS1 original, comenta e injeta novo
    if [[ $inside_if -eq 1 && $ps1_handled -eq 0 && "$trimmed" == PS1=* ]]; then
        echo "    # $trimmed" >> "$TEMP_BASHRC"
        echo "    $PS1_MARKER" >> "$TEMP_BASHRC"
        echo "$CUSTOM_PS1_START" >> "$TEMP_BASHRC"
        ps1_handled=1
    else
        echo "$line" >> "$TEMP_BASHRC"
    fi

    # Detecta fim do bloco
    if [[ $inside_if -eq 1 && "$trimmed" == 'else' ]]; then
        inside_if=0
    fi
done < "$BASHRC"

mv "$TEMP_BASHRC" "$BASHRC"
echo "PS1 customizado com sucesso dentro do bloco 'if [ \"\$color_prompt\" = yes ]; then'."
