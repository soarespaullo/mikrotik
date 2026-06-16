---
layout: default
title: 🏁 Configuração Inicial
nav_order: 2
parent: 🚀 Primeiros Passos
last_modified_date: 2026-06-08 14:40
---

# 🚀 Guia: Configuração Inicial do MikroTik
{: .no_toc }

Este guia aborda os passos fundamentais para tirar um MikroTik da caixa, limpar as configurações de fábrica e deixá-lo pronto para navegar com segurança e organização.

---

{: .note }
> **Dica de Navegação:** Criamos um [**Mapa de Fluxo Visual da Configuração**](https://soarespaullo.github.io/mikrotik/docs/primeiro-passos/mapa/) para ajudar a acompanhar a ordem cronológica dos passos em uma tela separada.

---

## 🧹 1. Limpeza de Fábrica (Reset)

Ao ligar o MikroTik pela primeira vez, um pop-up aparecerá. Clique sempre em **Remove Configuration**.

{: .important }
> Se você esqueceu de clicar ou o roteador já veio configurado, faça o reset manual:
> 1. Vá em **System** → **Reset Configuration**.
> 2. Marque a opção **No Default Configuration**.
> 3. Clique em **Reset Configuration**. Isso garante que o roteador esteja *100%* "limpo".

---

## 🆔 2. Identidade e Organização

Antes de configurar a rede, identifique o seu equipamento e as portas físicas.

* **Nome do Roteador**: Vá em **System** → **Identity** e dê um nome ao seu roteador (ex: `Borda-Principal`).
* **Renomear Interfaces**: Vá em **Interfaces**. Dê um clique duplo na porta e renomeie para facilitar a identificação:
  * `ether1` → `ether1-link-proxxima`
  * `ether5` → `ether5-rede-local`

---

## 🏠 3. Configuração da Rede Local (LAN)

### Definir o IP do Roteador
1. Vá em **IP** → **Addresses** e clique em **+**.
2. **Address**: `10.220.0.1/24`
3. **Interface**: `ether5-rede-local`.

### Criar o Servidor DHCP
1. Vá em **IP** → **DHCP Server** e clique no botão **DHCP Setup**.
2. Siga o assistente:
   * **Interface**: `ether5-rede-local`.
   * **Gateway**: `10.220.0.1`.
   * **Addresses to Give Out**: `10.220.0.2-10.220.0.254`.
   * **DNS Servers**: `8.8.8.8` e `1.1.1.1`.
   * **Lease Time**: `00:30:00`.

{: .tip }
> O **Lease Time** (`30 minutos`) é o tempo que o `IP` fica reservado para o dispositivo. Em redes com muita rotatividade, tempos curtos são melhores; em redes fixas, você pode aumentar para `08:00:00` (`8 horas`).
>
> **Addresses to Give Out**. Caso você precise reservar `IPs` para equipamentos fixos (como `Servidores`, `Impressoras` ou `DVRs`), ajuste o range para iniciar em um número mais alto, por exemplo: `10.220.0.100-10.220.0.254`.
>
> Isso deixa os `IPs` iniciais (`.2 ao .99`) livres para você configurar manualmente nos aparelhos, garantindo que o `MikroTik` não entregue esses mesmos endereços para outros dispositivos via `DHCP`, evitando conflitos de `IP` na rede.

---

## 🌐 4. Configuração do Link de Internet (WAN)

Dependendo do seu provedor, a conexão será feita via **PPPoE** (`Usuário e Senha`) ou **DHCP** (`IP Automático`). Escolha a opção que se aplica ao seu cenário:

### **Opção A: Conexão via PPPoE**
> Caso seu provedor exija autenticação (`Usuário` e `Senha`), como um modem em modo bridge ou tecnologia de fibra que utiliza o protocolo (`PPPoE`).

1. Vá em **PPP** → **+** → **PPPoE Client**.
2. **Aba General:**
* **Name:** `pppoe-cliente-proxxima` 
* **Interface:** `ether1-link-proxxima`.
3. **Aba Dial Out:** Insira o **User** e **Password** fornecidos pelo seu provedor de internet.
4. **Allow:** Desmarque a opção `pap` e deixe marcadas apenas as opções `chap`, `mschap1` e `mschap2`.
5. Marque **Add Default Route**.
6. Garanta que **Add Default Route** esteja marcado (ou deixe `desmarcado` se você estiver configurando o [**Failover**](https://soarespaullo.github.io/mikrotik/docs/redes/failover/){: target="_blank" }) manualmente).

{: .warning }
> Certifique-se de desmarcar a opção `pap`. Esse protocolo envia a senha em texto plano (`sem criptografia`) pela rede, o que representa uma falha de segurança.

{: .note }
> Verifique se o **Status** na parte inferior da janela mostra `connected`.

### **Opção B: Conexão via DHCP Client**
> Caso seu provedor entregue a internet via DHCP (`IP Automático`), como um modem em modo roteador ou tecnologia fibra direta (`DHCP`).

1. Vá em **IP** → **DHCP Client**
2. Clique no botão **+**.
3. Na aba **DHCP:**
* **Interface:** Escolha a interface física onde o cabo do provedor está conectado (ex: `ether1-link-proxxima-dhcp`).
* **Add Default Route:** Garanta que esteja marcado como `yes` (ou `no` se você estiver configurando o [**Failover**](https://soarespaullo.github.io/mikrotik/docs/redes/failover/){: target="_blank" }) manualmente).
4. Clique em **Apply** e **OK**.

{: .note }
> Verifique se o **Status** na parte inferior da janela mostra `bound`.

---

## 🛠️ 5. DNS, NAT e Navegação

Para que os dispositivos da rede interna consigam navegar, precisamos de duas coisas:

1. **DNS do Sistema:** Vá em **IP** → **DNS** → **Servers** → **+**. E adicione `8.8.8.8` e `1.1.1.1`.
2. **Regra de NAT (Masquerade):** A regra de `NAT` "*esconde*" os `IPs` da sua rede local atrás do `IP público` do link. Crie a regra de acordo com a sua conexão (ou ambas, se for usar [**Failover**](https://soarespaullo.github.io/mikrotik/docs/redes/failover/){: target="_blank" }):

**Para Link PPPoE:**

Vá em **IP** → **Firewall** → **NAT** → Clique no **+**.

   * **Chain:** `srcnat`.
   * **Out. Interface:** `pppoe-cliente-proxxima`.
   * **Action:** `masquerade`.

**Para Link DHCP (IP Automático):**

   * Vá em **IP** → **Firewall** → **NAT** → Clique no **+**.
   * **Chain:** `srcnat`.
   * **Out. Interface:** `ether1-link-proxxima-dhcp` (Escolha a interface onde o cabo da internet está).
   * **Action:** `masquerade`.

---

## 🌉 6. Configuração de Bridge (Unir Portas)

A Bridge permite que o `MikroTik` funcione como um `Switch`, unindo várias portas físicas na mesma rede local.

1. **Criar a Ponte:**

   * Vá em **Bridge** e clique em **+**.
   * **Name:** `REDE-SWITCH`.
   * Clique em **OK**.

2. **Vincular as Portas:**

   * Na aba **Ports**, clique em **+**.
   * **Interface:** Selecione a porta (ex: `ether5-rede-local`).
   * **Bridge:** `REDE-SWITCH`.
   * Clique em **OK** e repita para as outras portas (exceto a que você está usando para configurar agora, se desejar evitar quedas)

3. **Migrar o IP Address para a Bridge:** Como o `IP` estava na `ether5`, precisamos movê-lo para a `Bridge` para que todas as portas respondam por ele.

   * Vá em **IP** → **Addresses**.
   * Dê um clique duplo no IP `10.220.0.1/24`.
   * Mude o campo **Interface** de `ether5-rede-local` para **REDE-SWITCH**.
   * Clique em **OK**.

4. **Migrar o DHCP Server para a Bridge:** Para que os dispositivos recebam `IP` em qualquer porta da Bridge:

   * Vá em **IP** → **DHCP Server**.
   * Na aba **DHCP**, dê um clique duplo no servidor criado (ex: `dhcp1`).
   * Mude o campo **Interface** para **REDE-SWITCH**.
   * Clique em **OK**.

{: .important }
> Se o `IP` e o `DHCP` ficarem presos à `ether5`, as outras portas da Bridge (como a `ether2`, `ether3`, `ether4`) não conseguirão navegar ou entregar endereços aos dispositivos. 
Ao mudar para a interface **REDE-SWITCH**, você ativa a rede em todo o "`Switch`" virtual.

---

## 🆙 7. Atualização do Sistema

Mantenha seu `MikroTik` seguro e estável.

Vá em **System** → **Packages** e clique em **Check For Updates**.

**Diferença entre Canais (Channels):**
 
* **Long Term**: Estabilidade máxima (Produção).
* **Stable**: Novos recursos testados.
* **Testing:** Versão de pré-lançamento.
* **Development**: Apenas para laboratório (Risco de travamento).

---

## 👤 8. Criando Usuário de Acesso

{: .warning}
> **NUNCA** use o usuário admin sem senha.

1. Vá em **System** → **Users** e clique em **+**.

2. **Name:** Crie seu nome de usuário.

3. **Group:** `full` (Acesso total).

4. **Password:** Digite uma senha forte.

5. Após criar o seu, desative ou remova o usuário `admin` padrão.

---

## 🛡️ 9. Desativar Serviços Desnecessários

O MikroTik vem com várias "`portas`" abertas por padrão que você não vai usar e que podem ser alvos de ataques.

1. Vá em **IP** → **Services**.

2. Clique no botão **Disable** (`ícone cinza de Pause`) para desabilitá-los.

    * `api`, `api-ssl`, `ftp`, `telnet`, `www` (acesso via navegador).

3. **Mantenha apenas:**

    * `winbox` (para configurar) e `ssh` (caso precise de acesso remoto via terminal).

{: .tip }
> Você pode mudar a porta do winbox (`padrão 8291`) para uma porta aleatória (ex: `54321`) para dificultar a vida de invasores.

---

## ⏰ 10. Ajuste de Horário (NTP)

Para que os logs, agendamentos e scripts funcionem corretamente, o roteador precisa manter a hora sincronizada. Utilizamos os servidores oficiais do projeto [**NTP.br**](https://ntp.br/){: target="_blank" }.

1. Vá em **System** → **NTP Client**.
2. Marque a caixa `Enabled`.
3. No campo **NTP Servers**, clique no **+** adicione os seguintes servidores:
    * a.st1.ntp.br
    * b.st1.ntp.br
4. Vá em **System** → **Clock** e confirme se o **Time Zone Name** está como `America/Sao_Paulo`.

---

## 🗄️ 11. Backup de Segurança

Existem dois tipos de arquivos que você deve gerar ao finalizar a configuração:

* **Backup Binário (.backup):** Salva tudo, inclusive senhas. Use para restaurar no mesmo aparelho.

    * Vá em **Files** → **Backup**.

* **Script de Exportação (.rsc):** Salva as configurações em texto. Ótimo para conferir o que foi feito.
   
    * Abra o **New Terminal** e digite: `export file=BKP_MIKROTIK`.