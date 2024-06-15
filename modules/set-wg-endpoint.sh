#!/bin/bash

# Überprüfung, ob genügend Argumente übergeben wurden
if [[ $# -lt 2 ]]; then
    echo "Verwendung: $0 <Peer Public Key> <MAC1> [MAC2] [MAC3] [...]"
    exit 1
fi

# Öffentlicher Schlüssel des Peers als erstes Argument
PEER_PUBLIC_KEY="$1"
shift  # Verschieben der Argumente, entfernt das erste Argument

# Restliche Argumente sind MAC-Adressen
ziel_macs=("$@")

# Array für gefundene Ergebnisse
declare -a gefundene_ergebnisse

# Funktion, um das erste passende Netzwerkinterface zu finden
finde_interface() {
    # Zuerst nach LAN-Interfaces suchen, die mit 'eth' oder 'en' beginnen
    for iface in $(ip link show | grep -oP '(?<=: )(eth|en)\w+'); do
        if [[ -n "$iface" ]]; then
            echo "$iface"
            return
        fi
    done

    # Falls kein LAN-Interface gefunden wurde, nach WLAN-Interfaces suchen, die mit 'wl' beginnen
    for iface in $(ip link show | grep -oP '(?<=: )wl\w+'); do
        if [[ -n "$iface" ]]; then
            echo "$iface"
            return
        fi
    done
}

# Interface ermitteln
selected_interface=$(finde_interface)

# Überprüfen, ob ein Interface gefunden wurde
if [[ -z "$selected_interface" ]]; then
    echo "Kein passendes Interface gefunden."
    exit 1
fi
echo "Verwendetes Interface: $selected_interface"

# ARP-Scan durchführen und Ergebnisse speichern
arp_scan_results=$(sudo arp-scan --interface=$selected_interface --localnet)

# Ergebnisse auf mehrere MAC-Adressen prüfen
for mac in "${ziel_macs[@]}"; do
    echo "Suche nach MAC: $mac"
    if echo "$arp_scan_results" | grep -q $mac; then
        gefundene_ip=$(echo "$arp_scan_results" | grep $mac | awk '{print $1}')
        echo "MAC gefunden: $mac, IP: $gefundene_ip"
        # Speichere das Ergebnis im Array
        gefundene_ergebnisse+=("MAC: $mac, IP: $gefundene_ip")
        
        # WireGuard-Konfiguration für diesen Peer
        sudo wg set wgssh peer $PEER_PUBLIC_KEY endpoint $gefundene_ip:51821
        echo "WireGuard-Konfiguration für Peer mit IP $gefundene_ip aktualisiert."
    else
        echo "MAC nicht gefunden: $mac"
    fi
done

# Ausgabe der gespeicherten Ergebnisse
echo "Gefundene Ergebnisse:"
for ergebnis in "${gefundene_ergebnisse[@]}"; do
    echo "$ergebnis"
done
