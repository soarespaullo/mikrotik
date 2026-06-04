---
layout: default
title: "📈 Bandwidth Test"
parent: "🛠️ Manutenção"
nav_order: 3
---

# 📈 Guia: Bandwidth Test (BTest)
{: .no_toc }

O **Bandwidth Test** é a ferramenta definitiva para medir o rendimento (throughput) entre dois dispositivos MikroTik. Diferente de um teste de velocidade comum, o BTest permite testar protocolos específicos (TCP/UDP) e direções de tráfego (Send/Receive).

---

## 🚀 Como Funciona
Para realizar um teste, você precisa de dois roteadores MikroTik:
1.  **O Servidor:** O roteador que receberá a conexão.
2.  **O Cliente:** O roteador que iniciará o teste de carga.

---

## 🛠️ Configuração Passo a Passo

### 1. Habilitar o Servidor
No roteador que servirá de destino, acesse: **Tools > BTest Server**.
* Marque a opção `Enabled`.
* *(Opcional)* Defina uma senha em `Authenticate` para evitar que estranhos usem seu processamento para testes.

### 2. Executar o Teste (Cliente)
No roteador de origem, vá em: **Tools > Bandwidth Test**.
* **Test To:** Digite o IP do roteador servidor.
* **Protocol:** * `UDP`: Mais leve, ideal para testar a capacidade máxima do meio físico.
    * `TCP`: Mais pesado, exige mais CPU, mas reflete o comportamento real da navegação web.
* **Direction:** Escolha entre `receive` (download), `send` (upload) ou `both` (ambos).

---

## ⚠️ Avisos Importantes: Cuidado com a CPU!

{: .warning}
> O Bandwidth Test consome muito processamento (**CPU**). Se você rodar um teste em um roteador pequeno (como uma hAP lite), a CPU chegará em **100%** e a rede pode travar durante o teste.

**Dicas para testes precisos:**
* Sempre monitore o **System > Resources > CPU** durante o teste.
* Se a CPU atingir 100%, o resultado do teste de banda não é real; ele parou no limite do processador, não do link.
* Dê preferência ao protocolo **UDP** para testar limites de rádio ou cabo.

---

## 💻 Comandos via Terminal

Se você prefere o terminal, pode rodar um teste rápido assim:

```
/tool bandwidth-test address=192.168.88.1 protocol=udp direction=receive
```

## 🔍 Quando usar o Bandwidth Test?

- **Testar Cabos:** Verificar se um cabo está passando 100Mbps ou 1Gbps.

- **Alinhamento de Antenas:** Verificar o tráfego real em enlaces sem fio (PTP).

- **Validar VPNs:** Testar quanto de banda passa por dentro de um túnel (L2TP, WireGuard, etc).