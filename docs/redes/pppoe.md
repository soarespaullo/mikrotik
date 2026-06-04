---
layout: default
title: 🌐 PPPoE Cliente/Server
parent: 📡 Redes & Links
nav_order: 2
---

# 🌐 Guia: PPPoE Client e PPPoE Server
{: .no_toc }

O protocolo **PPPoE** (Point-to-Point Protocol over Ethernet) é o padrão mais utilizado por provedores para autenticação de usuários, permitindo controle de banda e entrega de IP de forma organizada.

---

## 📥 1. PPPoE Client (Receber Internet)

> Use este método se você tem um link de internet que exige usuário e senha.

### Passo a Passo (Winbox):

1. Vá em **Interfaces** e clique no botão **+**.
2. Selecione **PPPoE Client**.
3. Na aba **General**:
    * **Name:** `pppoe-internet`
    * **Interface:** Selecione a porta onde o cabo da operadora está conectado (ex: `ether1`).
4. Na aba **Dial Out**:
    * **User:** Digite o usuário fornecido pelo provedor.
    * **Password:** Digite a senha.
    * **Allow:** Deixe marcados `chap`, `mschap1` e `mschap2`.
    * **Use Peer DNS:** Marque se quiser usar o DNS da operadora.
    * **Add Default Route:** Marque para o roteador criar a rota de internet automaticamente.
5. Clique em **OK**.

**Verificação:** Se aparecer um **"R"** (Running) ao lado do nome, a conexão foi estabelecida com sucesso.

---

## 📤 2. PPPoE Server (Distribuir Internet)

> Use este método se você quer criar usuários e senhas para quem se conecta ao seu MikroTik.

### Passo 1: Criar o Pool de IPs
1. Vá em **IP** → **Pool**. Clique em **+**.
2. **Name:** `pool-pppoe`
3. **Addresses:** `10.10.10.2-10.10.10.254` (IPs que os clientes vão receber).

### Passo 2: Criar o Perfil (Profile)
1. Vá em **PPP** → **Profiles**. Clique em **+**.
2. **Name:** `perfil-cliente`
3. **Local Address:** `10.10.10.1` (IP do seu roteador na rede PPPoE).
4. **Remote Address:** Selecione o `pool-pppoe`.
5. Na aba **Limits**, você pode definir o controle de banda (ex: `10M/10M`).

### Passo 3: Criar o Servidor
1. Na aba **PPP** → **PPPoE Service**, clique em **+**.
2. **Service Name:** `servidor-meu-provedor`
3. **Interface:** Selecione em qual porta os clientes estão (ex: `bridge-local`).
4. **Default Profile:** Selecione o `perfil-cliente`.
5. Marque **One Session Per Host** (evita que o mesmo usuário logue duas vezes).

### Passo 4: Criar os Usuários (Secrets)
1. Na aba **PPP** → **Secrets**, clique em **+**.
2. **Name:** `joao_silva`
3. **Password:** `senha123`
4. **Service:** `pppoe`
5. **Profile:** `perfil-cliente`

---

## 🔄 3. Resumo da Conexão

| Função | O que faz? | Onde configurar? |
|:--- |:--- |:--- |
| **Client** | Conecta na operadora | Interfaces → PPPoE Client |
| **Server** | Cria a autenticação local | PPP → PPPoE Service |
| **Secret** | Cadastro de usuário/senha | PPP → Secrets |
| **Profile** | Regras de velocidade e IP | PPP → Profiles |

---

## ⚠️ Dicas Importantes

{: .warning }
> **MTU:** O padrão PPPoE é `1492`. Se os sites demorarem a carregar ou algumas imagens não abrirem, verifique se o MTU está correto no Client.

{: .important }
> **Firewall NAT:** Se você criou um PPPoE Server, não esqueça de adicionar uma regra de **Masquerade** em **IP** → **Firewall** → **NAT** para que seus clientes consigam navegar.

{: .note }
> **Interface:** Nunca coloque um PPPoE Server em uma interface que já tenha um DHCP Server rodando sem os devidos cuidados, para evitar conflitos de rede.
