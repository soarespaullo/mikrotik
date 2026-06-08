---
layout: default
title: "⏰ Ajuste de Hora (NTP)"
parent: "🛠️ Manutenção"
nav_order: 6
---

# ⏰ Guia: Ajuste de Hora (NTP Client)

O MikroTik não possui uma **bateria interna** para manter a hora após ser desligado. Por isso, ele precisa consultar servidores na internet toda vez que inicia para sincronizar o relógio.

---

## 🪜 1. Configurando o Fuso Horário

Antes de buscar a hora na internet, precisamos dizer ao roteador em qual parte do mundo ele está.

1.  Vá em **System → Clock**.

2.  Na aba **Time**, verifique se o campo **Time Zone Name** está correto.

    *   Para a maior parte do Brasil, use: `America/Sao_Paulo`.

3.  Marque a opção **Time Zone Autodetect**

4.  Clique em **Apply** e **OK**.

## 🛰️ 2. Ativando o NTP Client (Recomendado)

Agora vamos configurar o roteador para buscar a hora exata nos servidores oficiais do Brasil ([**NTP.br**](https://ntp.br/){: target="_blank" }).

1.  Vá em **System → NTP Client**.

2.  Marque a caixa **Enabled**.

3.  No campo **NTP Servers**, clique no **+** adicione os seguintes servidores:

    *   `a.st1.ntp.br`

    *   `b.st1.ntp.br`

4.  Clique em **OK**.

{: .note }
> **Como saber se funcionou?** 
>
> Assim que você clicar em OK, o campo **Status** na parte inferior da janela deverá mudar para `synchronized`. Isso indica que o roteador já recebeu e ajustou a hora corretamente.

---

### ❓ Por que isso é importante?

*   **Logs:** Permite saber exatamente quando um erro ocorreu ou quando um cliente se conectou.

*   **Agendamentos:** Garante que scripts e tarefas programadas no **Scheduler** rodem no horário exato.

*   **Segurança:** VPNs e certificados de segurança exigem que a data e hora do roteador estejam atualizadas para validar a conexão.