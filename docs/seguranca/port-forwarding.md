---
layout: default
title: "🚪 Port Forwarding (Redirecionamento)"
parent: "🔒 Segurança & Acesso"
nav_order: 5
last_modified_date: 2026-06-09 17:40
---

# 📖 Guia: Port Forwarding (Redirecionamento de Portas)
{: .no_toc }

O redirecionamento de portas permite que um serviço hospedado na sua rede interna (como um `servidor web`, `câmera` ou `sistema`) seja acessado externamente através do `IP` da sua `WAN`.

---

## 🛠️ Configuração Passo a Passo

Neste exemplo, vamos redirecionar o tráfego HTTPS (porta **443**) para o servidor interno com o IP **10.220.0.100**.

1.  No Winbox, acesse o menu **IP ➔ Firewall**.

2.  Vá até a aba **NAT** e clique no botão **+**.

3.  Na aba **General**, preencha os campos abaixo:

    *   **Comment:**  `Acesso Externo - Servidor Web`.

    *   **Chain:** `dstnat`.

    *   **Protocol:** `6 (tcp)`.

    *   **Dst. Port:** `443`.

{: .important }
> **Ajuste para Acesso Interno (Aba Extra):** 
>
> Se você pretende acessar este servidor usando o **DDNS/IP Público** mesmo estando dentro da rede local, vá na aba **Extra** e defina **Dst. Address Type: local**. Isso é essencial para que o [**Hairpin NAT**](https://soarespaullo.github.io/mikrotik/docs/seguranca/hairpin-nat/){: target="_blank" } funcione corretamente sem precisar travar a regra em uma interface (`WAN`).

4.  Mude para a aba **Action** e configure o destino:

    *   **Action:** `dst-nat`.

    *   **To Addresses:** `10.220.0.100`.

6.  Clique em **Apply** e **OK**.

---

## 🛡️ Boas Práticas de Segurança

Ao abrir a porta `443 (HTTPS)`, seu dispositivo ficará exposto à internet. Considere estas proteções:

*   **Restrição por IP de Origem:** Se apenas uma empresa ou pessoa específica precisa acessar, vá na aba **General** e em **Src. Address** coloque o IP fixo de quem vai acessar.


{: .note }
> **Sobre o Src. Address:** O IP a ser inserido neste campo deve ser o **IP Público (Internet)** da pessoa/empresa que realizará o acesso. IPs privados/locais (ex: 192.168.x.x) não funcionam aqui, pois não trafegam pela internet. Caso o visitante não possua um IP fixo, deixe o campo em branco.

*   **Porta Externa Diferente:** Você pode usar uma porta externa "disfarçada" (ex: `8443`) que redireciona para a `443` interna. Para isso, mude o **Dst. Port** para `8443` e mantenha o **To Ports** como `443`.

{: .tip }
> **Acesso via Porta Personalizada:** Ao usar uma porta externa "disfarçada" (ex: **8443**), você deve obrigatoriamente especificá-la ao digitar o endereço no navegador ou aplicativo.

*   **Exemplo:** `https://soarespaullo.ddns.net:8443`

O MikroTik receberá a conexão na **8443** e fará a entrega silenciosa para a porta **443** interna do seu servidor. Se você não digitar `:8443`, o navegador tentará a porta padrão (443) e a conexão falhará.

---

## 🔍 Como testar?

1.  Certifique-se de que o serviço no IP `10.220.0.100` está ativo e aceitando conexões na porta `443`.

{: .tip } 
> **Teste de Porta Aberta:** 
>
> Acesse o site [**YouGetSignal (Port Forwarding Tester**)](https://www.yougetsignal.com/tools/open-ports/){: target="_blank" } e:

*   Verifique se o **Remote Address** é o seu IP público atual.

*   No campo **Port Number**, digite `443`.

*   Clique em **Check**.

Se o resultado for uma **bandeira verde (Port 443 is open)**, seu redirecionamento está funcionando perfeitamente!

2.  Tente acessar pelo seu IP Público (encontrado em [**IP Cloud**](https://soarespaullo.github.io/mikrotik/docs/seguranca/ip-cloud/){: target="_blank" } usando um dispositivo **fora** da sua rede (como o 4G/5G do celular).

{: .important }
> Se você tentar acessar pelo IP externo estando conectado na rede local (`Wi-Fi/Cabo da mesma rede`), o acesso pode falhar devido à falta de uma regra de [**Hairpin NAT**](https://soarespaullo.github.io/mikrotik/docs/seguranca/hairpin-nat/){: target="_blank" }. Teste sempre por uma conexão externa.