#!/bin/bash
INTERFACE="wlo1"
RX1=$(cat /sys/class/net/$INTERFACE/statistics/rx_bytes)
TX1=$(cat /sys/class/net/$INTERFACE/statistics/tx_bytes)
sleep 1
RX2=$(cat /sys/class/net/$INTERFACE/statistics/rx_bytes)
TX2=$(cat /sys/class/net/$INTERFACE/statistics/tx_bytes)

RXBPS=$((RX2 - RX1))
TXBPS=$((TX2 - TX1))

# Convert bytes per second to MB/s (floating point)
RXMB=$(awk "BEGIN {printf \"%.2f\", $RXBPS / 1024 / 1024}")
TXMB=$(awk "BEGIN {printf \"%.2f\", $TXBPS / 1024 / 1024}")

echo " ${RXMB} MB/s"