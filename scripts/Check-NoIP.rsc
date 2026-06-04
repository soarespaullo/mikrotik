# Atualizacao automatica do No-IP

# Alterar as informacoes desta secao conforme os dados do seu login e host no-ip
:local noipuser "USUARIO"
:local noippass "SENHA"
:local noiphost "HOSTNAME.DDNS.NET"

# Nome da interface que devera ter o endereco IP vinculado ao host do no-ip
:local inetinterface "pppoe-cliente"

:global previousIP

:if ([/interface get $inetinterface value-name=running]) do={
# Obtendo informacao sobre o IP atual
   :local currentIP [/ip address get [find interface="$inetinterface" disabled=no] address]
   :for i from=( [:len $currentIP] - 1) to=0 do={
       :if ( [:pick $currentIP $i] = "/") do={ 
           :set currentIP [:pick $currentIP 0 $i]
       } 
   }

  :if ($currentIP != $previousIP) do={
       :log info "No-IP: IP atual $currentIP diferente do IP anterior, atualizando."
       :set previousIP $currentIP

       # Enviando o novo IP via http
       :log info "No-IP: Atualizando o host $noiphost"
       /tool fetch mode=http user=$noipuser password=$noippass url="http://dynupdate.no-ip.com/nic/update\3Fhostname=$noiphost&myip=$currentIP" keep-result=no
       :log info "No-IP: Host $noiphost atualizado no No-IP = $currentIP"
   }
} else={
   :log info "No-IP: $inetinterface desconectada. Impossivel atualizar No-IP."
}
