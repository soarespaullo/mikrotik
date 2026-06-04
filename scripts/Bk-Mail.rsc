# ------------------------------------------------------------------------------
# SCRIPT: Bk-Mail
# DESCRIÇÃO: Backup automatizado com envio por e-mail (.rsc)
# VERSÃO: 2.5 (Estável)
# AUTOR: Equipe de Rede - @soarespaullo
# RECURSOS: IP Dinâmico Universal, Uptime formatado e Identidade Automática
# ------------------------------------------------------------------------------
#
# --- CONFIGURAÇÕES DE TEXTO ---
:local sysName [/system identity get name]
:local msgAssunto ("Backup Automatico - " . $sysName)
:local msgCorpo "Relatorio de Backup do Concentrador:\n\n"
:local msgAssinatura "\n\nAtt, \nEquipe de Rede - @soarespaullo"

# --- VARIÁVEIS DO SISTEMA ---
:local sysVer [/system resource get version]
:local sysModel [/system resource get board-name]
:local sysDate [/system clock get date]
:local sysTime [/system clock get time]
:local fileName ($sysName . ".rsc")
:local mailTo [/tool e-mail get user]

# --- TRATAMENTO DO UPTIME (Formato: XXd XX:XX) ---
:local rawUptime [/system resource get uptime]
:local uptimeStr [:tostr $rawUptime]
:local finalUptime ""
:if ([:find $uptimeStr "w"] > 0) do={
    :local weeks [:pick $uptimeStr 0 [:find $uptimeStr "w"]]
    :local days [:pick $uptimeStr ([:find $uptimeStr "w"] + 1) [:find $uptimeStr "d"]]
    :local rest [:pick $uptimeStr ([:find $uptimeStr "d"] + 1) [:len $uptimeStr]]
    :set finalUptime (($weeks * 7 + $days) . "d " . [:pick $rest 0 5])
} else={
    :set finalUptime [:pick $uptimeStr 0 11]
}

# --- LÓGICA DE BUSCA DE IP ---
:local sysAddr "Nao identificado"
:do {
    # Busca o ID da interface que possui a rota default ativa
    :local routeID [/ip route find where dst-address=0.0.0.0/0 and active=yes]
    :local gwInt [/ip route get $routeID gateway]
    
    # Se o gateway for um nome de interface (comum em PPPoE)
    :do {
        :local rawAddr [/ip address get [find interface=$gwInt] address]
        :set sysAddr [:pick $rawAddr 0 [:find $rawAddr "/"]]
    } on-error={
        # Se falhar (link fixo/dedicado), busca o IP de qualquer interface que não seja Bridge/REDE
        :local rawAddr [/ip address get [find interface!~"bridge" and interface!~"REDE" and address!~"^192.168."] address]
        :set sysAddr [:pick ($rawAddr->0) 0 [:find ($rawAddr->0) "/"]]
    }
} on-error={ :set sysAddr "Verificar WAN/Rota Default" }

# --- EXECUÇÃO ---
/log warning "Iniciando Script de Backup."

/export terse file=$fileName
/delay 5

# Montagem do corpo do e-mail
:local corpoFinal ($msgCorpo . "Nome: " . $sysName . "\nModelo: " . $sysModel . "\nEndereco IP: " . $sysAddr . "\nVersao: " . $sysVer . "\nUptime: " . $finalUptime . "\nData: " . $sysDate . " - " . $sysTime . $msgAssinatura)

/log info "Enviando backup por e-mail para: $mailTo"

/tool e-mail send file=$fileName to=$mailTo subject=$msgAssunto body=$corpoFinal

/delay 5
/log info "Script de Backup finalizado com sucesso."
