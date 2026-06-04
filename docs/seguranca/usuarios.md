---
layout: default
title: "👤 Gerenciamento de Usuários"
parent: "🔒 Segurança & Acesso"
nav_order: 12
---

# 👤 Guia: Gerenciamento de Usuários
{: .no_toc }

O controle de usuários permite definir quem pode configurar o roteador e quais alterações cada pessoa pode realizar, além de proteger o equipamento contra acessos não autorizados.

---

## 🪜 1. Criando um Novo Usuário

1.  Vá em **System → Users**.

2.  Na aba **Users**, clique no botão **+**.

3.  Preencha os campos conforme abaixo:

    *   **Name:** Digite o nome de login (ex: `suporte`).

    *   **Group:** Escolha o nível de permissão (veja a tabela no Passo 2).

    *   **Password:** Defina uma senha forte.

4.  Clique em **OK**.

## 🛡️ 2. Entendendo os Grupos (Permissões)

| **Grupo** | **Nível de Acesso** | **Descrição** |
| --- | --- | --- |
| **Full** | **Total** | Pode alterar tudo, inclusive gerenciar outros usuários e ver senhas. |
| **Write** | **Configuração** | Pode alterar quase tudo, mas **não** tem acesso ao menu de usuários. |
| **Read** | **Leitura** | Pode apenas visualizar as configurações e gráficos. Não pode alterar nada. |

## 🚫 3. Desativando/Excluindo o Usuário Admin (Essencial)

O usuário `admin` é o alvo número 1 de ataques. O ideal é nunca utilizá-lo.

1.  **Primeiro:** Logue no Winbox com o **novo usuário** que você criou (garanta que ele seja do grupo **Full**).

2.  Vá em **System → Users**.

3.  Clique uma vez sobre o usuário `admin`.

4.  Clique no botão **"X" (Remove)** no topo da janela.

{: .important }
> **Nunca desative o admin antes de testar seu novo usuário!** Se a senha nova estiver errada e você desativar o admin, você perderá o acesso ao roteador.

## 🔐 4. Restrição por IP (Allowed Address)

1.  Dentro do cadastro do usuário, localize o campo **Allowed Address**.

2.  Digite o IP do seu computador (ex: `10.220.0.50`) ou o range da sua rede local (ex: `10.220.0.0/24`).

{: .note }
> Se preenchido, o sistema bloqueará o login mesmo com a senha correta se o acesso vier de um IP fora da lista.

## ⏳ 5. Controle de Sessão (Inatividade)

Para evitar que o Winbox fique aberto por esquecimento, configure o tempo de expiração:

1.  **Inactive Timeout:** Defina o tempo de espera (Ex: `00:10:00` para 10 minutos).

2.  **Inactive Policy:** Escolha a ação após o tempo esgotar:

    *   **none (padrão):** Apenas encerra a conexão. Você precisará digitar usuário e senha novamente para entrar.

    *   **logout:** Força o encerramento da sessão atual no roteador. É a opção mais limpa para garantir que o acesso foi fechado.

    *   **lockscreen:** Funciona como o "bloqueio de tela". A sessão continua aberta no fundo, mas o Winbox pede a senha para voltar ao que você estava fazendo.

---

❓ Por que usar usuários diferentes?

*   **Logs de Auditoria:** No menu **System → Logs**, você verá exatamente qual usuário fez cada alteração.

*   **Segurança:** O **Inactive Timeout** garante que ninguém mexa no seu Winbox se você se ausentar da mesa e esquecer a tela aberta.

*   **Organização:** Permite separar acessos para técnicos (Write) e apenas monitoramento (Read).