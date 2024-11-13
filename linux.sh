#!/bin/bash

###############################
# Comandos:
cd # vai para o home
cd ~ # vai para o home
cd - # retorna ao diretorio anterior
ls # lista arquivos e pastas
ls -a # lista tudo, ate o que esta oculto
# ls -al tras informacoes detralhadas em bytes e é preciso colocar um h para dizer que é legivel pra "humanos" logo ls -alh e mesmo que ls -lha
ls -lha # lista tudo de forma detalhada
history # historico de comandos = seta pra cima
mkdir # cria um diretorio
mkdir -p pasta1/pasta2/pasta3 # permite criar toda a arvore de uma vez so 
pwd # caminho do diretorio atual
clear # limpar terminar = control + L
ls -F # mostra o tipo do arquivo. /-pasta @-linksimbolico *-executavel
rm # remove arquivos
rm dir # remove diretorios vazios
rm -rf # remove diretorios e subdiretorios e arquivos internos
cat # vizualiza o arquivo // o windows e tap
cat -s # oculta linhas em branco
cat -n # enumera as linhas
zcat teste.z # vizualiza arquivos compactados
cp # copia o arquivo
mv # move o arquivo
touch arquivo.txt # cria um aquivo vazio. voce tem que colocar a extensao. txt por exemplo.
touch -t arquivo.txt # altera o quando o arquivo foi criado ou acessado.
date # exibe data
date -u # exibe o date em utc
date -s "YYYY-MM-DD hh:mm:ss" # edita data e hora do sistema, hora em formato de 24 h
df # mostra o espaco livre em cada particao da raiz
df -h # mostra o espaco legivel para humanos
df -Th # mostra tambem o sistma utilizado em cada particao
head arquivo.txt # mostra as 10 primeiras linhos do arquivo.
head -n 3 arquivo.txt # mostra as 3 primeiras linhas do arquivo
less arquivo.txt # ler arquivos
more arquivo.txt # ler arquivo piorado
sort -n # ordena o arquivo
sort -k2 # ordena pela segunda coluna
sort -t ':' -k2 # define o caractere : como um separador da coluna 1 e da coluna 2. se ele nao for definido o separador natural e o espaco.
tail arquivo.txt # mostra as 10 ultimas linhas do arquivo. util pra ver logs de erros
tail -f # segue o fim do arquivo. conforme ele vai gerando mais linhas no final ele vai mostrando as linahas geradas.
trai -n 50 # mostra as ultimas 50 linhas do arquivo.
time ls # executa o comando ls e mostra no final o tempo que demorou para executar o comando ls
uptime # mostra a quanto tempo a maquina esta ligada.
echo # exibe uma mesagem na tela
echo -n # faz quebra de linha
su # pede a SENHA DO ROOT para que o usuario se torne root e tenha privielegio de root.
sudo # pede a SENHA DO USUARIO para que o usuario tenha privilegios de root.
/bin/su - # e mais seguro  para acessar o root com o bin. O - e para fazer login
adduser $NOME_DO_USUARIO sudo # sobre o usuario para administrador, mas abaixo do root
deluser $NOME_DO_USUARIO sudo # desce o usuario de administrador.
# depois do root usar os comandos adduser e deluser os usuarios $NOME_DO_USUARIO tem que deslogar e logar novamente. ou forcar o logout desse usuario com
pkill -KILL -u $NOME_DO_USUARIO # esse comando mata todos os processos do $NOME_DO_USUARIO, o que forca ele a refazer o login. Se possivel peca para ele refazer o login em vez de usar esse comando.
killall -u $NOME_DO_USUARIO
kill -9 $(ps -u $NOME_DO_USUARIO -o pid=)
uname -a # retorna os dados do sistema operacinal
| # O taipe '|' alimenta o comando a direita com a saida do comando a esquerda. util para combinar comandos.
ps ax # pega todos os procesos de todos os usuarios
ps aux # filtra por usuario
ps axf # diz qual processo chamou qual.
kill -9 $PID # mata o processo direto na memoria # e o mesmo kill -KILL $PID
kill -HUP $PID # e o mesmo kill -1. # rele os arquivos de configuracao sem finalizar.
kill -15 $PID # finaliza de forma amigavel. # kill -TERM $PID
# killall5 -9 # mata todos os processos todos mesmos nunca use.
top # mostra em tempo real o que esta sendo usado na maquina
ping $NUMERO_DO_IP_OU_NOME_DO_DNS # testa a conexao

# top (Table of Processes): Exibe uma visão em tempo real dos processos em execução,
# mostrando detalhes como PID, uso de CPU e memória e o estado dos processos.
top
# Para sair do top, pressione 'q'.

# ps (Process Status): Fornece uma "fotografia" dos processos em execução no momento.
# Algumas opções úteis são:
ps

# ps aux (All Users Extended): lista todos os processos em execução com detalhes extensivos,
# como %CPU, %MEM, PID, entre outros.
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

###############################







###############################
###
diff arquivo1 arquivo2 # compara as diferencas entre dois arquivos.
diff -u arquivo1 arquivo2 # tras um retorno mais humano
-r # compara as pastas com um retorno mais humano.
-q # compara diretorios por nomes de arquivos sem entrar nos arquivos
-U # mostra o numero da linha onde ta a diferenca
-w # ignora espacos em branco e quebra de linha
###
chattr # altera atributos
+i # torna o arquivo/diretorio imultavel, o que inclui impossivel de deleçao
-i # torna multavel de novo.
+a # permite apenas acresimo. algo novo entra, mas nao pode editar/apagar/sobrescrever algo velho.
isattr # lista atributos
###
find $PATH_DA_PASTA_QUE_DESEJA_PROCURA -maxdepth $NUMERO_COM_A_QUANTIDADE_MAXIMA_DE_SUB_DIRETORIOS_PARA_PROCURAR -type $f_PARA_ARQUIVOS_E_d_PARA_PASTAS -name "$NOME_DO_QUE_DESEJA_PROCURAR"
find . -maxdepth 5 -type f -name '*.pdf'
-mtime -$NUMERO_DE_DIAS_ATE_ULTIMA_MODIFICACAO
-mtime +$NUMERO_DE_DIAS_A_PARTIR_ULTIMA_MODIFICACAO
-ctime -$NUMERO_DE_DIAS_DA_CRIACAO
-amim -$NUMERO_DE_MINUTOS_DO_ULTIMO_ACESSO
###
grep "$TEXTO_COM_O_QUE_DESEJA_PESQUISAR" $PATH_DA_PASTA_OU_ARQUIVO_ONDE_SERA_PESQUISADO
grep -ri 'texto' .
-v # pesquisa tudo que NAO TEM o texto
-i # ignora diferenca entre maiuscula e minuscula
-E 'ˆtexto' # aceita uma expressao regular.
-F '*.pdf' # pesquisa por caracteres especiais como o asteisco, em ves de usa-lo como um curinga
-l # lista somente o nome dos arquivos, sem oconteudo
-r # busca recursivamente nos sub diretorios
###
###############################







# INSTALADOS A PARTE
# AWK # filtro util para o grep #
awk --version # verifica se ja esta instalado
sudo apt-get install gawk # instala se ja nao esta instalado
awk '{print}' ARQUIVO # mostra o arquivo todo
ls -la | awk '{print $NUMERO_DA_COLUNA}' # filtra pela coluna numero 1, por exemplo
awk -F '$CARACTERE_SEPARADOR' '{print $NUMERO_DA_COLUNA}' ARQUIVO # separa as colunas pela presenca do caracter especidicado.
# CURL # tras informacoes dos arquivos e paginas da web. pode baixar mas o wget e mais recomendado pra isso.
curl --version
sudo apt-get install curl
curl -O exemplo-de-url.com/nome-do-arquivo
curl -o novo-nome exemplo-de-url.com/antigo-nome
# WGET # baixa arquivos, ate midia e zip
wget --version
sudo apt-get install wget
wget -O novo-nome exemplo-de-url.com/antigo-nome
# SSH # libera o acesso remoto # tem que configurar a maquina as vezes
ssh -v # isso é executado dentro do servidor.
sudo apt-get install -y openssh-server # lembrese de expor a porta 22. ssh tem que ser na porta 22.
ssh nomedousuario@enderecodohost # depois desse passo uma senha sera solicitada
-p 3000 # para expecificar uma porta padrao. a porta interna sempre e 22 mas a externa, que liga com a interna, pode ser outra.
-X # permite ligar ao x11 e ter interface grafica. mas nao é uma boa pratica em servidores.
# SCP # é instalado junto com ssh. # a logica de funcionamento é ORIGEM => DESTINO
scp [OPÇÕES] [usuário da origem@IP]:[localização do arquivo] [usuário do destino@IP]:[diretório destino]
#opcoes sao
-r # transfere pastas e subpastas
-P # especifica a porta, a padrao e 22 igual o ssh
#exemplos
scp -r /caminho/do/aquivo/para/baixar usuarioDaMaquinaLocal@$IP_DA_MAQUINA_LOCAL:/caminho/para/salvar # acessando do servidor
scp -P 3000 -r usuario@dnsdamaquina:/caminho/do/aquivo/para/baixar /caminho/para/salvar # acessando locamente.


###############################
# Diretorios Linux
/bin # Binários de usuários, essenciais no boot
/sbin # Binários do superusuário, essenciais no boot
/boot # Arquivo do gerenciador de partida e kernel, símbolos
/dev # Dispositivos do sistema
/etc # Arquivos de configuração globais
/home # Armazenamento de dados de contas de usuários normais
/root # Armazenamento de dados de contas do superusuário
/lib # Bibliotecas essenciais do sistema, de binários localizados em /bin e /sbin
/media # Ponto de montagem de mídias removíveis (como pen#drives, cd#rom)
/opt # Pacotes estático de aplicações
/tmp # Arquivos temporários. Conteúdo geralmente apagado no reboot nas distribuições
/usr # (unix system resources) # Hierarquia secundária (não essenciais no boot) para dados compartilhados de usuários
/var # Arquivos que são gravados comf requencia (logs, páginas web, email, imagens, etc)
/run # Tras as informacoes de tudo que esta rodando desde o ultimo boot. É um arquivo temporario.
/sys # Informacoes dos drisves do sistemas
/srv # Armazenamento de dados específicos de serviços como servidores web, servidores de arquivos, servidores de banco de dados, entre outros, que são fornecidos pelo sistema.
/spool # Esperando para ser processado
/proc # Diretório virtual que contém informações sobre os processos em execução, configuração de hardware, estatísticas do sistema, detalhes da CPU, da memória e do kernel, entre outros dados essenciais para o funcionamento e monitoramento do sistema operacional Linux.
###############################










###############################
# Observacoes
lost+found # achados e perdidos // pasta que os programas prodem salvar as coisas em recuperar depois em caso de falta de energia.
.ko # extesao dos modulos do kernel do linus. Os modulos do kernel sao tipos os drives do windows.
teste.txt~ # arquivos tertminados com ~ sao arquivos de backup. com ls -b voce filtra eles.
teste@ # link simbolico
teste/ #pasta
teste* #aquivo executavel
a datata do arquivo e a data da ultima alteracao.
sudo apt-get install tree # comando tree var/lib/apt mostra toda a estrutura dos arquivos em arvores.
rm -- - # para apagar aquivo chamado '-' truque util para aquivos com nomes do tipo * ? @ ! ...
comandos internos # ja vem carregados no terminal. cd ls 
comandos externos # tem que buscar no disco.
* # curinga para um, nenhum, ou muitos caracteres
? # curinga para um carcter
[a-z] # curinga para um intervalo de caracteres
[ˆabc],[ˆa-z] # curinga para excluir caracter ou intervalo. exemplo ' ls m[ˆa-c]' => liste tudo que comeca com m menos o que tem abc como segunda letra.
expressao{expressao1,expressao2} # curinga pra subistituir a expressao por expressaoexpressao1 e expressaoexpressao2 simultaniamente.
###############################













###############################
sync # E recomendavel usar antes de reinciar/desligar a forca.
halt # Desliga
reboot # Reinicia
shutdown -h now # Desliga
shutdown -r now # Reinicia
poweroff # Desliga
init 0 # Desliga
init 6 # Reinicia
shutdown 18:00 -h 18:00 # Programa hora para desligar
shutdown -h +30 # Programa a para desligar em 30 minutos.
shutdown -r +30 "mesagem a todos os usuarios informado que a maquina reiniciara em 30 minutos" # Programa a para Reiniciar em 30 minutos.
shutdown -c "mensagem a todos os usuarios avisando o cancelamento" # cancela os shutdown agnedados.
echo b >/proc/sysrq-trigger # Reinicia na mara, mesma coisa que puxar da tomada.
# echo o >/porc/sysrq-trigger # Desliga na mara, mesma coisa que puxar da tomada. evitar ao maximo usar.
###############################
