---
layout: default
title: 🌈 VLAN
parent: 📡 Redes & Links
nav_order: 6
last_modified_date: 2026-06-12 23:00
---

# 🌈 Guia: Configuração de VLAN
{: .no_toc }

Uma **VLAN** permite dividir seu roteador físico em múltiplas redes lógicas independentes. Isso aumenta a segurança e reduz o tráfego desnecessário na rede (broadcast).

---

## 🪜 1. Criando a Interface VLAN

O primeiro passo é dizer ao MikroTik em qual porta física a VLAN vai "**viajar**".

1. Vá em **Interfaces** ➔ **VLAN**.
2. Clique no botão **+**.
3. Preencha os campos:
    * **Name:** Nome para identificar a rede (ex: `vlan10-visitantes`).
    * **VLAN ID:** O número de identificação da rede (ex: `10`).
    * **Interface:** A porta física onde o cabo está conectado (ex: `ether2`).
4. Clique em **OK**.

---

## 🌐 2. Configurando a Rede da VLAN

Agora que a interface existe, precisamos dar a ela um endereço e um servidor DHCP para que os dispositivos recebam IP.

### A. Definir IP
1. Vá em **IP** ➔ **Addresses**.
2. Clique no botão **+**.
3. **Address:** Digite o IP da rede (ex: `192.168.10.1/24`).
4. **Interface:** Selecione a VLAN que você criou no Passo 1 (`vlan10-visitantes`).

### B. Criar o DHCP Server
1. Vá em **IP** ➔ **DHCP Server**.
2. Clique no botão **DHCP Setup**.
3. Selecione a interface da **VLAN**.
4. Siga clicando em **Next** até o final. O MikroTik criará o Pool de IPs e o servidor automaticamente.

---

## 🛡️ 3. Isolando as Redes (Segurança)

Por padrão, o MikroTik roteia o tráfego entre VLANs. Se você quer que a rede de Visitantes não acesse sua rede Principal, use o Firewall:

1. Vá em **IP** ➔ **Firewall** ➔ **Filter Rules**.
2. Clique no botão **+**.
3. **Chain:** `forward`.
4. **In. Interface:** `vlan10-visitantes`.
5. **Out. Interface:** `sua-interface-lan-principal`.
6. Na aba **Action**, selecione **drop**.

---

## ❓ Quando usar VLANs?

*   **Segurança:** Isolar câmeras e dispositivos IoT da sua rede de computadores principal.
*   **Visitantes:** Criar um Wi-Fi separado que só tem acesso à internet, sem ver seus arquivos.
*   **Organização:** Separar departamentos (Financeiro, Vendas, TI) em empresas.

---

{: .tip }
> Se você for passar várias VLANs para um Switch ou AP através de um único cabo, lembre-se de configurar esse cabo como **Trunk** no dispositivo de destino, usando o mesmo **VLAN ID**.
