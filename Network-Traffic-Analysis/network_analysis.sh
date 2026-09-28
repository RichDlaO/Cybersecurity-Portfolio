#!/usr/bin/env bash
#
# ==============================================================================
# Script Name   : network_analysis.sh
# Description   : Automated Network Reconnaissance, Packet Capture & Analysis
# Target OS     : Linux (Debian/Ubuntu/RHEL)
# Dependencies  : tcpdump, curl
# Usage         : sudo ./network_analysis.sh
# ==============================================================================

# Exit immediately if a command exits with a non-zero status
set -e

# Configuration Variables
INTERFACE="eth0"
OUTPUT_FILE="capture.pcap"
TARGET_PORT="80"
TEST_URL="opensource.google.com"

echo "[*] Starting Network Traffic Analysis Pipeline..."
echo "----------------------------------------------------------------------"

# Task 1: Network Interface Audit
echo "[+] Step 1: Auditing available network interfaces..."
sudo tcpdump -D
echo "----------------------------------------------------------------------"

# Task 2: Live Packet Inspection
echo "[+] Step 2: Performing live packet capture on interface '${INTERFACE}'..."
sudo tcpdump -i "${INTERFACE}" -v -c5
echo "----------------------------------------------------------------------"

# Task 3: Background Filtered Capture & Traffic Generation
echo "[+] Step 3: Initializing background capture on Port ${TARGET_PORT}..."
sudo tcpdump -i "${INTERFACE}" -nn -c9 port "${TARGET_PORT}" -w "${OUTPUT_FILE}" &

# Short delay to guarantee tcpdump socket binding
sleep 1

echo "[+] Step 4: Generating synthetic HTTP traffic to trigger capture..."
curl -s -o /dev/null "${TEST_URL}"
echo "----------------------------------------------------------------------"

# Task 4: Offline Packet Filtering & Payload Inspection
echo "[+] Step 5: Reading captured header data from '${OUTPUT_FILE}' (Verbose Mode)..."
sudo tcpdump -nn -r "${OUTPUT_FILE}" -v
echo "----------------------------------------------------------------------"

echo "[+] Step 6: Inspecting raw packet payload in Hexadecimal and ASCII (-X)..."
sudo tcpdump -nn -r "${OUTPUT_FILE}" -X

echo "----------------------------------------------------------------------"
echo "[+] Pipeline Execution Complete. Packet analysis finished."