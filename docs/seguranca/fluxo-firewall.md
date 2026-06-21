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
    Pacote[Novo Pacote Chega ao Firewall] --> STEP1{1. E conexao invalida?}
    
    STEP1 -->|Sim| DROP1[DROP: Conexoes Invalidas]
    STEP1 -->|Nao| STEP2{2. E estabelecida ou relacionada?}
    
    STEP2 -->|Sim| ACC1[ACCEPT: Mantem Conexao]
    STEP2 -->|Nao| STEP3{3. IP esta na Rede Suporte?}
    
    STEP3 -->|Sim| ACC2[ACCEPT: Libera Acesso Total]
    STEP3 -->|Nao| STEP4{4. E a primeira batida do Port Knocking?}
    
    STEP4 -->|Sim| ADD1[ADD LIST: Pre-Rede-Suporte]
    STEP4 -->|Nao| STEP5{5. E a segunda batida do Port Knocking?}
    
    STEP5 -->|Sim| ADD2[ADD LIST: Rede-Suporte]
    STEP5 -->|Nao| STEP6{6. E trafego da VPN WireGuard?}
    
    STEP6 -->|Sim| ACC3[ACCEPT: Conecta VPN]
    STEP6 -->|Nao| STEP7{7. Origem esta na lista port-scanner no Input?}
    
    STEP7 -->|Sim| DROP2[DROP: IP Bloqueado no Input]
    STEP7 -->|Nao| STEP8{8. Origem esta na lista port-scanner no Forward?}
    
    STEP8 -->|Sim| DROP3[DROP: IP Bloqueado no Forward]
    STEP8 -->|Nao| STEP9{9. Bate com o comportamento PSD?}
    
    STEP9 -->|Sim| BAN1[ADD LIST: port-scanner 2w]
    STEP9 -->|Nao| STEP10{10. Bate com o comportamento SYN Scan?}
    
    STEP10 -->|Sim| BAN2[ADD LIST: port-scanner 2w]
    STEP10 -->|Nao| STEP11{11. E ataque de Forca Bruta?}
    
    STEP11 -->|Sim| DROP4[DROP: Ataque Mitigado]
    STEP11 -->|Nao| STEP12{12. E pacote ICMP ou Ping?}
    
    STEP12 -->|Sim| ACC4[ACCEPT: Ping Permitido]
    STEP12 -->|Nao| STEP13[13. DROP GERAL - CADEADO FINAL]
```

[⬅️ Voltar para o Guia de Firewall Intermediário]({{ '/docs/seguranca/firewall-intermediario/' | relative_url }}){: .btn .btn-outline }