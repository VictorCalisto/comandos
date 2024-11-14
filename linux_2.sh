#!/bin/bash

###############################
# Comandos:

cd # Vai para o home

cd ~ # Vai para o home

cd - # Retorna ao diretório anterior

ls # Lista arquivos e pastas

ls -a # Lista tudo, até o que está oculto

# ls -al traz informações detalhadas em bytes, e é preciso colocar um "h" para dizer que é legível para humanos. Logo, ls -alh é a mesma coisa que ls -lha

ls -lha # Lista tudo de forma detalhada

history # Histórico de comandos = seta para cima

mkdir # Cria um diretório

mkdir -p pasta1/pasta2/pasta3 # Permite criar toda a árvore de uma vez só

pwd # Caminho do diretório atual

clear # Limpar terminal = control + L

ls -F # Mostra o tipo do arquivo. / - pasta, @ - link simbólico, * - executável

rm # Remove arquivos

rm dir # Remove diretórios vazios

rm -rf # Remove diretórios, subdiretórios e arquivos internos

cat # Visualiza o arquivo (no Windows é o comando "type")

cat -s # Oculta linhas em branco

cat -n # Enumera as linhas

zcat teste.z # Visualiza arquivos compactados

cp # Copia o arquivo

mv # Move o arquivo

touch arquivo.txt # Cria um arquivo vazio. Você tem que colocar a extensão (txt, por exemplo).

touch -t arquivo.txt # Altera o quando o arquivo foi criado ou acessado.

date # Exibe a data

date -u # Exibe a data em UTC

date -s "YYYY-MM-DD hh:mm:ss" # Edita data e hora do sistema, hora em formato de 24h

df # Mostra o espaço livre em cada partição da raiz

df -h # Mostra o espaço legível para humanos

df -Th # Mostra também o sistema utilizado em cada partição

head arquivo.txt # Mostra as 10 primeiras linhas do arquivo.

head -n 3 arquivo.txt # Mostra as 3 primeiras linhas do arquivo

less arquivo.txt # Ler arquivos

more arquivo.txt # Ler arquivo de forma mais simples

sort -n # Ordena o arquivo

sort -k2 # Ordena pela segunda coluna

sort -t ':' -k2 # Define o caractere ":" como separador da coluna 1 e da coluna 2. Se não for definido, o separador natural é o espaço.

tail arquivo.txt # Mostra as 10 últimas linhas do arquivo. Útil para ver logs de erros

tail -f # Segue o fim do arquivo. Conforme ele vai gerando mais linhas no final, ele vai mostrando as linhas geradas.

trai -n 50 # Mostra as últimas 50 linhas do arquivo.

time ls # Executa o comando ls e mostra no final o tempo que demorou para executar o comando ls

uptime # Mostra há quanto tempo a máquina está ligada.

echo # Exibe uma mensagem na tela

echo -n # Não faz quebra de linha

su # Pede a senha do root para que o usuário se torne root e tenha privilégios de root.

sudo # Pede a senha do usuário para que o usuário tenha privilégios de root.

# /bin/su - é mais seguro para acessar o root com o bin. O "-" é para fazer login

adduser $NOME_DO_USUARIO sudo # Torna o usuário administrador, mas abaixo do root

deluser $NOME_DO_USUARIO sudo # Desce o usuário de administrador.

# Depois de usar os comandos adduser e deluser, o usuário $NOME_DO_USUARIO tem que deslogar e logar novamente. Ou forçar o logout desse usuário com:

pkill -KILL -u $NOME_DO_USUARIO # Esse comando mata todos os processos do $NOME_DO_USUARIO, o que força ele a refazer o login. Se possível, peça para ele refazer o login em vez de usar esse comando.

killall -u $NOME_DO_USUARIO # Mata todos os processos do usuário

kill -9 $(ps -u $NOME_DO_USUARIO -o pid=) # Mata o processo diretamente na memória

uname -a # Retorna os dados do sistema operacional

| # O pipe "|" alimenta o comando à direita com a saída do comando à esquerda. Útil para combinar comandos.

ps ax # Pega todos os processos de todos os usuários

ps aux # Filtra por usuário

ps axf # Diz qual processo chamou qual.

kill -9 $PID # Mata o processo diretamente na memória (também é o mesmo que kill -KILL $PID)

kill -HUP $PID # É o mesmo que kill -1. Recarrega os arquivos de configuração sem finalizar.

kill -15 $PID # Finaliza de forma amigável. (kill -TERM $PID)

# killall5 -9 # Mata todos os processos. Nunca use!

top # Mostra em tempo real o que está sendo usado na máquina

ping $NUMERO_DO_IP_OU_NOME_DO_DNS # Testa a conexão

sudo chown -R novo_usuario:novo_grupo /caminho/para/diretorio # Muda o dono da pasta ou arquivo.

###############################

# top (Table of Processes): Exibe uma visão em tempo real dos processos em execução, mostrando detalhes como PID, uso de CPU e memória, e o estado dos processos.
top
# Para sair do top, pressione 'q'.

# ps (Process Status): Fornece uma "fotografia" dos processos em execução no momento.
# Algumas opções úteis são:
ps

# ps aux (All Users Extended): Lista todos os processos em execução com detalhes extensivos, como %CPU, %MEM, PID, entre outros.
ps aux

# ps -u [usuario] (User): Filtra e exibe apenas os processos pertencentes ao usuário especificado.
# Exemplo: ps -u root
ps -u root

# ps -p [PID] (Process ID): Exibe informações detalhadas sobre um processo específico com o PID fornecido.
# Exemplo: ps -p 1234
ps -p 1234

# ps -C [comando] (Command): Filtra e exibe os processos associados ao comando especificado.
# Exemplo: ps -C firefox
ps -C firefox

# pstree (Process Tree): Mostra a árvore de processos, ilustrando a relação hierárquica entre processos pai e filho.
pstree

# head (Head of File): Exibe as primeiras linhas de um arquivo ou saída de um comando.
# Por padrão, exibe as primeiras 10 linhas.
# Exemplo: Exibir as 10 primeiras linhas de um arquivo:
head /var/log/syslog

# pipe (|) (Pipe): Redireciona a saída de um comando como entrada para outro comando.
# É utilizado no encadeamento de comandos e processamento de dados de modo sequencial.
# Exemplo: Comando que lista todos os arquivos e passa para o head para exibir apenas os 10 primeiros.
ls -l | head

# sort (Sort): Ordena a saída de um comando ou o conteúdo de um arquivo.
# Pode ser combinado com outros comandos usando pipe para organizar dados.
# Exemplo: Ordenar uma lista de arquivos por tamanho:
ls -l | sort -n -k5

# kill (Kill Process): Envia sinais para processos em execução. Alguns exemplos de uso:

# kill [PID] (Process ID): Envia o sinal padrão de interrupção (SIGTERM) para o processo com o PID especificado.
# Este comando permite uma interrupção suave do processo.
# Exemplo: kill 1234
kill 1234

# kill -9 [PID] (Signal 9): Envia um sinal de interrupção abrupta (SIGKILL) para o processo com o PID especificado.
# Este comando força o encerramento imediato do processo.
# Exemplo: kill -9 1234
kill -9 1234

# kill -STOP [PID] (Stop Signal): Envia um sinal de pausa (SIGSTOP) para o processo, interrompendo sua execução.
# O processo continua em execução, mas suspenso até receber um sinal de continuação.
# Exemplo: kill -STOP 1234
kill -STOP 1234

# kill -CONT [PID] (Continue Signal): Envia um sinal de continuação (SIGCONT) para retomar a execução de um processo que foi pausado.
# Exemplo: kill -CONT 1234
kill -CONT 1234

# pkill (Process Kill): Envia sinais para processos com base no nome do processo.
# Todos os processos que correspondem ao nome fornecido serão afetados.
# Exemplo: pkill firefox
pkill firefox

# killall (Kill All): Envia sinais para todos os processos com um nome específico.
# Este comando é útil para enviar sinais a múltiplos processos de forma simultânea.
# Exemplo: killall firefox
killall firefox

# Apaga um arquivo específico
rm arquivo.txt

# Apaga diretórios e arquivos de forma recursiva e forçada
rm -rf pasta/

# Visualiza um arquivo no terminal
cat arquivo.txt

# Visualiza um arquivo compactado (gzip por exemplo)
zcat arquivo.gz

# Cria um arquivo vazio
touch arquivo.txt

# Cria um diretório
mkdir novo_diretorio

# Mostra o caminho completo do diretório atual
pwd

# Limpa a tela do terminal
clear

# Verifica se um diretório existe ou não
if [ -d "/diretorio" ]; then
  echo "O diretório existe!"
else
  echo "O diretório não existe!"
fi

# Exibe informações sobre o sistema
uname -a

# Verifica todos os processos ativos
ps aux

# Visualiza os processos de um usuário específico
ps -u usuario

# Mata um processo pelo PID
kill 1234

# Força a finalização de um processo com o sinal SIGKILL
kill -9 1234

# Exibe os processos de forma hierárquica
pstree

# Envia sinal de pausa a um processo
kill -STOP 1234

# Envia sinal para retomar a execução de um processo pausado
kill -CONT 1234

# Usando o pipe '|' para redirecionar a saída de um comando para outro
ls -l | grep "teste"

# Redireciona a saída de um comando para um arquivo
echo "Texto para o arquivo" > arquivo.txt

# Anexa a saída de um comando a um arquivo existente
echo "Texto adicional" >> arquivo.txt

# Exibe as 10 primeiras linhas de um arquivo
head arquivo.txt

# Exibe as 10 últimas linhas de um arquivo
tail arquivo.txt

# Exibe as linhas de um arquivo, mostrando ao vivo conforme elas são adicionadas
tail -f arquivo.log

# Busca recursivamente por um arquivo em um diretório
find /caminho/para/diretorio -name "arquivo.txt"

# Busca por um arquivo do tipo PDF dentro de um diretório
find /home -type f -name "*.pdf"

# Busca por um arquivo e ignora a distinção entre maiúsculas e minúsculas
grep -i "termo" arquivo.txt

# Pesquisa por uma string dentro de arquivos
grep "texto" arquivo.txt

# Pesquisa recursiva em um diretório
grep -r "termo" /diretorio

# Mostra os arquivos onde o termo foi encontrado
grep -l "texto" *

# Exibe uma mensagem personalizada se o arquivo não contiver o termo
grep -v "erro" arquivo.txt

# Cria um novo usuário no sistema
adduser nome_usuario

# Adiciona um usuário ao grupo sudo (admin)
adduser nome_usuario sudo

# Remove um usuário do grupo sudo
deluser nome_usuario sudo

# Mata todos os processos de um usuário específico
pkill -KILL -u nome_usuario

# Altera a propriedade de um arquivo ou diretório
sudo chown usuario:grupo arquivo.txt

# Altera permissões de leitura, escrita e execução para o proprietário, grupo e outros
chmod 755 arquivo.sh

# Torna um arquivo imutável (não pode ser deletado ou alterado)
chattr +i arquivo.txt

# Verifica os atributos de um arquivo
lsattr arquivo.txt

# Remove o atributo de imutabilidade de um arquivo
chattr -i arquivo.txt

# Atualiza a lista de pacotes
sudo apt-get update

# Instala um pacote
sudo apt-get install nome_pacote

# Remove um pacote
sudo apt-get remove nome_pacote

# Verifica se um pacote está instalado
dpkg -l | grep nome_pacote

# Atualiza todos os pacotes instalados
sudo apt-get upgrade

# Remove pacotes não necessários
sudo apt-get autoremove

# Verifica a conectividade com outro host via IP ou URL
ping google.com

# Exibe a rota que os pacotes estão seguindo até um destino
traceroute google.com

# Conecta-se a uma máquina remota via SSH
ssh usuario@ip_do_servidor

# Copia um arquivo para um servidor remoto via SCP
scp arquivo.txt usuario@ip_do_servidor:/caminho/destino/

# Copia um diretório recursivamente para um servidor remoto
scp -r /pasta usuario@ip:/destino

# Exibe o uso de CPU, memória e outros recursos do sistema em tempo real
top

# Exibe o uso de espaço em disco
df -h

# Exibe detalhes sobre a memória do sistema
free -h

# Exibe a quantidade de memória utilizada e a quantidade de swap
vmstat

# Exibe informações detalhadas sobre o sistema
dmesg

# Exibe as últimas mensagens do sistema
tail -f /var/log/syslog

# Desliga o sistema imediatamente
shutdown -h now

# Reinicia o sistema imediatamente
shutdown -r now

# Desliga o sistema após 30 minutos
shutdown -h +30

# Reinicia o sistema após 30 minutos com uma mensagem
shutdown -r +30 "O sistema será reiniciado em 30 minutos!"

# Cancela um shutdown ou reboot agendado
shutdown -c "Desligamento cancelado!"

if [ $var -eq 5 ]  # Usando um único colchete [ ... ] para testar a expressão. Esse é um comando externo (test) que compara valores. Deve-se ter cuidado com espaços e variáveis com caracteres especiais, que podem causar erros.
 
[[ $var -eq 5 ]]   # Usando dois colchetes [[ ... ]] no Bash, que oferecem mais funcionalidades, como suporte a expressões regulares, maior flexibilidade em comparação de strings e melhor manipulação de variáveis com espaços. É mais seguro e não precisa de aspas para variáveis com espaços.

# Usando um único colchete [ ... ] (comando `test`)
if [ $var -eq 5 ]; then  # Compara se a variável $var é igual a 5.
    echo "var é igual a 5"
fi

# Se a variável contiver espaços ou caracteres especiais, deve-se colocar a variável entre aspas para evitar erros:
if [ "$var" == "algum valor com espaços" ]; then
    echo "Isso vai funcionar"
fi

# Usando dois colchetes [[ ... ]] (comando built-in no Bash)
if [[ $var == "algum valor com espaços" ]]; then  # Não é necessário colocar as variáveis entre aspas, pois o Bash já lida melhor com espaços e caracteres especiais.
    echo "Isso vai funcionar sem aspas!"
fi

# Usando dois colchetes para expressões regulares com =~
regex="^abc"
if [[ $1 =~ $regex ]]; then  # Usando =~ para verificar se a variável $1 corresponde à expressão regular.
    echo "A variável $1 corresponde ao regex"
fi
