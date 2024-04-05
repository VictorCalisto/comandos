#!/bin/bash

###############################
# Comandos de navegação:
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
touch # cria um aquivo vazio. voce tem que colocar a extensao. txt por exemplo.
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
