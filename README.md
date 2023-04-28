Este script em bash usa as ferramentas msfvenom e steghide para criar um shell reverso em um arquivo MP4. 
Ele também usa o servidor netcat para receber a conexão reversa do shell.

Para executar o script:

chmod +x mp4shell.sh
./mp4shell.sh

O script solicitará que você insira o endereço IP do servidor, a porta e o caminho completo do arquivo MP4. 
Depois disso, ele gerará um shell reverso ofuscado, incorporará o código executável do shell reverso no arquivo MP4, 
iniciará um servidor netcat para escutar a porta especificada e aguardará a vítima abrir o arquivo MP4. 
Quando a vítima abrir o arquivo MP4, o shell reverso será executado e se conectará ao servidor netcat.

Por fim, o script decodificará e executará o shell reverso decodificado usando o Wine.

Requisitos:
wine - base64 - netcat ou nc (dependendo da sua distribuição Linux).

Kali Linux:
sudo apt update
sudo apt install wine wine32 wine64 netcat-traditional
