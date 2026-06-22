---
layout: default
title: "🕵️ Neighbor Discovery (Segurança)"
parent: "🔒 Segurança & Acesso"
nav_order: 6
last_modified_date: 2026-06-10 23:17
---

# 🕵️ Guia: Neighbor Discovery (Segurança)
{: .no_toc }

O protocolo **MNDP** (MikroTik Neighbor Discovery Protocol) permite que seu roteador seja encontrado na aba *Neighbors* do Winbox. Por segurança, ele **nunca** deve estar ativo na porta da internet (WAN), apenas em interfaces seguras.

---

## 🛠️ Passo 1: Criar a Lista de Interfaces Seguras

O primeiro passo é criar um `"grupo"` e dizer ao MikroTik quem faz parte dele.

1.  Vá em **Interfaces** ➔ aba **Interface List**.

2.  Clique em **Lists** e depois no **+**.

    *   **Name:** `LISTA-SEGURA`

    *   Clique em **OK**.

3.  Agora, clique na aba **Interface List** (ao lado de *Lists*) e clique no **+**.

    *   **List:** `LISTA-SEGURA`

    *   **Interface:** Selecione a sua `bridge-local` (ou a *interface onde você conecta seu PC*).

    *   Clique em **OK**.

---

## 🔒 Passo 2: Restringir a Descoberta (Neighbor)

Agora vamos dizer ao roteador para só "falar" com quem estiver nessa lista.

1.  Vá no menu **IP** ➔ **Neighbor**.

2.  Clique na aba **Discovery Settings**.

3.  No campo **Interface**, selecione a lista que você acabou de criar: `LISTA-SEGURA`.

4.  Clique em **Apply** e **OK**.

{: .note }
> A partir de agora, se você conectar o cabo na porta WAN ou em qualquer porta que não esteja na `LISTA-SEGURA`, o MikroTik não aparecerá mais no Winbox.

---

## 🛡️ Passo 3: Proteção Extra (MAC-Server)

Para fechar a segurança, você deve restringir quem pode tentar login via Endereço MAC (aquela conexão que usamos quando o roteador está sem IP).

1.  Vá em **Tools** ➔ **MAC Server**.

2.  Na aba **MAC Telnet Server**, clique em **Allowed Interface List** e mude para `none` (ou `LISTA-SEGURA` se você realmente usa **MAC-Telnet**).

3.  Na aba **MAC Winbox Server**, clique em **Allowed Interface List** e selecione `LISTA-SEGURA`.

4.  Clique em **OK**.

---

## ✅ Como testar?

1.  Abra um novo Winbox em um PC na rede local.

2.  Vá na aba **Neighbors**. Seu MikroTik deve aparecer normalmente.

3.  **O teste real:** Se você tiver como conectar um cabo em uma porta fora da Bridge (ou na WAN), verá que o MikroTik sumiu da lista, ficando totalmente invisível para vizinhos e scanners.

---

{: .tip }
> **Por que usamos Interface List?**
>
> Se no futuro você criar uma rede Wi-Fi separada ou uma nova VLAN e quiser que o MikroTik também apareça nela, você não mexe mais no menu *Neighbor*. Você apenas adiciona essa nova interface dentro da `LISTA-SEGURA` e pronto: as regras de Neighbor, MAC-Server e até de Firewall (se você as configurar assim) já estarão valendo automaticamente.