#!/bin/bash

# -------------------------------------------------------------------------------------------------
#
# Script: notificar_slack.sh
# Objetivo: Notificar slack via WebHook
# Utilização: ./Script.sh PARM1 PARM2
# Utilização: ./coletar_labels.sh SLACK_WEBHOOK SLACK_CHANNEL ":loudspeaker: *Segue nova mensagem* :arrow_right: TEXTO DA MENSAGEM"
# Data: 2017-08-20
#
# -------------------------------------------------------------------------------------------------

# set -xv

# -------------------------------------------------------------------------------------------------
# VARIAVEIS DE AMBIENTE
# -------------------------------------------------------------------------------------------------

DT_LOG=`date '+%Y%m%d%H%M%S'`
SCRIPT_NAME=`basename $0`
WORKSPACE=`pwd`
DIR_TMP="${WORKSPACE}/TMP"
DIR_LOG="${WORKSPACE}/LOG"
mkdir -p $DIR_TMP $DIR_LOG
LOGFILE=${WORKSPACE}/LOG/${DT_LOG}_${SCRIPT_NAME%.sh}.log
SERVER=`uname -a | cut -d' ' -f2 | cut -f1 -d'.'`
DIA=`date '+%Y%m%d'`

# -------------------------------------------------------------------------------------------------
# CRIAR OS DIRETÓRIOS AUXILIARES: "LOG" e "TMP"
# -------------------------------------------------------------------------------------------------

mkdir -p ${DIR_TMP} ${DIR_LOG}

# -------------------------------------------------------------------------------------------------
# FUNÇõES
# -------------------------------------------------------------------------------------------------

# Função de escrita no log
function log_msg(){
  CURR_DT="`date +'%Y%m%d %H:%M:%S'`"
  echo "$CURR_DT - $*" | tee -a $LOGFILE 1>&2
}

# Função de marcação e divisão  de escrita no log
function log_div(){
   CURR_DT="`date +'%Y%m%d %H:%M:%S'`"
   DIV=`printf "%0140d\n" | tr '0' '-'`
   echo "$CURR_DT - $*" "$DIV" | tee -a $LOGFILE 1>&2
}

# Função de marcação e divisão  de escrita no log
function log_sep(){
   CURR_DT="`date +'%Y%m%d %H:%M:%S'`"
   DIV=`printf "%0140d\n" | tr '0' '='`
   echo "$CURR_DT - $*" "$DIV" | tee -a $LOGFILE 1>&2
}

# -------------------------------------------------------------------------------------------------
#  INICIO
# -------------------------------------------------------------------------------------------------

log_sep "S:"
log_msg "I: INICIO - SCRIPT: $SCRIPT_NAME"
log_sep "S:"

# -------------------------------------------------------------------------------------------------
#  INICIO - PROCESSAMENTO
# -------------------------------------------------------------------------------------------------

# Condição para verificar se a variável está preenchida

WEBHOOK=$1
  if [ -z $WEBHOOK ]; then
    log_msg "I: Favor, inserir o incoming webhook"
    exit 1
  fi

shift

# Condição para verificar se a variável está preenchida
CHANNEL=$1
  if [ -z $CHANNEL ]; then
    log_msg "I: Favor, inserir o canal"
    exit 1
  fi

shift

# Condição para verificar se a variável está preenchida
MESSAGE=$*
  if [ -z "$MESSAGE" ]; then
    log_msg "Favor, inserir a mensagem"
    exit 1
  fi

# Tratamento da mensagem
ESCAPEDTEXT=$(echo $MESSAGE | sed 's/"/\"/g' | sed "s/'/\'/g")
JSON="{\"channel\": \"$CHANNEL\", \"text\": \"$ESCAPEDTEXT\"}"

# Armazenamento de log
log_msg "I: PARAMETROS INFORMADOS:"
log_msg "I: WEBHOOK:  $WEBHOOK"
log_msg "I: CHANNEL:  $CHANNEL"
log_msg "I: MESSAGE:  $MESSAGE"
log_msg "I: NOTIFICAÇÃO (JSON): "
log_msg "N: {\"channel\": \"$CHANNEL\", \"text\": \"$ESCAPEDTEXT\"}"

# Enviar mensagem
curl -s -d "payload=$JSON" "$WEBHOOK"
echo ' '
log_div "D"
# -------------------------------------------------------------------------------------------------
#  FIM - PROCESSAMENTO
# -------------------------------------------------------------------------------------------------

log_msg "I: FIM - SCRIPT: $SCRIPT_NAME"
log_sep "S:"

# -------------------------------------------------------------------------------------------------
#  FIM
# -------------------------------------------------------------------------------------------------

exit 0
