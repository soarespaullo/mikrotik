---
layout: default
title: 🔄 Failover (Netwatch)
parent: 📡 Redes & Links
nav_order: 1
last_modified_date: 2026-06-08 23:05
---

# 🔄 Guia: Failover com Netwatch (Redundância de Links)
{: .no_toc }

Este guia descreve como configurar a redundância de links, priorizando o link **Proxxima (PPPoE)** e assumindo o link **Unitell (DHCP)** automaticamente em caso de falha.

---

## 🛠️ 1. Estrutura de Rotas (Distância Administrativa)

O Failover baseia-se na **Distância**. O link com a menor distância é o preferencial.

*   **Link Principal (Proxxima):** Definido com `Distance: 1`.
*   **Link de Backup (Unitell):** Definido com `Distance: 2`.

---

## 🛤️ 2. Desativando a Rota Padrão Dinâmica

Para que o Failover funcione, o MikroTik não deve gerenciar as rotas sozinho. Precisamos transformar as rotas dinâmicas em estáticas.

### Passo 1: Tornar a Rota Manual (Copy)
1. Acesse **IP ➔ Routes**.
2. Localize a rota default do **Link 1** (aquela com `Dst. Address: 0.0.0.0/0` e o símbolo **D** de dinâmica).
3. Clique duas vezes nela e selecione **Copy**.
4. Clique em **Apply** e depois em **OK**. Isso criará uma cópia estática.
5. **Repita o procedimento** para o **Link 2** (Unitell).

### Passo 2: Desativar a Rota Automática na Interface
1. Vá em **PPP ➔ Interfaces** (Link Proxxima) ou **IP ➔ DHCP Client** (Link Unitell).
2. Dê dois cliques na interface ou cliente DHCP.
3. Altere o campo **Add Default Route** para **no**.
4. Clique em **Apply** e **OK**.

{: .important }
> **Não esqueça os comentários!**
> Após criar as cópias manuais, clique com o botão direito nelas e use a opção **Comment**. Nomeie-as exatamente como: `LINK PROXXIMA` e `LINK UNITELL BKP`.

---

## 🛰️ 3. Criando a Rota para Monitoramento (Check Host)

Esta rota força o MikroTik a testar o IP de destino exclusivamente através do link principal, evitando que o ping saia pelo link de backup e gere um "falso positivo".

1. Acesse **IP ➔ Routes** e clique em **+**.
2. **Dst. Address:** `202.12.27.33` (IP de um Root Server).
3. **Gateway:** `pppoe-cliente-proxxima`.
4. Clique em **Comment** e digite: `ROTA PARA MONITORAMENTO PROXXIMA`.
5. Clique em **Apply** e **OK**.

---

## 👁️ 4. Monitoramento Ativo com Netwatch

O Netwatch monitora o `IP` externo e desativa a rota principal se o ping falhar.

Para um monitoramento preciso, recomendamos utilizar os `IPs` dos **Root Servers** (`servidores raiz da internet`), que garantem alta disponibilidade para o teste de conectividade.

{: .tip }
> Você pode consultar a lista completa de **IPs dos Root Servers (de A a M)** no site oficial da [IANA](https://iana.org/domains/root/servers){: .btn .btn-purple target="_blank" }.

1. Acesse **Tools ➔ Netwatch** e clique em **+**.
2. Na aba **Host**:
    *   **Host:** `202.12.27.33`
    *   **Type:** `icmp`
    *   **Interval:** `00:00:15`
3. Na aba **Down** (Ação ao cair):
```routeros
/ip route disable [find comment="LINK PROXXIMA"]
```
4. Na aba **Up** (Ação ao voltar):
```routeros
/ip route enable [find comment="LINK PROXXIMA"]
```

## 🛡️ 5. Configuração de NAT (Masquerade)

Certifique-se de que existam as duas regras de saída em IP ➔ Firewall ➔ NAT:

**Regra 1**: Chain: `srcnat` Out. Interface: `pppoe-cliente-proxxima` Action: masquerade.

**Regra 2**: Chain: `srcnat` Out. Interface: `ether2-link-unitell-dhcp` Action: masquerade.

## 🔍 Como testar?

1. No Winbox, abra a janela **IP** ➔ **Routes**.

2. Simule uma falha desconectando o cabo da `ether1-link-proxxima`.

3. O resultado esperado:

   * O Netwatch detectará a falha.

   * A rota `LINK PROXXIMA` ficará cinza (desativada).

   * A rota `LINK UNITELL BKP` assumirá o status **AS** (Active Static) imediatamente.

{: .tip }
> **Por que usar Comentários?**
>
> O `Netwatch` utiliza o comentário `LINK PROXXIMA` para identificar qual rota ele deve ligar ou desligar. O nome no comentário deve ser idêntico ao comando inserido no Netwatch.
