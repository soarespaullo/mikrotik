---
layout: default
title: 🏠 Home
nav_order: 1
has_children: false
---

# 🚀 Wiki Técnica MikroTik
{: .no_toc }

Documentação centralizada para administração, segurança e automação de redes baseadas em **RouterOS v7**. Este repositório compila procedimentos técnicos validados e scripts de automação para a nossa infraestrutura.

---

## 🛠️ Escopo Técnico
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## 🔒 Segurança & Acesso
Políticas de proteção de borda, controle de acesso granular e túneis seguros.

* **Firewall & Proteção:** Estratégia de bloqueio por padrão, regras de Input/Forward e proteção contra Brute Force.
* **Redirecionamentos:** Implementação de Port Forwarding (DST-NAT) e Hairpin NAT para acesso interno.
* **Acesso Seguro:** Configuração de Port Knocking, VPN WireGuard de alta performance e ocultação de vizinhos (MNDP).
* **Gerenciamento:** DDNS via IP Cloud, DuckDNS, No-IP e políticas rígidas de usuários e privilégios.

## 🛠️ Manutenção do Sistema
Rotinas de integridade, diagnósticos e automação para garantir alta disponibilidade.

* **Cópias de Segurança:** Scripts automatizados para geração de `.backup` (binário) e `.rsc` (texto plano).
* **Diagnóstico & Monitoramento:** Testes de estresse com Bandwidth Test, gráficos de consumo web (Graphing) e análise detalhada de logs.
* **Gerenciamento Físico:** Sincronização de hora via SNTP (NTP.br), mapeamento de rede L2 via RoMON e expansão de armazenamento via SMB.
* **Resiliência:** Atualizações de RouterOS/Firmware e reinicialização automática contra travamentos via Watchdog.

---

## 🔗 Links Úteis

Para facilitar o dia a dia na operação da rede, utilize os canais oficiais da MikroTik:

* [🌐 **MikroTik Download**](https://mikrotik.com/download){: .btn .btn-outline } — *Winbox, Netinstall e pacotes do RouterOS.*
* [📚 **Documentação Oficial**](https://help.mikrotik.com/docs/){: .btn .btn-outline } — *Manuais técnicos e referências de comandos da Wiki.*
* [💬 **Fórum MikroTik**](https://forum.mikrotik.com/){: .btn .btn-outline } — *Discussões da comunidade mundial e soluções de problemas.*

---

## 📝 Referências do Projeto
> **Target OS:** RouterOS v7.x (Stable)  
> **Arquitetura:** Ambientes de Produção, Provedores e Redes Corporativas.  
> **Objetivo:** Prover guias rápidos e scripts de fácil implementação "copia e cola".

---

{: .note }
> Esta Wiki é mantida pela **Equipe de Rede** sob coordenação de **Paulo Soares**. O código-fonte e as atualizações podem ser acompanhados diretamente no [GitHub](https://github.com/soarespaullo).