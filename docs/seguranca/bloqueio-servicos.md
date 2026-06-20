---
layout: default
title: "🚫 Bloqueio de Serviços"
parent: "🔒 Segurança & Acesso"
nav_order: 13
last_modified_date: 2026-06-12 23:45
---

# 🚫 Guia: Gerenciamento de Serviços (Segurança)
{: .no_toc }

Por padrão, o MikroTik vem com várias portas de comunicação abertas. Este tutorial ensina como desativar o que não é usado e proteger o acesso via Winbox e SSH.

---

## 🛠️ 1. Onde encontrar os Serviços

No Winbox, acesse o menu **IP** ➔ **Services**. Você verá uma lista com os protocolos de comunicação do roteador.

---

## 🔒 2. Desativando Serviços Inseguros


Serviços que enviam dados (`incluindo senhas`) em texto puro devem ser desativados imediatamente se você não tiver um motivo específico para usá-los.

**Passo a passo:**

1.  Selecione o serviço (ex: `telnet`).

2.  Clique no **X (Disable)** vermelho no topo da janela.

3.  Repita o processo para os seguintes serviços:

    *   **ftp**: Transferência de arquivos (use o Winbox para isso).

    *   **telnet**: Acesso via terminal inseguro.

    *   **www**: Acesso via navegador (WebFig) --- *Recomendado desativar se usar apenas Winbox.*

    *   **api / api-ssl**: Usado apenas por softwares externos e integrações.

---

## 🔑 3. Protegendo o Winbox e SSH (Troca de Portas)

Mudar as portas padrão dificulta a ação de robôs (bots) que ficam tentando senhas em portas conhecidas.

### **Alterando a porta do Winbox:**

1.  Dê um clique duplo em **winbox**.

2.  No campo **Port**, mude de `8291` para uma porta de sua escolha (ex: `5050`).

3.  Clique em **OK**.

    *   *Nota: Na próxima vez que conectar, você deve usar `IP:5050`.*

### **Alterando a porta do SSH:**

1.  Dê um clique duplo em **ssh**.

2.  No campo **Port**, mude de `22` para uma porta alta (ex: `2222`).

3.  Clique em **OK**.

* * * * *

## 🗺️ 4. Restrição por IP (Available From)

Esta é a camada de segurança mais forte. Você pode dizer ao MikroTik que um serviço só deve aceitar conexões vindas de um IP específico (como o seu IP fixo ou sua rede local).

1.  No serviço desejado (ex: `winbox`), clique duas vezes.

2.  No campo **Available From**, digite a sua rede local: `10.220.0.0/24`.

3.  Clique em **OK**.

    *   *Agora, mesmo que alguém descubra sua senha e sua porta, só conseguirá entrar se estiver fisicamente conectado à sua rede local.*

---

## 📋 Resumo de Configuração Sugerida


| **Serviço** | **Status** | **Porta Sugerida** | **Motivo** |
| --- | --- | --- | --- |
| **telnet** | ❌ Desativado | - | Inseguro (texto puro) |
| **ftp** | ❌ Desativado | - | Inseguro (texto puro) |
| **www** | ❌ Desativado | - | Evita invasão via navegador |
| **ssh** | ✅ Ativado | `2222` | Backup de acesso via terminal |
| **winbox** | ✅ Ativado | `5050` | Gerenciamento principal |
| **api** | ❌ Desativado | - | Risco desnecessário |

---

{: .important }
> Antes de desativar o serviço **www** ou mudar a porta do **winbox**, certifique-se de que você tem acesso via Winbox funcionando. Se você se trancar para fora, terá que usar o acesso via porta **Console** (se o seu modelo tiver) ou dar um **Reset de Fábrica**.