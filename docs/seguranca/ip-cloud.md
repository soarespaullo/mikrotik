---
layout: default
title: "☁️ IP Cloud (DDNS)"
parent: "🔒 Segurança & Acesso"
nav_order: 9
last_modified_date: 2026-06-08 23:15
---

# ☁️ Guia: IP Cloud (DDNS)
{: .no_toc }

O serviço de **Cloud** da MikroTik fornece um nome de domínio gratuito (ex: `524f0542324a.sn.mynetname.net`) que aponta sempre para o IP atual da sua internet, permitindo o acesso remoto de qualquer lugar do mundo.

## 🪜 1. Ativando o DDNS

1.  Vá em **IP ➔ Cloud**.

2.  No campo **DDNS Enabled**, selecione a opção `Yes`.

3.  (Opcional) Marque **Update Time** para que o roteador também use os servidores da **MikroTik** para ajustar o relógio.

4. **DDNS Update Interval:** Defina este campo para `01:00:00` (1 hora).

5.  Clique em **Apply**.

{: .warning }
> Evite deixar o **DDNS Update Interval** em tempos muito baixos (como `00:01:00`). Consultas a cada 1 minuto podem fazer os servidores da MikroTik bloquearem o seu domínio temporariamente por excesso de requisições (Spam). O recomendado é manter entre 10 minutos e 1 hora.

{: .note }
> Embora o IP Cloud ofereça a opção **Update Time**, para garantir uma precisão milimétrica nos logs e agendamentos do seu roteador, o recomendado é utilizar servidores nacionais dedicados. Após ativar o DDNS, configure o nosso [**Guia de Ajuste de Hora (NTP Client)**](https://soarespaullo.github.io/mikrotik/docs/manutencao/ntp/){: target="_blank" } para deixar o relógio do seu MikroTik 100% confiável.

## 🔗 2. Obtendo seu Endereço de Acesso

Após clicar em **Apply**, observe os campos que foram preenchidos:

*   **Public Address:** Mostra qual é o seu IP de internet atual.

*   **DNS Name:** Este é o seu endereço fixo. É este "nome" cheio de letras e números que você usará no Winbox ou no celular para acessar o roteador remotamente.

{: .note }
> Copie esse **DNS Name** e salve em um bloco de notas ou criei um [**"Nome Amigável"**](https://soarespaullo.github.io/mikrotik/docs/seguranca/ip-cloud/#%EF%B8%8F-3-criando-um-nome-amig%C3%A1vel-no-ip). Mesmo que a operadora mude seu IP, esse nome nunca muda, pois ele é baseado no **Serial Number** do seu equipamento.

---

## 🏷️ 3. Criando um Nome Amigável (No-IP)

O endereço gerado pelo IP Cloud da MikroTik é extremamente estável, mas decorar uma sequência de letras e números aleatórios não é nada prático. Para resolver isso, você pode criar um subdomínio gratuito em serviços externos e mascarar esse "**endereço feio**" usando um apontamento do tipo **CNAME**.

A grande vantagem deste método é que você **não precisa de scripts no roteador**. Quem atualiza o IP é o **Cloud da MikroTik**; o seu domínio gratuito apenas o segue.

1. Acesse o site do [**No-IP**](https://www.noip.com/){: target="_blank" }, crie/acesse sua conta gratuita e vá na aba de gerenciamento de domínios (**Gerencie DNS/DNS Records**).
2. Clique no botão **Criar hostname** e preencha os campos exatamente assim:
   * **Type:** Clique no menu de opções e mude de `A` para `CNAME`.
   * **Host:** Digite o nome amigável que você escolheu (Ex: `mikrotik`). Ao lado, selecione o domínio gratuito desejado (Ex: `.ddns.net`).
   * **Target:** Cole o seu **DNS Name** completo da MikroTik (gerado lá no Passo 2, ex: `524f0542324a.sn.mynetname.net`).
   * **TTL:** Pode deixar o valor padrão que o site carregar automaticamente.
3. Clique em **Criar**.

{: .tip }
> Pronto! A partir de agora, em vez de digitar aquele código gigante no Winbox, você usará apenas o seu endereço amigável (ex: `mikrotik.ddns.net`) para se conectar remotamente.

---

## 🛡️ 4. Considerações de Segurança

Ao ativar o Cloud, seu roteador ganha um "nome" na internet. Para sua segurança, certifique-se de:

1.  [**Trocar a senha padrão:**](https://soarespaullo.github.io/mikrotik/docs/primeiro-passos/configuracao-inicial/#-8-criando-usu%C3%A1rio-de-acesso){: target="_blank" } Nunca use o usuário `admin` sem senha ([**conforme fizemos no Guia de Configuração Inicial**](https://soarespaullo.github.io/mikrotik/docs/primeiro-passos/configuracao-inicial/){: target="_blank" }).

2.  [**Portas de Serviço:**](https://soarespaullo.github.io/mikrotik/docs/seguranca/bloqueio-servicos/){: target="_blank" } Se você for acessar de fora, lembre-se que as portas padrão (8291 para Winbox) devem estar abertas ou alteradas em ([**IP ➔ Services**](https://soarespaullo.github.io/mikrotik/docs/seguranca/bloqueio-servicos/){: target="_blank" }).

---

## ❓ Por que usar o IP Cloud?

*   **Acesso Remoto:** Você pode entrar no [**Winbox**](https://mikrotik.com/download/winbox/){: target="_blank" } do **escritório estando em casa** ou pelo celular ([**usando o app MikroTik**](https://mikrotik.com/download/mobile){: target="_blank" }).

*   **VPNs:** Se você configurar uma VPN ([**como WireGuard**](https://soarespaullo.github.io/mikrotik/docs/seguranca/vpn-wireguard/){: target="_blank" }), usará o **DNS Name** do Cloud para conectar os dispositivos, garantindo que a VPN não caia quando o IP da operadora mudar.

*   **Gratuito:** É um serviço oficial da MikroTik, sem mensalidade e sem necessidade de criar contas em sites externos (como No-IP/DuckDNS).

{: .note }
> **Verificação de Conectividade:** `Observe as mensagens no rodapé da janela`:
>
> Se mostrar `updated`, significa que o nome já está funcionando. Se mostrar `Router is behind NAT`, significa que seu MikroTik está recebendo um IP privado da operadora (**CGNAT**), e o acesso remoto direto pode não funcionar sem uma **VPN**.