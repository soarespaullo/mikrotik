---
layout: default
title: 🗺️ Mapa de Fluxo
nav_order: 3
parent: 🚀 Primeiros Passos
---

# 🗺️ Mapa de Fluxo da Configuração Inicial
{: .no_toc }

Este diagrama visual apresenta a sequência lógica e cronológica dos passos necessários para realizar a configuração do seu roteador MikroTik do zero.

---

### 📊 Diagrama de Fluxo (Ordem de Execução)

{: .note }
> Caso o diagrama não carregue imediatamente, certifique-se de atualizar a página com `Ctrl + F5`.

```mermaid
graph TD
    Start[MikroTik Fora da Caixa] --> STEP1[1. Limpeza de Fabrica e Reset]
    STEP1 --> STEP2[2. Identidade e Nome das Interfaces]
    
    STEP2 --> LAN[Configurar rede LAN]
    STEP2 --> WAN[Configurar internet WAN]

    LAN --> STEP3[Definir IP na ether5]
    STEP3 --> STEP4[Criar Bridge REDE-SWITCH]
    STEP4 --> STEP5[Migrar IP e DHCP para a Bridge]
    STEP5 --> STEP6[Configurar o DHCP Server]

    WAN --> STEP7{Qual o tipo de Link?}
    STEP7 -->|Usuario e Senha| STEP7A[Opcao A. PPPoE Client]
    STEP7 -->|IP Automatico| STEP7B[Opcao B. DHCP Client]

    STEP6 --> FIREWALL[5. Configurar DNS e NAT Masquerade]
    STEP7A --> FIREWALL
    STEP7B --> FIREWALL
    
    FIREWALL --> STEP8[7. Atualizacao do RouterOS]
    STEP8 --> STEP9[8. Criar Novo Usuario e Apagar Admin]
    STEP9 --> STEP10[9. Desativar Portas e Servicos Inuteis]
    STEP10 --> STEP11[10. Ajustar Horario com NTP.br]
    STEP11 --> STEP12[11. Gerar Backup .backup e .rsc]
    
    STEP12 --> End[Roteador Pronto e Seguro]
```

[⬅️ Voltar para o Guia de Configuração Inicial]({{ '/docs/primeiro-passos/configuracao-inicial/' | relative_url }}){: .btn .btn-outline }