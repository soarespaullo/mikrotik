---
layout: default
title: "📝 Análise de Logs"
parent: "🛠️ Manutenção"
nav_order: 2
---

# 📝 Guia: Análise e Gerenciamento de Logs
{: .no_toc }

Os logs são os "olhos" do administrador de rede. No MikroTik, quase todos os eventos importantes são registrados aqui, mas sem organização, as informações críticas podem se perder em meio ao ruído.

---

## 🔍 Onde Visualizar os Logs

No Winbox, acesse a janela **Log** no menu lateral esquerdo. Por padrão, o RouterOS armazena os logs na memória RAM (eles são apagados se o roteador for reiniciado).

## 🛠️ Configurando Tópicos de Log (System Logging)

Você pode personalizar o que o `MikroTik` deve registrar e onde deve salvar. Acesse: **System → Logging**.

### 1. Criar um Filtro Customizado
Se você deseja monitorar apenas eventos de **PPPoE** e **Scripts**:
1. Vá na aba **Rules**.
2. Clique em **+**.
3. Em `Topics`, selecione `pppoe` e `info`.
4. Em `Action`, escolha `memory` (ou `disk` se quiser que os logs sobrevivam ao reboot).

### 2. Tópicos Essenciais para Monitoramento:
* `critical`: Erros de hardware ou falhas graves de sistema.
* `error`: Falhas em serviços (ex: script falhou).
* `warning`: Alertas de atenção.
* `account`: Registra quem logou no roteador.
* `script`: Mensagens geradas pelos seus scripts customizados.

---

## 🚨 Interpretando Erros Comuns

| Mensagem de Log | O que significa? |
| :--- | :--- |
| `pppoe,info: terminating... - user request` | O link foi derrubado manualmente ou pelo provedor. |
| `script,error: failure: Network unreachable` | Seu script tentou rodar antes da internet estar pronta. |
| `system,error,critical: login failure for user admin` | **Alerta!** Alguém está tentando invadir seu roteador via Brute Force. |
| `interface,info: ether1 link down` | Cabo desconectado ou falha física na porta. |


## 🤖 Enviando Logs para o Telegram via Script

Você pode criar um script que monitora o `log` e te avisa no `Telegram` quando algo específico acontece.

**Exemplo de lógica para o Terminal:**
```
:foreach i in=[/log find message~"login failure"] do={
    :local logMsg [/log get $i message]
    /tool fetch url="[https://api.telegram.org/bot](https://api.telegram.org/bot)<TOKEN>/sendMessage?chat_id=<ID>&text=Tentativa de Invasao: $logMsg" keep-result=no check-certificate=no
}
```

## 💾 Salvando Logs no Disco

Para evitar perder o histórico após uma queda de energia:

1. Vá em **System → Logging → Actions**.

2. Clique duas vezes em `disk`.

3. Defina `File Name` (ex: `log-file`).

4. Em **Rules**, altere a `Action` do tópico desejado de `memory` para `disk`.

{: .note }
>
> Ao criar scripts, use o comando `:log info "TEXTO"` ou `:log error "TEXTO"`. Isso facilita muito a filtragem na Wiki ou no Terminal para saber se sua automação está funcionando corretamente.