---
layout: default
title: 🤖 Bot Telegram
parent: ⚡ Automação
nav_order: 1
---

# 🤖 Guia: Configuração do Bot no Telegram
{: .no_toc }

Este tutorial ensina como criar um bot do Telegram do zero e obter o **TOKEN** e o **CHAT ID** para usar em scripts de backup e notificações no MikroTik.

---

## 1. Criando o seu Bot (Obtendo o Token)

O **BotFather** é o bot oficial do Telegram que gerencia todos os outros bots.

1. Abra o seu Telegram e pesquise por **@BotFather**.
2. Inicie a conversa clicando em **Começar** (ou envie `/start`).
3. Envie o comando `/newbot`.
4. Escolha um **nome** para o seu bot (Ex: `MikroTik`).
5. Escolha um **username** único que termine em `bot` (Ex: `MTKBot`).
6. O BotFather enviará uma mensagem com o seu **HTTP API Token**.

{: .important }
> Guarde esse código, ele é a senha do seu bot!

---

## 2. Obtendo o seu Chat ID

O **Chat ID** é o número de identificação da sua conta para que o bot saiba para quem enviar as mensagens.

1. No Telegram, pesquise por **@userinfobot**.
2. Inicie o bot clicando em **Começar**.
3. Ele responderá instantaneamente com o seu **Id** (Ex: `556803685`).

{: .important }
> Antes de rodar qualquer script, você precisa iniciar uma conversa com o seu bot (o criado no passo 1) e clicar em **Começar**. Caso contrário, ele não terá permissão para te enviar mensagens.

---

## 3. Testando o Bot via Navegador

Teste se as credenciais estão corretas colando este link no navegador (substitua pelos seus dados):

```bash
https://api.telegram.org/bot<SEU_TOKEN>/sendMessage?chat_id=<SEU_CHAT_ID>&text=Teste_MikroTik
```

---

## 4. Aplicando no MikroTik

Preencha as variáveis nos seus scripts do RouterOS:

```bash
:local botToken "8733935690:AAGrDezO9N_RVJ98T8p_ZxMLÇKJHGYTFR_f"
:local chatId "556803685"
```
