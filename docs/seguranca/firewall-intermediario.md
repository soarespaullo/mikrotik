---
layout: default
title: "🛡️ Firewall Intermediário"
parent: "🔒 Segurança & Acesso"
nav_order: 4
last_modified_date: 2026-06-19 22:50
---

# 🛡️ Guia: Firewall Intermediário (Proteção do Roteador)
{: .no_toc }

Este módulo complementa as políticas básicas do RouterOS, adicionando proteção contra pacotes malformados, varreduras ativas (**Port Scanners**) e ataques de força bruta (**Brute Force**).<br>
(_Requisito:_ Ter configurado o [**Guia de Firewall Básico**](https://soarespaullo.github.io/mikrotik/docs/seguranca/firewall-basico/){: target="_blank" })

### 🧼 1. Filtragem de Estados Inválidos

Esta regra descarta pacotes defeituosos ou fora de sequência, poupando o processamento da CPU.

Vá em **IP** ➔ **Firewall** ➔ **Filter Rules** e clique em **+**.

**Aba General:**

*   **Chain:** `input`

*   **Connection State:** Marque apenas `invalid`.

*   **Comment:** `DROP CONEXOES INVALIDAS - INPUT`

**Aba Action:**

*   **Action:** `drop`

Clique em **OK**.

### 🪤 2. Subsistema Anti-Scanners (Detecção e Bloqueio)

Identifica varreduras ativas na rede e adiciona o IP de origem a uma lista de bloqueio temporário.

#### Regra A: Detecção por Pontuação (PSD)

Vá em **IP** ➔ **Firewall** ➔ **Filter Rules** e clique em **+**.

**Aba General:**

*   **Chain:** `input`

*   **Protocol:** `tcp`

*   **Comment:** DETECTA PORT SCANNERS - INPUT

**Aba Extra:**

*   **PSD:** `Weight Threshold: 21 | Delay Threshold: 3s | Low Port Weight: 3 | High Port Weight: 1`

**Aba Action:**

*   **Action:** `add src to address list`

*   **Address List:** `port scanners`

*   **Timeout:** `2w (14 dias)`

Clique em **OK**.

#### Regra B: Detecção de Varredura Síncrona Agressiva (Fast SYN Scan)

Vá em **IP** ➔ **Firewall** ➔ **Filter Rules** e clique em **+**.

**Aba General:**

*   **Chain:** `input`

*   **Protocol:** `tcp`

*   **TCP Flags:** `Marque apenas syn`.

*   **Connection Limit:** `Limit: 30 | Netmask: 32`

*   **Comment:** `DETECTA SYN SCAN AGRESSIVO - INPUT`

**Aba Action:**

*   **Action:** `add src to address list`

*   **Address List:** `port scanners`

*   **Timeout:** `2w (14 dias)`

Clique em **OK**.

#### Regra C: Bloqueio Estrutural da Lista

Vá em **IP** ➔ **Firewall** ➔ **Filter Rules** e clique em **+**.

**Aba General:**

*   **Chain:** `input`

*   **Src. Address List:** `port scanners`

*   **Comment:** `DROP IPs SCANNERS - INPUT`

**Aba Action:**

*   **Action:** `drop`

Clique em OK.

### 🦹 3. Mitigação de Força Bruta (Winbox / SSH)

Restringe a 3 o número de conexões simultâneas por IP nas portas de gerência, mitigando ataques automatizados de dicionário.

Vá em IP ➔ Firewall ➔ Filter Rules e clique em **+**.

**Aba General:**

*   **Chain:** `input`

*   **Protocol:** `tcp`

*   **Dst. Port:** `22,8291,5050` (_Insira as portas de gerência utilizadas_)

*   **Connection State:** `Marque apenas new`.

*   **Connection Limit:** `Limit: 3 | Netmask: 32`

*   **Comment:** `LIMITA BRUTE FORCE SSH/WINBOX - INPUT`

**Aba Action:**

*   **Action:** `drop`

Clique em **OK**.

## ⚠️ Atenção à Ordem das Regras

No MikroTik, a ordem dos fatores altera o produto! O firewall lê as regras de cima para baixo.


1.  `Drop Conexoes Invalidas`

2.  `accept established/related` *(Básico 1)*

3.  `accept rede-suporte` *(Básico 2)*

4.  `Dop IPs Scanners`

5.  `Detecta Port Scanners`

6.  `Detecta Syn Scan Agressivo`

7.  `Limita Brute Force ssh/Winbox`

8.  `accept icmp` *(Básico 3)*

9.  `Bloqueio Geral (Drop All) - Resto do Trafego - INPUT` *(Básico 4)*

{: .important }
> Se você colocar a regra de **Drop** acima da regra de **Rede Suporte**, você perderá o acesso ao Winbox imediatamente e precisará de acesso físico ao roteador.