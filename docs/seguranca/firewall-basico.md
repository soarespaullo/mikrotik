---
layout: default
title: "🛡️ Firewall Básico"
parent: "🔒 Segurança & Acesso"
nav_order: 3
last_modified_date: 2026-06-08 11:40
---

# 🛡️ Guia: Firewall Básico (Proteção do Roteador)
{: .no_toc }

O Firewall de `input` é responsável por proteger o **próprio roteador** de acessos externos não autorizados. Seguiremos a estratégia de "Bloqueio por Padrão", onde liberamos apenas o essencial e dropamos o resto.

---

## 🏗️ 1. Aceitar Conexões Estabelecidas ou Relacionadas

Esta regra permite que o roteador responda a comunicações que ele mesmo iniciou. Sem ela, nada funciona corretamente.

1.  Vá em **IP** → **Firewall** → **Filter Rules** e clique em **+**.

2.  **Aba General:**

    * **Chain:** `input`

    * **Connection State:** Marque `established` e `related`.

    * **Comment:** `Aceitar conexoes estabelecidas e relacionadas - INPUT`

3.  **Aba Action:**

    *  **Action:** `accept`

4.  Clique em **OK**.

---

## 🔑 2. Aceitar Lista de Suporte (Rede Confiável)

{: .warning }
> Esta mesma lista (`rede-suporte`) é utilizada no nosso sistema de [**Port Knocking**](https://soarespaullo.github.io/mikrotik/docs/seguranca/port-knocking/){: target="_blank" }. Isso significa que, seja via rede local ou via batida secreta, o firewall usará esta única regra para permitir o seu acesso, mantendo as configurações organizadas.

Libera acesso total ao roteador para os **IPs** que estão na sua lista de permissão.

1.  **Primeiro, crie a lista:** Vá na aba **Address Lists** e clique em **+**.

    *   **List:** `rede-suporte`

    *   **Address:** `10.220.0.0/24` (Aceita a rede local inteira).

2.  **Crie a regra no Filter:**

    *   **Aba General:** `Chain: input`.

    *   **Aba General:** `Src. Address List: rede-suporte`.

    *   **Comment:** `Permitir acesso total - Lista de Suporte - INPUT`

    *   **Aba Action:** `Action: accept`.

{: .note } 
> Em **Address**, você pode colocar o IP específico de um computador ou o bloco da rede toda como fizemos acima.

---

## 🏓 3. Aceitar ICMP (Ping) com Limite

Permite que o roteador responda a Pings, mas limita a quantidade para evitar ataques de negação de serviço (DoS).

1.  **Aba General:**

    *   **Chain:** `input`

    *   **Protocol:** `icmp`

    * **Comment:** `Aceitar ICMP (Ping) limitado a 10 por segundo - INPUT`

2.  **Aba Extra:**

    *   **Limit:**

        *   **Rate:** `10/sec` (Aceita até 10 pings por segundo)

        *   **Burst:** `5`

3.  **Aba Action:**

    *   **Action:** `accept`

---

## 🚫 4. Drop Geral (O Cadeado)

Esta regra deve ser **sempre a última**. Ela bloqueia qualquer tentativa de conexão que não se encaixou nas regras acima (como acessos vindos da Internet/WAN).

1.  **Aba General:**

    *   **Chain:** `input`

    *   **Comment:** `Bloqueio Geral (Drop All) - Resto do Trafego - INPUT`

2.  **Aba Action:**

    *   **Action:** `drop`

---

## ⚠️ Atenção à Ordem das Regras

No MikroTik, a ordem dos fatores altera o produto! O firewall lê as regras de cima para baixo.

1.  `accept established/related` (Topo)

2.  `accept rede-suporte`

3.  `accept icmp`

4.  `drop input` (Fundo)

{: .important }
> Se você colocar a regra de **Drop** acima da regra de **Rede Suporte**, você perderá o acesso ao Winbox imediatamente e precisará de acesso físico ao roteador.