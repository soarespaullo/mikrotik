---
layout: default
title: "💾 Scripts de Backup"
parent: "🛠️ Manutenção"
nav_order: 1
---

# 💾 Guia: Backup MikroTik (RouterOS v7)
{: .no_toc }

Este guia cobre as três formas essenciais de garantir a segurança da sua configuração: Backup Binário, Exportação via Terminal e Automação com envio por E-mail.

---

## 📧 1. Configurando o Servidor de E-mail

Antes de automatizar, o `MikroTik` precisa ter permissão para enviar e-mails.

1. Vá em **Tools → Email**.

2. Preencha os campos conforme seu provedor (Ex: `Gmail`):

    *    **Server:** `smtp.gmail.com`

    *    **Port:** `587`

    *    **Start TLS:** `yes`

    *    **From:** `seu-email@gmail.com`

    *    **User:** `seu-email@gmail.com`

    *    **Password:** `senha_de_aplicativo` (No Gmail, use "Senhas de App").

---

## 🛡️ 2. Backup Binário (.backup) — Manual

Uso: Recuperação total em caso de pane no mesmo roteador.

- **Via Winbox**: Vá em Files → Backup. Defina um nome e uma senha.

- **Via Terminal**:

```bash
/system backup save name=backup_manual password=SUA_SENHA
```

Arraste o arquivo da janela **Files** para seu computador após a criação.

## 📄 3. Exportação de Texto (.rsc) — Manual

Uso: Ler as configurações ou migrar para outro modelo de MikroTik.

**Via Terminal**:

```bash
/export terse file=config_manual
```

{: .note }
> **O que é o `terse`?**
>
> Este parâmetro `remove quebras de linha e formata cada comando em uma única linha contínua`. Isso torna o arquivo de backup mais organizado para buscas e evita erros de sintaxe ao copiar e colar os comandos em outro `MikroTik`.

O arquivo aparecerá na lista `Files` pronto para **DOWNLOAD**.

---

🤖 4. Automação: Backup por E-mail (Script v7)
-----------------------------------------------

Este script gera o backup (`.rsc`) e envia por *e-mail* com o status completo: **IP (WAN/PPPoE), Uptime formatado, Modelo da RB e Versão**.

1. Vá em **System → Scripts**, clique em **+**.
    
    *   **Name:** `Bk-Mail`

    *   **Policy:**`read`, `write`, `policy`, `test`, `sensitive`, `password` e `ftp`.

    *   **Comment:** Backup MikroTik: Export .rsc via E-mail.

    *   **Source:** Obtenha o código fonte através dos botões abaixo e cole neste campo.

### 📥 Obtenção do Script e Implantação

Escolha a forma mais adequada para obter o código-fonte ou inspecionar o arquivo direto no repositório:

[**📥 Baixar Arquivo (.rsc)**](https://raw.githubusercontent.com/soarespaullo/MikroTik/main/scripts/Bk-Mail.rsc){: .btn .btn-blue target="_blank" }
[**👁️ Inspecionar Código no GitHub**](https://github.com/soarespaullo/MikroTik/blob/main/scripts/Bk-Mail.rsc){: .btn .btn-outline target="_blank" }

---

## 📅 5. Agendando o Envio Automático

Para que o script rode sozinho (ex: `toda madrugada`), precisamos de um agendamento com permissões administrativas completas.

1.  Vá em **System → Scheduler** e clique em **+**.

    -   **Comment:** Backup MikroTik: Export .rsc via E-mail.

    -   **Name:** `Sched-Bk-Mail`.

    -   **Start Time:** `03:00:00`.

    -   **Interval:** `1d 00:00:00` (Executa uma vez por dia).

    -   **On Event:** Digite o nome exato do script: `Bk-Mail`.

    -   **Policy:** `read`, `write`, `policy`, `test`, `sensitive`, `ftp` e `password`

{: .important }
>
> As permissões marcadas aqui no **Scheduler** devem ser **exatamente as mesmas** que você marcou dentro do menu **System → Scripts**. Se o agendador tiver menos permissões que o script, o backup retornará o erro "`not enough permissions`".
