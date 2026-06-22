---
layout: default
title: 📡 Hotspot
parent: 📡 Redes & Links
nav_order: 5
last_modified_date: 2026-06-11 23:35
---

# 📡 Guia: Configuração de Hotspot
{: .no_toc }

O **Hotspot** permite controlar o acesso à internet através de uma página de login. Ele gerencia autenticação, controle de banda e tempo de conexão em um só lugar.

---

## 🏗️ 1. Preparação

Antes de começar, você precisa de uma interface (física ou Bridge) dedicada para o Hotspot. Não utilize a mesma bridge da sua rede administrativa.

{: .important }
> **Certifique-se** de que a interface escolhida (ex: `bridge-hotspot`) já tenha um endereço IP definido em **IP** ➔ **Addresses**.

---

## 🪜 2. Configuração via Hotspot Setup

O MikroTik possui um assistente que cria todas as regras de firewall e NAT automaticamente.

1. Vá em **IP** ➔ **Hotspot**.
2. Na aba **Servers**, clique no botão **Hotspot Setup**.
3. **Hotspot Interface:** Selecione a interface (ex: `bridge-hotspot`). Clique em **Next**.
4. **Local Address of Network:** Deixe o IP que já aparece. Marque **Masquerade Network**. Clique em **Next**.
5. **Address Pool of Hotspot Network:** Range de IPs que os clientes vão receber. Clique em **Next**.
6. **Select Certificate:** Selecione `none` (a menos que tenha um certificado SSL). Clique em **Next**.
7. **IP Address of SMTP Server:** Deixe `0.0.0.0`. Clique em **Next**.
8. **DNS Servers:** Use `8.8.8.8` e `1.1.1.1`. Clique em **Next**.
9. **DNS Name:** Endereço que o usuário verá no navegador (ex: `login.wifi`). Clique em **Next**.
10. **Create Local Hotspot User:** Crie o primeiro usuário (ex: `admin`/`admin`). Clique em **Next**.

---

## 👤 3. Perfis de Usuários (User Profiles)

É aqui que você define a velocidade da internet para os clientes.

1. Vá na aba **User Profiles** e clique no **+**.
2. **Name:** `perfil-10mb`.
3. **Shared Users:** Quantos dispositivos podem usar o mesmo login simultaneamente (ex: `1`).
4. **Rate Limit (rx/tx):** Defina a velocidade (ex: `10M/10M`).

{: .tip }
> **O segredo do Rate Limit:** O primeiro valor é o `Upload` e o segundo é o `Download`. Use sempre o sufixo **M** para Megas.

---

## 📝 4. Criando Clientes (Users)

Para liberar o acesso de alguém manualmente:

1. Vá na aba **Users** e clique no **+**.
2. **Server:** Selecione `all` ou o seu servidor de hotspot.
3. **Name:** Nome de usuário (login).
4. **Password:** Senha do cliente.
5. **Profile:** Selecione o perfil de velocidade (ex: `perfil-10mb`).

---

## 🛠️ 5. Ajustes Importantes de Segurança

### Desativar Cookies
Por padrão, o MikroTik "lembra" do usuário via cookies. Em redes públicas, isso pode causar problemas.
1. Vá em **Server Profiles**.
2. Dê um clique duplo no perfil criado (ex: `hsprof1`).
3. Na aba **Login**, desmarque a opção **HTTP Cookie**. Assim, o usuário sempre precisará logar.

### Walled Garden
Para liberar sites (como o site institucional) antes do usuário logar:
1. Vá na aba **Walled Garden**.
2. Clique em **+**, coloque o domínio em **Dst. Host** (ex: `*mikrotik.com*`) e **Action:** `allow`.
