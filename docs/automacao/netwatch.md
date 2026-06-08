---
layout: default
title: 📡 Netwatch
parent: ⚡ Automação
nav_order: 3
---

# 📡 Guia: Monitoramento com Netwatch
{: .no_toc }

O **Netwatch** permite que o roteador "tome decisões" sozinho baseado na conectividade. É ideal para trocar rotas automaticamente ou avisar via Telegram quando um link cai.

---

## 🛠️ 1. Como Criar um Monitoramento (Winbox)

1. No menu lateral, vá em **Tools** → **Netwatch**.
2. Clique no botão **+**.
3. Na aba **Host**, preencha:
    * **Host:** O endereço IP que você deseja monitorar (ex: `8.8.8.8` do Google ou gateway da sua operadora).
    * **Interval:** De quanto em quanto tempo ele deve testar o IP (ex: `00:00:10` para testar a cada 10 segundos).
    * **Timeout:** Quanto tempo ele deve esperar a resposta do ping antes de considerar que caiu (ex: `1000ms`).

---

## ⚡ 2. Configurando as Ações (Scripts)

O Netwatch possui duas abas principais de ação: **Up** (quando o host responde) e **Down** (quando o host para de responder).

### **Aba Down (O que fazer quando cair):**

Aqui você coloca o comando ou o nome do script que deve rodar no momento da falha.

**Exemplo (Aviso no Log):**

 * `/log error "LINK PRINCIPAL FORA DO AR!"`

### **Aba Up (O que fazer quando voltar):**

Aqui você coloca o que deve acontecer quando a conexão for restabelecida.

**Exemplo (Aviso no Log):**

 * `/log warning "LINK PRINCIPAL RESTABELECIDO!"`

## 🤖 3. Exemplo Prático: Notificação no Telegram

Se você já seguiu o tutorial de [**Bot do Telegram**](https://soarespaullo.github.io/MikroTik/docs/automacao/bot-telegram/){: target="_blank" }, pode integrar o Netwatch para receber alertas no celular:

**Na aba Down:**

```
/tool fetch url="https://api.telegram.org/botTOKEN/sendMessage?chat_id=ID&text=ALERTA: Link Proxxima Caiu!" keep-result=no
```

**Na aba Up:**

```
/tool fetch url="https://api.telegram.org/botTOKEN/sendMessage?chat_id=ID&text=UFA: Link Proxxima Normalizado!" keep-result=no
```

## 🔍 4. Status do Netwatch

Na janela principal do Netwatch, você verá a coluna **Status**:

   * 🟢 **Up:** O host está respondendo normalmente.
   * 🔴 **Down:** O host não responde (o script de "Down" foi executado).
   * ⚪ **Unknown:** O teste ainda não foi iniciado ou o host é inválido.

## ⚠️ Dica de Ouro: Evite o "Falso Negativo"

Não monitore um IP que pode bloquear pings ou que seja instável por natureza. O ideal é monitorar o **DNS do Google (8.8.8.8)** ou o **Cloudflare (1.1.1.1)** para testar a internet real, ou o IP do roteador da operadora para testar apenas o link físico.


{: .tip }
> **Uso Avançado:** O Netwatch é muito usado em cenários de [**Failover**](https://soarespaullo.github.io/MikroTik/docs/redes/failover/){: target="_blank" }, onde ele desativa uma rota principal (`/ip route disable [find comment="rota1"]`) quando o link cai, forçando o roteador a usar o link reserva.
