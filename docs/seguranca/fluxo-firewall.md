---
layout: default
title: "🗺️ Tabela de Fluxo do Firewall"
parent: "🔒 Segurança & Acesso"
nav_order: 5
last_modified_date: 2026-06-21 01:50
---

# 🗺️ Linha de Processamento do Firewall (Input & Forward)
{: .no_toc }

Este guia apresenta a sequência lógica e cronológica que um pacote percorre ao passar pelas regras de filtro do seu roteador MikroTik.

---

### 📊 Tabela de Fluxo de Processamento (Passo a Passo)

O MikroTik analisa cada pacote que entra seguindo a ordem estrita da tabela abaixo. Assim que um pacote atinge um critério de **Drop** ou **Accept**, ele interrompe a leitura das regras seguintes.

| Ordem | Regra / Verificação | Se for Verdade (Match) | Se não for (Próximo Passo) |
| :---: | :--- | :--- | :--- |
| **1** | O pacote é inválido ou defeituoso? | **DROP** (Descarta na hora) | Passa para o passo 2 |
| **2** | É uma conexão que o roteador já aceitou antes? | **ACCEPT** (Mantém conectado) | Passa para o passo 3 |
| **3** | O IP de origem está na `rede-suporte`? | **ACCEPT** (Acesso liberado) | Passa para o passo 4 |
| **4** | É a 1ª batida do Port Knocking (Porta 7788)? | **ADD LIST** (Salva no Pré-Suporte) | Passa para o passo 5 |
| **5** | É a 2ª batida do Port Knocking (Porta 4455)? | **ADD LIST** (Abre o acesso na Rede-Suporte) | Passa para o passo 6 |
| **6** | É tráfego da VPN WireGuard (Porta 13231)? | **ACCEPT** (Permite conexão da VPN) | Passa para o passo 7 |
| **7** | O IP está na lista de `port-scanner` (Input)? | **DROP** (Bloqueia acesso ao roteador) | Passa para o passo 8 |
| **8** | O IP está na lista de `port-scanner` (Forward)? | **DROP** (Bloqueia acesso à rede local) | Passa para o passo 9 |
| **9** | O comportamento bate com Port Scanner (PSD)? | **ADD LIST** (Gera bloqueio de 14 dias) | Passa para o passo 10 |
| **10** | O comportamento bate com Fast SYN Scan? | **ADD LIST** (Gera bloqueio de 14 dias) | Passa para o passo 11 |
| **11** | É uma tentativa de Força Bruta (Winbox/SSH)? | **DROP** (Corta o ataque de dicionário) | Passa para o passo 12 |
| **12** | É um pacote de Ping (ICMP)? | **ACCEPT** (Responde se estiver dentro do limite) | Passa para o passo 13 |
| **13** | **CADEADO FINAL (DROP GERAL)** | **DROP** (Bloqueia tudo o que restou) | *Fim do fluxo* |

[⬅️ Voltar para o Guia de Firewall Intermediário]({{ '/docs/seguranca/firewall-intermediario/' | relative_url }}){: .btn .btn-outline }