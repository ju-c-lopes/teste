# Verificar se é o terminal integrado do VSCODE
if [[ "$TERM_PROGRAM" == "vscode" ]]; then
    # O usuário deve trocar <interpretador> por seu interpretador anaconda default do vscode
    conda deactivate && conda activate <interpretador>
else
    

    # Obter a lista de ambientes virtuais
    echo "Selecione o ambiente virtual: " $'\n'

    # O usuário deve trocar <user> pelo nome do seu usuário
    environments=($(ls /home/<user>/anaconda3/envs)) 

    options=("base")  # Adiciona a opção padrão

    # Adicionar as opções dos ambientes virtuais
    for env in "${environments[@]}"; do
        options+=("$env")
    done

    # Imprime a lista de ambientes virtuais para que o usuário faça sua escolha
    for ((i=1; i<=${#options[@]}; i++)); do
        echo "$i ${options[i - 1]}"
    done

    # Função que capturará o input de escolha do usuário
    select_option() {
        read -r choice
        if [[ -z "$choice" ]]; then 
            # Condição if para capturar um Enter
            opt="base"
        elif [[ ! "$choice" =~ ^[0-9]+$ || "$choice" -lt 1 || "$choice" -gt ${#options[@]} ]]; then
            # Condição para identificar opções inválidas
            echo "Opção Inválida"
            tela="Escolha números entre "
            for ((i=1; i<=${#options[@]}; i++)); do
                tela+="$i, "
            done
            tela+="ou tecle Enter para opção padrão."
            echo "$tela"
            select_option
        else
            # Condição para armazenar a escolha feita
            opt="${options[choice-1]}"
        fi
    }

    # Chamando a função de entrada do usuário
    select_option

    # A opção que será selecionada de acordo com a escolha do usuário
    case $opt in
        "base")
            conda activate base  # Substitua pelo caminho do seu ambiente virtual 
            ;;
        *)
            conda deactivate && conda activate $opt  # Substitua pelo caminho do seu ambiente virtual
            ;;
        *) echo "Opção inválida";;
    esac
fi
