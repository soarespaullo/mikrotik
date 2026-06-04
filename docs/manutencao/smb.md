---
layout: default
title: "📂 Armazenamento SMB/Discos"
parent: "🛠️ Manutenção"
nav_order: 4
---

# 📂 Guia: Armazenamento SMB e Discos
{: .no_toc }

O MikroTik permite anexar armazenamento externo para expandir a memória flash limitada do dispositivo. Com o SMB (**Server Message Block**), você acessa esses arquivos diretamente pelo explorador de arquivos do Windows ou macOS.

---

## 💾 1. Preparando o Armazenamento (Format)

Antes de usar um **MicroSD** ou **Pendrive**, ele precisa ser formatado no sistema de arquivos do **RouterOS** para que o sistema consiga gravar os arquivos corretamente.

1.  No Winbox, vá em **System → Disks**.

2.  Localize o seu dispositivo na lista:

    *   **MicroSD:** Geralmente aparece como `disk1` ou `disk2`.

    *   **Pendrive USB:** Geralmente aparece como `usb1`.

3.  Selecione o disco desejado e clique no botão **Format Drive**.

4. Configure as opções conforme abaixo:

    *   **Slot:** Indica o local físico (**MicroSD** ou **USB**).

    *   **File System:** Use `ext4` (mais estável e moderno).

    *   **Label:** Nome do disco (ex: `STORAGE`).

    *   **MBR Partition Table:** Mantenha marcado para criar a tabela de partição.

4.  Clique no botão `Start`e aguarde concluir a formatação.

{: .important }
>
> A formatação apagará todos os dados contidos no `cartão` ou `pendrive`. Certifique-se de selecionar o disco correto antes de clicar em Format.

---

# 🔑 2. Criando Usuários de Acesso

Para segurança, defina quem pode ler e gravar nos arquivos.

1.  Vá em **IP → SMB**.

2.  Clique na aba **Users** e depois no **+**.

3.  **Name:** Escolha um nome (ex: `suporte`).

4.  **Password:** Defina uma senha segura.

5.  **Read Only:** Deixe `desmarcado` se quiser enviar arquivos para lá.

6.  Clique em **OK**.

---

## 📂 3. Configurando o Compartilhamento (Shares)

Aqui você define qual pasta do disco será visível na rede.

1.  Ainda em **IP → SMB**, vá na aba **Shares**.

2.  Clique no **+**.

3.  **Name:** Nome da pasta na rede (ex: `BKP-GERAL`).

4.  **Directory:** Clique na seta e selecione o disco (ex: `disk2`).

5. **Ajuste as permissões de acesso:**

    *   **Read Only:** Se marcado, os usuários poderão apenas ver e baixar arquivos, mas não poderão apagar ou salvar nada no disco.

    *   **Required Encryption:** Obriga que a conexão entre o PC e o MikroTik seja criptografada (mais seguro, recomendado para versões modernas do Windows).

    *   **Valid User:** Digite aqui os usuários (criados na aba Users do SMB) que podem acessar esta pasta. Se deixar vazio, todos os usuários válidos acessam.

    *   **Invalid User:** Digite os usuários que estão proibidos de acessar esta pasta específica.

5.  Clique em **OK**.

---

## 🌐 4. Ativando o Serviço SMB

Agora, ative o servidor para que ele fique visível na rede.

1.  Volte para a aba **Settings** em **IP → SMB**.

2.  No campo **Enabled**, selecione a opção `yes`.

3.  **Domain:** Pode manter `WORKGROUP`.

4.  **Comment:** Uma breve descrição (ex: `MikroTikSMB`).

5.  **Interfaces:** Selecione a sua Bridge principal (ex: `REDE SWITCH`).

{: .warning}
> Nunca selecione interfaces `WAN` aqui por segurança.

6. Clique em **Apply**.

---

## 💻 5. Como Acessar os Arquivos

### No Windows:

1.  Abra o **Explorador de Arquivos**.

2.  Na barra de endereços, digite o IP do seu MikroTik: `\\10.220.0.1`.

3.  Insira o usuário e senha criados no [**Passo 2**](https://github.com/soarespaullo/MikroTik/wiki/SMB-Storage#-2-criando-usu%C3%A1rios-de-acesso).

### No Linux (Interface Gráfica - GNOME/KDE):

1.  Abra o gestor de arquivos (Nautilus, Dolphin, Thunar).

2.  Procure pela opção **Outros Locais**, **Rede** ou **Conectar ao Servidor**.

3.  No campo de endereço, utilize o prefixo `smb://`:

    -   `smb://10.220.0.1`

4.  O sistema solicitará o usuário, o domínio (`WORKGROUP`) e a senha.

### No Linux (Terminal):

Se você quiser montar a pasta do `MikroTik` em um diretório do seu sistema (ex: `/mnt/mikrotik`), use o comando:


```bash
sudo mount -t cifs -o username=SEU_USUARIO //10.220.0.1/NOME_DO_SHARE /mnt/mikrotik

```

Quando não precisar mais do acesso ou for remover o `MicroSD` ou `pendrive` do `MikroTik`, desmonte a pasta no Linux com:


```bash
sudo umount /mnt/mikrotik
```

---

## 📤 6. Como Upar Arquivos para o Disco

Existem duas formas principais de colocar arquivos no seu `MicroSD` ou `Pendrive`:

### A. Via Winbox (Ideal para Firmware e Scripts)

Este método é o mais direto para arquivos pequenos ou técnicos do sistema.

1.  No Winbox, vá no menu lateral em **Files**.

2.  Na janela **File**, localize os arquivos que começam com o nome do seu disco (ex: `disk1/` ou `usb1/`).

3.  **Para Upar:** Basta arrastar o arquivo do seu computador e soltá-lo **em cima** da pasta do disco /ou clicar em `Upload` no menu lateral.

4.  **Para Mover:** Clique em cima do arquivo e arraste até a pasta criada (ex: `usb1-part1/NOME_DA_PASTA`).


### B. Via Rede (SMB) - Ideal para Backups de PCs

Como você já configurou o [**Passo 5**](https://github.com/soarespaullo/MikroTik/wiki/SMB-Storage#-5-como-acessar-os-arquivos), este é o método mais fácil para o dia a dia.

1.  Acesse a pasta mapeada no seu `Windows` ou `Linux`.

2.  **Copie e cole** os arquivos normalmente, como se fosse um **HD externo** ou um **Pendrive** espetado no seu próprio PC.

---

{: .note }
> **Dica de Organização (Subpastas)**
>
> Para não virar uma bagunça, você pode criar pastas dentro do disco pelo terminal do Winbox:

1.  Abra o **New Terminal**.

2.  Digite o comando: `/file add name=usb1-part1/NOME_DA_PASTA type=directory` *(Substitua `usb1-part1` pelo nome do seu slot e escolha o nome da pasta).*

{: .warning } 
> O protocolo **SMB** consome processamento (`CPU`). Evite transferir arquivos gigantescos enquanto o roteador estiver sob carga pesada de tráfego, para não afetar a performance da internet.