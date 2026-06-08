---
layout: default
title: 🔑 Device Mode
parent: 🔒 Segurança & Acesso
nav_order: 2
---

# 🔑 Guia: Ativação do Device Mode
{: .no_toc }

Este tutorial descreve como libertar permissões para comandos sensíveis, como `/tool fetch` e `/system scheduler`, que são frequentemente bloqueados por padrão nas versões mais recentes do RouterOS para aumentar a segurança do dispositivo.

---

## 📌 O que é o Device Mode?

A MikroTik introduziu o **Device Mode** para impedir que scripts maliciosos façam downloads de ficheiros externos ou executem agendamentos automáticos sem a autorização física do administrador.

Se o teu script de notificações (Telegram) ou de backup parou de funcionar com o erro:
`failure: not allowed by device-mode`
Este guia é a solução definitiva.

---

## 🛠️ Passo a Passo para Libertar o Acesso

{: .important }
> **Aviso Prévio:** Este procedimento exige **acesso físico** ao equipamento. Por questões de segurança, a MikroTik não permite completar a ativação de forma 100% remota.

### 1. Verificar as permissões atuais
Abre o Terminal no Winbox e executa:
```bash
/system/device-mode/print
```
Observa se os itens `fetch` e `scheduler` estão marcados como no.

2. Solicitar a atualização de permissões
Para libertar as funções necessárias para os teus scripts e automações, executa o seguinte comando:

```bash
/system/device-mode/update fetch=yes scheduler=yes email=yes
```
3. Confirmação Física (Obrigatório)
Após executares o comando acima, o **RouterOS** entrará num estado de espera por 5 minutos.

1. **No Roteador:** Prime rapidamente o botão **RESET** ou o botão **MODE** (apenas um clique rápido, não segures o botão).

2. **Resultado:** O roteador irá reiniciar automaticamente para validar a nova política de segurança.

## 💡 Troubleshooting (Resolução de Problemas)
"Estou remoto e não posso premir o botão"

Infelizmente, por design de segurança, **não existe bypass**. Se o router estiver num local remoto, as funções de `fetch` e `scheduler` permanecerão bloqueadas até que alguém carregue no botão físico.

"**O comando de update não funciona**"

Verifica se a tua versão do RouterOS é a v7.13 ou superior. Em versões muito antigas (anteriores à v6.49.8), este modo não existe e o erro de permissão costuma estar relacionado com as `policies` do grupo de utilizador.

"**Premir o botão vai apagar as minhas configurações?**"

**NÃO**. Durante a janela de 5 minutos do comando update, o clique no botão serve apenas como uma "assinatura física". O router apenas reinicia; as tuas configurações de IP, Firewall e NAT permanecerão intactas.

## 📑 Exemplo de Script Funcional (Após Libertação)
Uma vez ativo o `fetch`, podes usar scripts como este para testar a comunicação com a API do Telegram:

```bash
/tool fetch url="https://api.telegram.org/TOKEN/sendMessage?chat_id=CHAT_ID&text=Teste+Wiki!" keep-result=no check-certificate=no
```
