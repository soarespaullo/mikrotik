---
layout: default
title: "🔄 Hairpin NAT (Acesso Interno)"
parent: "🔒 Segurança & Acesso"
nav_order: 8
last_modified_date: 2026-06-08 21:15
---

# 📖 Guia: Hairpin NAT (Acesso Interno via DDNS/IP Público)
{: .no_toc }

#### O Problema
{: .label .label-yellow }

Quando você tenta acessar o seu **IP Externo** (ou **DDNS**) estando dentro da rede local, o pacote chega ao roteador, mas "**se perde**" na hora de voltar para o seu computador, fazendo a conexão falhar. O `Hairpin NAT` corrige esse redirecionamento interno.

---

## 🛠️ Configuração Passo a Passo

1.  Acesse **IP ➔ Firewall** e vá na aba **NAT**.

2.  Clique no botão **+** e preencha na aba **General**:

    *   **Comment:** `HAIRPIN NAT - LOOPBACK DE DNS PARA REDE LOCAL`

    *   **Chain:** `srcnat`

    *   **Src. Address:** `10.220.0.0/24` (Sua faixa de rede local).

    *   **Dst. Address:** `10.220.0.100` (IP do servidor de destino).

    *   **Protocol:** `6 (tcp)`

    *   **Dst. Port:** *(Veja as opções abaixo)*

🎯 Opção A: Para uma porta específica

Se quiser aplicar a regra apenas a um serviço (ex: HTTPS):

*   **Dst. Port:** `443`

*   **Comment:** `HAIRPIN NAT - LOOPBACK DE DNS PARA REDE LOCAL`

🎯 Opção B: Para múltiplas portas (Recomendado)

Se você tem várias portas (`80, 443, 2222`) para o mesmo servidor:

*   **Dst. Port:** (Deixe em branco)

*   **Comment:** `HAIRPIN NAT - LOOPBACK DE DNS PARA REDE LOCAL`

{: .note }
> Ao deixar em branco, a regra funcionará automaticamente para qualquer porta redirecionada para esse IP.

1.  Na aba **Action**:

    *   **Action:** `masquerade`

2.  Clique em **OK**.

---

{: .tip }
> A **Opção B** é a mais eficiente para o dia a dia. Se amanhã você abrir uma nova porta para este servidor no **DST-NAT**, não precisará criar uma nova regra de Hairpin; ela já sairá funcionando automaticamente.