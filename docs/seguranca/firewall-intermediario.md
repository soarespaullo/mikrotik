---
layout: default
title: "🛡️ Firewall Intermediário"
parent: "🔒 Segurança & Acesso"
nav_order: 4
last_modified_date: 2026-06-19 22:50
---

# 🛡️ Guia: Firewall Intermediário (Proteção do Roteador)
{: .no_toc }

Este módulo complementa as políticas básicas do **RouterOS**, adicionando proteção contra pacotes malformados, varreduras ativas (**Port Scanners**) e ataques de força bruta (**Brute Force**).<br>
(_Requisito:_ Ter configurado o [**Guia de Firewall Básico**](https://soarespaullo.github.io/mikrotik/docs/seguranca/firewall-basico/){: target="_blank" })

## 🧼 1. Descarte de Conexões Inválidos

Esta regra descarta pacotes defeituosos ou fora de sequência, poupando o processamento da CPU.

1.  Vá em **IP** ➔ **Firewall** ➔ **Filter Rules** e clique em **+**.

2.  **Aba General:**

	*   **Comment:** `DROP CONEXOES INVALIDAS - INPUT`.

    *   **Chain:** `input`.

	*   **Connection State:** Marque apenas `invalid`.

3.  **Aba Action:**

	*   **Action:** `drop`.

4.  Clique em **OK**.

## 🪤 2. Detecção por Pontuação (PSD)

Identifica varreduras ativas na rede e adiciona o IP de origem a uma lista de bloqueio temporário.

1. Vá em **IP** ➔ **Firewall** ➔ **Filter Rules** e clique em **+**.

2. **Aba General:**

	*   **Comment:** `DETECTA PORT SCANNERS (PSD) - INPUT`.

	*   **Chain:** `input`.

	*   **Protocol:** `tcp`.

3. **Aba Extra:**

	*   **PSD:** `Weight Threshold: 21 | Delay Threshold: 3s | Low Port Weight: 3 | High Port Weight: 1`

4. **Aba Action:**

	*   **Action:** `add src to address list`.

	*   **Address List:** `port-scanners`.

	*   **Timeout:** `14d 00:00:00 (14 dias, 0 horas, 0 minutos e 0 segundos)`.

5. Clique em **OK**.

## ⚡ 3. Detecção de Varredura Síncrona Agressiva (Fast SYN Scan)

Identifica robôs que realizam varreduras de portas em alta velocidade enviando fluxos massivos de pacotes SYN.

1. Vá em **IP** ➔ **Firewall** ➔ **Filter Rules** e clique em **+**.

2. **Aba General:**

	*   **Comment:** `DETECTA SYN SCAN AGRESSIVO - INPUT`.

	*   **Chain:** `input`.

	*   **Protocol:** `tcp`.

3. **Aba Advanced:**

	*   **TCP Flags:** Marque apenas `syn`.

4. **Aba Extra:**

	*   **Connection Limit:** `Limit: 30 | Netmask: 32`.

5. **Aba Action:**

	*   **Action:** `add src to address list`.

	*   **Address List:** `port-scanners`.

	*   **Timeout:** `14d 00:00:00 (14 dias, 0 horas, 0 minutos e 0 segundos)`.

6. Clique em **OK**.

## 🚫 4. Bloqueio Estrutural da Lista

Aplica o bloqueio imediato na entrada do roteador para qualquer IP que tenha sido inserido na lista de scanners.

1.  Vá em **IP** ➔ **Firewall** ➔ **Filter Rules** e clique em **+**.

2.  **Aba General:**

	*   **Comment:** `DROP IPs SCANNERS - INPUT`.

	*   **Chain:** `input`.

	*   **Src. Address List:** `port-scanners`.

3.  **Aba Action:**

    *   **Action:** `drop`.

4.  Clique em **OK**.

## 🧱 5. Restrição de Acesso à Rede Interna (Forward)

Estende o bloqueio dos IPs atacantes da lista, impedindo o acesso a qualquer servidor ou dispositivo da rede interna.

1.  Vá em **IP** ➔ **Firewall** ➔ **Filter Rules** e clique em **+**.

2.  **Aba General:**

	*   **Comment:** `DROP IPs SCANNERS - FORWARD`.

    *   **Chain:** `forward`.

    *   **Src. Address List:** Selecione ou digite `port-scanners`.

3.  **Aba Action:**

    *   **Action:** `drop`.

4.  Clique em **OK**.

## 🦹 6. Mitigação de Força Bruta (Winbox / SSH)

Restringe a 3 o número de conexões simultâneas por IP nas portas de gerência, mitigando ataques automatizados de dicionário.

1.  Vá em **IP** ➔ **Firewall** ➔ **Filter Rules** e clique em **+**.

2.  **Aba General:**

	*   **Comment:** `LIMITA BRUTE FORCE SSH/WINBOX - INPUT`.

	*   **Chain:** `input`.

	*   **Protocol:** `tcp`.

	*   **Dst. Port:** `22,8291,5050`. (*Insira as portas de gerência utilizadas*)

	*   **Connection State:** Marque apenas `new`.

3.  **Aba Extra:**

	*   **Connection Limit:** `Limit: 3 | Netmask: 32`.

4.  **Aba Action:**

	*   **Action:** `drop`.

5.  Clique em **OK**.

## ⚠️ Atenção à Ordem das Regras

No MikroTik, a ordem dos fatores altera o produto! O firewall lê as regras de cima para baixo.

1. 🧼 `DROP CONEXOES INVALIDAS - INPUT`
2. 🏗️ `ACEITA CONEXOES ESTABELECIDAS E RELACIONADAS` *(Básico 1)*
3. 🚫 `DROP IPs SCANNERS - INPUT`
4. 🚫 `DROP IPs SCANNERS - FORWARD`
5. 🪤 `DETECTA PORT SCANNERS (PSD) - INPUT`
6. ⚡ `DETECTA SYN SCAN AGRESSIVO - INPUT`
7. 🚪 `PEGA IP PARA A LISTA PRE-REDE-SUPORTE` *(Port Knocking - Batida 1 - 7788)*
8. 🔑 `PEGA IP PARA A REDE-SUPORTE` *(Port Knocking - Batida 2 - 4455)*
9. 🟢 `ACEITA REDE SUPORTE` *(Básico 2)*
10. 🦹 `LIMITA BRUTE FORCE SSH/WINBOX - INPUT`
11. 🏓 `ACEITA 10 PACOTES DE ICMP POR SEGUNDOS` *(Básico 3)*
12. 🔒 `DROP GERAL` *(Básico 4)*

{: .important }
> Se você colocar a regra de **Drop** acima da regra de **Rede Suporte**, você perderá o acesso ao Winbox imediatamente e precisará de acesso físico ao roteador.