---
layout: default
title: 🏠 Home
nav_order: 1
has_children: false
last_modified_date: 2026-06-08 21:15
---

# 🚀 Wiki Técnica MikroTik
{: .no_toc }

Documentação centralizada para administração, segurança e automação de redes baseadas em **RouterOS v7**. Este repositório compila procedimentos técnicos validados e scripts de automação para a nossa infraestrutura.

---

## ⚡ Atalhos de Produção
{: .no_toc }

<div class="row" style="display: flex; gap: 15px; flex-wrap: wrap; margin-top: 20px; margin-bottom: 20px;">
  <div class="col" style="flex: 1; min-width: 220px; padding: 15px; border: 1px solid #e1f5fe; border-radius: 6px; background: #fafafa; box-shadow: 0 2px 4px rgba(0,0,0,0.02);">
    <h4 style="margin-top: 0;">🚀 Primeiros Passos</h4>
    <p style="font-size: 13px; color: #666; min-height: 40px;">Roteador fora da caixa? Siga o fluxo correto de provisionamento.</p>
    <a href="{{ '/docs/primeiro-passos/configuracao-inicial/' | relative_url }}" class="btn btn-blue" style="font-size: 12px; padding: 4px 10px;">Acessar Guia</a>
  </div>
  <div class="col" style="flex: 1; min-width: 220px; padding: 15px; border: 1px solid #ffebee; border-radius: 6px; background: #fafafa; box-shadow: 0 2px 4px rgba(0,0,0,0.02);">
    <h4 style="margin-top: 0;">🔒 Hardening & Segurança</h4>
    <p style="font-size: 13px; color: #666; min-height: 40px;">Políticas de Firewall, bloqueios estruturados e proteção L7.</p>
    <a href="{{ '/docs/seguranca/' | relative_url }}" class="btn btn-red" style="font-size: 12px; padding: 4px 10px;">Ver Regras</a>
  </div>
  <div class="col" style="flex: 1; min-width: 220px; padding: 15px; border: 1px solid #e8f5e9; border-radius: 6px; background: #fafafa; box-shadow: 0 2px 4px rgba(0,0,0,0.02);">
    <h4 style="margin-top: 0;">🤖 Automação & Scripts</h4>
    <p style="font-size: 13px; color: #666; min-height: 40px;">Automação de backups por e-mail e alertas integrados ao Telegram.</p>
    <a href="{{ '/docs/automacao/' | relative_url }}" class="btn btn-green" style="font-size: 12px; padding: 4px 10px;">Pegar Scripts</a>
  </div>
</div>

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

## 🔄 Últimas Alterações na Wiki
{: .no_toc }

Aqui estão as páginas atualizadas recentemente na nossa infraestrutura:

{% assign paginas_recentes = site.html_pages | where_exp:"item", "item.last_modified_date != nil" | sort: "last_modified_date" | reverse %}
{% for pagina in paginas_recentes limit:3 %}
* **{{ pagina.last_modified_date | date: "%d/%m/%Y" }}** — [{{ pagina.title }}]({{ pagina.url | relative_url }})
{% endfor %}

---
## 🔗 Links Úteis

Para facilitar o dia a dia na operação da rede, utilize os canais oficiais da MikroTik:

* [🌐 **MikroTik Download**](https://mikrotik.com/download){: .btn .btn-outline target="_blank" } — *Winbox, Netinstall e pacotes do RouterOS.*
* [📚 **Documentação Oficial**](https://help.mikrotik.com/docs/){: .btn .btn-outline target="_blank" } — *Manuais técnicos e referências de comandos da Wiki.*
* [💬 **Fórum MikroTik**](https://forum.mikrotik.com/){: .btn .btn-outline target="_blank" } — *Discussões da comunidade mundial e soluções de problemas.*

---

## 📝 Referências do Projeto
> **Target OS:** RouterOS v7.x (Stable)  
> **Arquitetura:** Ambientes de Produção, Provedores e Redes Corporativas.  
> **Objetivo:** Prover guias rápidos e scripts de fácil implementação "copia e cola".

---

{: .note }
> Esta Wiki é mantida pela **Equipe de Rede** sob coordenação de [**Paulo Soares**](https://soarespaullo.github.io){: target="_blank" }. O código-fonte e as atualizações podem ser acompanhados diretamente no [**GitHub**](https://github.com/soarespaullo/MikroTik/){: target="_blank" }.
