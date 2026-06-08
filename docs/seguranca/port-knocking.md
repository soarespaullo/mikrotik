---
layout: default
title: "🚪 Port Knocking (Acesso Seguro)"
parent: "🔒 Segurança & Acesso"
nav_order: 7
---

# 🚪 Guia: Port Knocking (Acesso Seguro)
{: .no_toc }

O `Port Knocking` funciona como uma "**batida secreta**". Enquanto você não bater na sequência correta, as portas de gerenciamento do roteador permanecem invisíveis para a internet.

---

## 🛠️ 1. Entendendo a Lógica (A "Batida")

Imagine que o seu roteador é um cofre com um sistema de segurança inteligente:

1.  **A 1ª Batida (Porta 7788):** Você tenta acessar essa porta. O roteador não responde (dá erro no navegador), mas ele anota o seu IP na lista `pre-rede-suporte` por apenas **30 segundos**. É como se ele dissesse: *"Alguém bateu o primeiro toque, vou esperar o segundo por 30 segundos"*.

2.  **A 2ª Batida (Porta 4455):** Você acessa essa porta. O roteador verifica: *"Esse IP que bateu aqui já tinha batido na porta 7788 nos últimos 30 segundos?"*. Se **SIM**, ele move seu IP para a lista definitiva `rede-suporte`.

3.  **A Liberação:** Uma vez que seu IP está na lista `rede-suporte`, a regra de **Accept** do Firewall se abre para você. Agora você pode abrir o Winbox, SSH ou Webfig.

---

## 🪜 2. Configuração via Winbox


### **Passo 1: A Primeira Batida (Porta 7788)**

1.  Vá em **IP → Firewall → Filter Rules** e clique em **+**.

2.  **Aba General:** `Chain: input`, `Protocol: 6 (tcp)`, `Dst. Port: 7788`.

3.  **Aba Action:**

    *   **Action:** `add src to address list`

    *   **Address List:** `pre-rede-suporte`

    *   **Timeout:** `00:00:30` (30 segundos).

### **Passo 2: A Segunda Batida (Porta 4455)**

1.  Clique em **+** para uma nova regra.

2.  **Aba General:** `Chain: input`, `Src. Address List: pre-rede-suporte`, `Protocol: 6 (tcp)`, `Dst. Port: 4455`.

{: .note }
> **Src. Address List:** `pre-rede-suporte` — Aqui está o segredo: o roteador só aceita o segundo toque se você tiver dado o primeiro.

3.  **Aba Action:**

    *   **Action:** `add src to address list`

    *   **Address List:** `rede-suporte`

    *   **Timeout:** `01:00:00` (*Libera seu acesso por 1 hora*).

---

## 🔓 3. Liberando o Acesso Real

{: .note }
> Se você já seguiu o guia de **[Firewall Básico](https://soarespaullo.github.io/MikroTik/docs/seguranca/firewall-basico/){: target="_blank"}**, você já possui uma regra que aceita a `rede-suporte`. Não é necessário criar uma nova; o `Port Knocking` apenas adicionará o seu **IP** temporariamente a essa lista que o Firewall já autoriza.

Se você ainda não tem essa regra, crie-a:

1.  **Aba General:** `Chain: input`, `Src. Address List: rede-suporte`.

2.  **Aba Action:** `Action: accept`.

{: .important }
> No **Winbox**, arraste esta regra para (acima do seu `Drop Geral`).

---

## 🚀 4. Como realizar a batida na prática

Quando você estiver fora da sua rede e precisar acessar o Winbox:

1.  **Pelo Navegador:** Digite e acesse (mesmo que dê erro):

    *   `http://dominio.duckdns.org:7788`

    *   Aguarde 2 segundos e acesse: `http://dominio.duckdns.org:4455`


{: .note }
> O navegador dará erro de conexão, isso é normal e significa que a batida funcionou.

2.  **Pelo Winbox:** Agora abra o Winbox e conecte usando seu **DDNS/IP** e a sua porta personalizada (ex: `5050`).

## 💡 Dica de Ouro

Você pode automatizar essas batidas criando um arquivo `.bat` no Windows ou um atalho no celular que abre essas duas URLs em sequência. Assim, com um clique, você "**abre o cofre**" do seu MikroTik.

{: .tip }
> O `Port Knocking` é excelente porque não consome recursos de CPU processando tentativas de login inválidas; o firewall simplesmente descarta os pacotes de quem não conhece a batida secreta.