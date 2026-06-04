---
layout: default
title: "🆙 Atualização do Sistema"
parent: "🛠️ Manutenção"
nav_order: 5
---

# 🆙 Guia: Atualização do Sistema (RouterOS & Firmware)

Manter o MikroTik atualizado protege contra vulnerabilidades e melhora o desempenho. A atualização é dividida em duas etapas obrigatórias.

---

## 🏗️ 1. Entendendo os Canais (Channels)

{: .note }
> Antes de clicar em atualizar, você deve escolher a "`estrada`" que o seu roteador vai seguir:

*   **Long Term:** Foco total em estabilidade. Recomendado para empresas e roteadores de borda.

*   **Stable:** Versão oficial com novos recursos. Ótimo para uso doméstico avançado e provedores.

*   **Testing:** Versão de pré-lançamento para testes de bugs.

*   **Development:** Versão beta/experimental. **Não use em produção.**

---

## 📥 2. Atualizando o Software (RouterOS)

Este passo atualiza o sistema operacional do roteador.

1.  Vá em **System → Packages**.

2.  Clique no botão **Check For Updates**.

3.  Em **Channel**, selecione o canal desejado (Recomendado: `Long Term`).

4.  Clique em **Download & Install**.

{: .warning }
> O roteador irá baixar os arquivos e reiniciar automaticamente. A rede ficará fora do ar por cerca de 1 a 2 minutos.

---

## ⚡ 3. Atualizando o Firmware (BIOS/RouterBOARD)

Muitos administradores esquecem este passo. Ele atualiza o chip da placa-mãe do MikroTik.

1.  Após o roteador reiniciar da atualização anterior, vá em **System → RouterBOARD**.

2.  Compare o **Current Firmware** com o **Upgrade Firmware**.

3.  Se o *Upgrade* for mais recente, clique no botão **Upgrade**.

4.  O Winbox pedirá uma confirmação. Clique em **Yes**.

5.  **Importante:** O firmware só é aplicado após um novo reboot manual. Vá em **System → Reboot** e confirme.


{: .important }
> Nunca desligue a energia do roteador durante o processo de atualização do firmware (**RouterBOARD**), pois isso pode corromper a **BIOS** do equipamento.

---

## 🛠️ 4. Atualização via Arquivo (Offline)

Se o roteador não tiver acesso à internet, você pode atualizar manualmente:

1.  Baixe o arquivo `.npk` correspondente à arquitetura do seu roteador (ex: `arm64`, `mmips`, `mipsbe`) no site oficial [**mikrotik.com/download**](https://mikrotik.com/download).

2.  Abra o Winbox e vá em **Files**.

3.  Arraste o arquivo baixado do seu PC para dentro da janela **Files** do Winbox.

4.  Vá em **System → Reboot**. O roteador identificará o arquivo e atualizará sozinho durante a reinicialização.

---

✅ 5. Verificação Final
----------------------

Após os reboots, verifique:

-   Em **System → Resources**: Se a versão do RouterOS está correta.

-   Em **System → RouterBOARD**: Se o *Current Firmware* agora iguala o *Upgrade Firmware*.