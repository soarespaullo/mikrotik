---
layout: default
title: "🗺️ Mapa de Fluxo do Firewall"
parent: "🔒 Segurança & Acesso"
nav_order: 5
last_modified_date: 2026-06-21 01:30
---

# 🗺️ Mapa de Fluxo do Firewall (Input & Forward)
{: .no_toc }

Este diagrama visual apresenta o ciclo de vida e a ordem de processamento sequencial de um pacote de rede ao passar pelas regras de filtro (Filter Rules) básicas e intermediárias do seu MikroTik.

---

### 📊 Diagrama de Fluxo (Ordem de Processamento Sequencial)

{: .note }
> O MikroTik processa as regras de cima para baixo. Assim que um pacote atinge um critério de **Drop** ou **Accept**, ele interrompe a leitura das regras seguintes.

```mermaid
graph TD
    %% Linha Principal de Decisao (O Pacote descendo o Firewall)
    Inicio[Novo Pacote Chega ao Roteador] --> R1{1. E conexao invalida?}
    
    R1 -->|Nao| R2{2. E estabelecida ou relacionada?}
    R1 -->|Sim| DROP1[DROP: Conexoes Invalidas]
    
    R2 -->|Nao| R3{3. IP esta na Rede Suporte?}
    R2 -->|Sim| ACC1[ACCEPT: Mantem Conexao]
    
    R3 -->|Nao| R4{4. E a primeira batida Port Knock?}
    R3 -->|Sim| ACC2[ACCEPT: Libera Acesso Total]
    
    R4 -->|Nao| R5{5. E a segunda batida Port Knock?}
    R4 -->|Sim| ADD1[ADD LIST: Pre-Rede-Suporte]
    
    R5 -->|Nao| R6{6. E trafego da VPN WireGuard?}
    R5 -->|Sim| ADD2[ADD LIST: Rede-Suporte]
    
    R6 -->|Nao| R7{7. Origem na lista port-scanner?}
    R6 -->|Sim| ACC3[ACCEPT: Conecta VPN]
    
    R7 -->|Nao| R8{8. Origem na lista port-scanner?}
    R7 -->|Sim| DROP2[DROP: IP Bloqueado no Input]
    
    R8 -->|Nao| R9{9. Bate com o comportamento PSD?}
    R8 -->|Sim| DROP3[DROP: IP Bloqueado no Forward]
    
    R9 -->|Nao| R10{10. Bate com comportamento SYN Scan?}
    R9 -->|Sim| BAN1[ADD LIST: port-scanner 2w]
    
    R10 -->|Nao| R11{11. E ataque de Forca Bruta?}
    R10 -->|Sim| BAN2[ADD LIST: port-scanner 2w]
    
    R11 -->|Nao| R12{12. E pacote ICMP ou Ping?}
    R11 -->|Sim| DROP4[DROP: Ataque Mitigado]
    
    R12 -->|Nao| R13[13. DROP GERAL - CADEADO FINAL]
    R12 -->|Sim| ACC4[ACCEPT: Ping Permitido]
```

[⬅️ Voltar para o Guia de Firewall Intermediário]({{ '/docs/seguranca/firewall-intermediario/' | relative_url }}){: .btn .btn-outline }