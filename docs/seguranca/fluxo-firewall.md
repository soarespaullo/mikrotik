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
    Pacote[📦 Novo Pacote Chega ao Firewall] --> R1{1. É uma conexão inválida?<br>connection-state=invalid}
    
    R1 -->|Sim| DROP1[🛑 DROP: Conexões Inválidas]
    R1 -->|Não| R2{2. É estabelecida ou relacionada?<br>established, related}
    
    R2 -->|Sim| ACC1[✅ ACCEPT: Mantém Conexão]
    R2 -->|Não| R3{3. IP está na Rede Suporte?<br>src-address-list=rede-suporte}
    
    R3 -->|Sim| ACC2[✅ ACCEPT: Libera Acesso Total]
    R3 -->|Não| PK1{4. É a 1ª batida do Port Knocking?<br>dst-port=7788}
    
    PK1 -->|Sim| ADD1[📌 ADD LIST: Pre-Rede-Suporte]
    PK1 -->|Não| PK2{5. É a 2ª batida do Port Knocking?<br>dst-port=4455}
    
    PK2 -->|Sim| ADD2[📌 ADD LIST: Rede-Suporte]
    PK2 -->|Não| VPN{6. É tráfego da VPN?<br>dst-port=13231 udp}
    
    VPN -->|Sim| ACC3[✅ ACCEPT: Conecta WireGuard]
    VPN -->|Não| SC1{7. O IP de origem está na lista port-scanner?<br>Chain: Input}
    
    SC1 -->|Sim| DROP2[🛑 DROP: IP Bloqueado na Entrada]
    SC1 -->|Não| SC2{8. O IP de origem está na lista port-scanner?<br>Chain: Forward}
    
    SC2 -->|Sim| DROP3[🛑 DROP: IP Bloqueado para Rede Local]
    SC2 -->|Não| DET1{9. Comportamento bate com PSD?<br>psd=21,3s,3,1}
    
    DET1 -->|Sim| BAN1[🪤 ADD LIST: port-scanner por 2 semanas]
    DET1 -->|Não| DET2{10. Comportamento bate com SYN Scan?<br>tcp-flags=syn & limit=30}
    
    DET2 -->|Sim| BAN2[🪤 ADD LIST: port-scanner por 2 semanas]
    DET2 -->|Não| BF1{11. Tentativa de Força Bruta?<br>Portas 22,5050,8291 & limit=3}
    
    BF1 -->|Sim| DROP4[🛑 DROP: Ataque Mitigado]
    BF1 -->|Não| ICMP{12. É pacote ICMP/Ping?<br>protocol=icmp & limit=10/s}
    
    ICMP -->|Sim| ACC4[✅ ACCEPT: Ping Permitido]
    ICMP -->|Não| D_GERAL{13. Passou por tudo e sobrou?<br>DROP GERAL}
    
    D_GERAL --> DROP_G[🛑 DROP FINAL: Bloqueia o Resto]

    %% Estilização de nós para melhor visualização
    style Pacote fill:#e1f5fe,stroke:#03a9f4,stroke-width:2px
    style DROP1 fill:#ffebee,stroke:#f44336,stroke-width:2px
    style DROP2 fill:#ffebee,stroke:#f44336,stroke-width:2px
    style DROP3 fill:#ffebee,stroke:#f44336,stroke-width:2px
    style DROP4 fill:#ffebee,stroke:#f44336,stroke-width:2px
    style DROP_G fill:#ffebee,stroke:#f44336,stroke-width:3px
    style ACC1 fill:#e8f5e9,stroke:#4caf50,stroke-width:2px
    style ACC2 fill:#e8f5e9,stroke:#4caf50,stroke-width:2px
    style ACC3 fill:#e8f5e9,stroke:#4caf50,stroke-width:2px
    style ACC4 fill:#e8f5e9,stroke:#4caf50,stroke-width:2px
    style ADD1 fill:#fff8e1,stroke:#ffb300,stroke-width:2px
    style ADD2 fill:#fff8e1,stroke:#ffb300,stroke-width:2px
    style BAN1 fill:#fff3e0,stroke:#ff9800,stroke-width:2px
    style BAN2 fill:#fff3e0,stroke:#ff9800,stroke-width:2px

    [⬅️ Voltar para o Guia de Firewall Intermediário]({{ '/docs/seguranca/firewall-intermediario/' | relative_url }}){: .btn .btn-outline }