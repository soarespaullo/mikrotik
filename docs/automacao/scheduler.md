---
layout: default
title: 🕒 Agendamentos (Scheduler)
parent: ⚡ Automação
nav_order: 2
---

# 🕒 Guia: Agendamentos Automáticos (Scheduler)
{: .no_toc }

O **Scheduler** (Agendador) é a ferramenta do MikroTik que permite executar scripts ou comandos em horários específicos ou em intervalos regulares (diários, semanais, etc.).

---

## ⚙️ 1. Como criar um Agendamento (Winbox)

Para automatizar qualquer tarefa, como o backup por e-mail ou a atualização de DDNS, siga estes passos:

1. No menu lateral do Winbox, vá em **System** → **Scheduler**.
2. Clique no botão **+** (Add) para criar um novo agendamento.
3. Preencha os campos principais:
    * **Name:** Um nome para identificar a tarefa (ex: `Tarefa_Backup_Diario`).
    * **Start Date:** A data em que o agendamento deve começar a valer.
    * **Start Time:** O horário exato da primeira execução (ex: `03:00:00` para rodar na madrugada).
    * **Interval:** De quanto em quanto tempo a tarefa deve se repetir.
        * Para rodar todo dia: `1d 00:00:00`.
        * Para rodar a cada hora: `01:00:00`.
    * **On Event:** Aqui você digita o **nome do Script** que você criou ou os comandos diretamente.

---

## 🛠️ 2. Configurações Importantes

### Políticas (Policies)
Para que o agendamento funcione, ele precisa de permissões de acesso. Na aba **Policies**, geralmente as seguintes opções devem estar marcadas para scripts de backup:
`read`, `write`, `policy`, `test`, `password`, `sensitive`.

### Start Time: "startup"
Se você quiser que um script seja executado **toda vez que o roteador ligar** ou reiniciar:
No campo **Start Time**, em vez de um horário, digite a palavra: `startup`.

---

## 📋 3. Exemplos de Intervalos Comuns

| Frequência | Valor no Campo Interval |
|:---|:---|
| **Diário** | `1d 00:00:00` |
| **Semanal** | `7d 00:00:00` |
| **A cada 12 horas** | `12:00:00` |
| **A cada 5 minutos** | `00:05:00` |
| **Execução única** | `00:00:00` (Deixe zerado) |

---

## 🔍 4. Monitorando a Execução

Após configurar, você pode acompanhar o status na própria janela do Scheduler:

* **Run Count:** Mostra quantas vezes o script já foi executado.
* **Next Run:** Informa exatamente quando será a próxima execução.
* **Log:** Se o seu script tiver comandos de log (ex: `/log info "Backup realizado"`), você poderá ver o histórico na janela **Log** do Winbox.

{: .tip }
> Sempre teste o seu Script manualmente no menu **System** → **Scripts** clicando em **Run Script** antes de agendá-lo. Se ele não funcionar manualmente, o agendamento também falhará.
