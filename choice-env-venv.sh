# Verificar se é o terminal integrado do VSCODE
if [[ "$TERM_PROGRAM" == "vscode" ]]; then
    # O usuário deve trocar <interpretador> por seu interpretador anaconda default do vscode
    echo "vscode"
    . <nome-ambiente>/bin/activate
else
    # Busca por ambientes virtuais a partir da home
    listenv=()
    output=$(find ~ | grep bin/activate$)
    IFS=$'\n' read -rd '' -a listenv <<< "$output"
    unset output

    envs=()
    fullenvs=()

    for env in "${listenv[@]}"; do
        IFS='/'
        read -ra arr <<< $env
        path=""
        for ((i=0;i<${#arr[@]}-2;i++)); do
            if [[ $i -lt ${#arr[@]}-2 ]]; then
                path+="${arr[i]}"
                if [[ $i -ne ${#arr[@]}-3 ]]; then
                    path+="/"
                fi
            fi
            if [[ $i -eq ${#arr[@]}-3 ]]; then
                envs+=(${arr[i]})
            fi
        done
        fullenvs+=("$path")
    done
    unset path listenv

    # Obter a lista de ambientes virtuais
    echo "Selecione o ambiente virtual: " $'\n'
    

    # Imprime a lista de ambientes virtuais para que o usuário faça sua escolha
    for ((i=1; i<=${#envs[@]}; i++)); do
        echo "$i ${envs[i - 1]}"
    done

    # Função que capturará o input de escolha do usuário
    select_option() {
        read -r choice
        if [[ -z "$choice" ]]; then 
            # Condição if para capturar um Enter
            opt="none"
        elif [[ ! "$choice" =~ ^[0-9]+$ || "$choice" -lt 1 || "$choice" -gt ${#envs[@]} ]]; then
            # Condição para identificar opções inválidas
            echo "Opção Inválida"
            tela="Escolha números entre "
            for ((i=1; i<=${#envs[@]}; i++)); do
                tela+="$i, "
            done
            tela+="ou tecle Enter para opção padrão."
            echo "$tela"
            select_option
        else
            # Condição para armazenar a escolha feita
            opt="${fullenvs[choice-1]}"
        fi
    }

    # Chamando a função de entrada do usuário
    select_option

    unset envs fullenvs

    # A opção que será selecionada de acordo com a escolha do usuário
    case $opt in
        "none")
            echo ''
            ;;
        *)
            . "$opt"/bin/activate  # Substitua pelo caminho do seu ambiente virtual
            ;;
        *) echo "Opção inválida";;
    esac
fi
