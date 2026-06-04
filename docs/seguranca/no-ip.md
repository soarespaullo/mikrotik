---
layout: default
title: "🌐 DNS Dinâmico (No-IP)"
parent: "🔒 Segurança & Acesso"
nav_order: 10
---

# 🌐 Guia: DNS Dinâmico com No-IP (Acesso Remoto)
{: .no_toc }

Este guia descreve como configurar o serviço de `DNS Dinâmico` do **No-IP** no MikroTik, permitindo o acesso remoto à rede (`Winbox`, `VPN`, `Servidores`) mesmo quando o endereço **IP fornecido pela operadora é dinâmico**.

## 🛠️ 1. Preparação no Portal No-IP

Antes de configurar o roteador, você deve criar a identidade do seu host.

1.  Acesse o site [**No-IP**](https://www.noip.com) e crie sua conta.

2.  Vá em **DDNS e Acesso Remoto/ou Gerenciar DNS** → **DNS Records**.

3.  Clique em **Criar Hostname**.

4.  Defina o nome (ex: `mikrotik-net`) e escolha um domínio (ex: `ddns.net`).

5.  Guarde seu **E-mail**, **Senha** e o **Hostname** criado.

{: .note }
> O uso de `DNS` é ideal para quem possui `IP Público Dinâmico`. Caso seu **IP esteja sob CGNAT**, o acesso externo não funcionará a menos que a operadora realize o "*rollback*" ou forneça um `IP público`.

---

## 📜 2. Script de Atualização Automática

Como o `MikroTik` não possui um menu nativo para o `No-IP`, utilizamos um `script` para informar ao servidor qual é o seu `IP` atual toda vez que ele mudar.

**Passo a passo:**

1.  Acesse **System → Scripts** e clique no `+`.

2.  **Name:** `atualizar-noip`.

3.  **Policies (Permissões):** Por padrão, o `MikroTik` já deixa as caixas marcadas. Apenas certifique-se de que as permissões **read**, **write**, **test** e **policy** continuem selecionadas.

    *   `read`: Permite que o script leia o seu IP nas interfaces.

    *   `write`: Permite que o script salve o novo IP na variável.

    *   `test`: Permite que o script use a ferramenta *Fetch* para falar com a internet.

    *   `policy`: Necessário para scripts que alteram configurações do sistema.

No campo **Source**, cole o código abaixo:

```bash
# Atualizacao automatica do No-IP

# Alterar as informacoes desta secao conforme os dados do seu login e host no-ip
:local noipuser "USUARIO"
:local noippass "SENHA"
:local noiphost "HOSTNAME.DDNS.NET"

# Nome da interface que devera ter o endereco IP vinculado ao host do no-ip
:local inetinterface "pppoe-cliente-proxxima"

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

```

{: .important }
> No campo `inetinterface`, certifique-se de digitar o nome exato da sua interface de internet (ex: `pppoe-cliente-proxxima`).

---

## ⏰ 3. Agendamento da Verificação (Scheduler)

Para que o `MikroTik` verifique e atualize o IP automaticamente, precisamos criar um agendamento.

1.  Acesse **System → Scheduler** e clique no **+**.

2.  **Name:** `Check-NoIP`.

3.  **Interval:** `00:05:00` (*Verifica a cada 5 minutos*).

4.  **On Event:** Digite o nome exato do script criado anteriormente: `atualizar-noip`.

5.  Clique em **Apply** e **OK**.

6. As permissões (`Policies`) devem ser **idênticas** às que você marcou no `Script` para que o agendamento tenha autoridade para executá-lo.

    *   `read`: (para ler o IP da interface)
    
    *   `write`: (para atualizar a variável global)
    
    *   `test`: (para permitir que o comando *fetch* saia para a internet)
    
    *   `policy`: (para permitir a execução do script agendado)


{: .note }
> **Atenção ao CGNAT!** Se o IP da sua interface PPPoE começar com `100.64.x.x`, o acesso remoto via DDNS comum não funcionará, pois você não possui um IP público real. Nesse caso, será necessário utilizar um serviço de Tunneling (como ZeroTier ou Tailscale) ou solicitar um IP público à operadora.
