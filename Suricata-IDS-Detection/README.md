# Network Traffic Analysis and Custom IDS Rule Triggering with Suricata

## Overview
This project demonstrates the setup, testing, and telemetry analysis of custom Intrusion Detection System (IDS) rules using Suricata. It covers rule syntax breakdown, execution against network traffic captures (`.pcap`), and structured log analysis using `jq`.

---

## Project Structure
```text
Suricata-IDS-Detection/
├── rules/
│   └── custom.rules      # Custom Suricata detection rules
└── README.md             # Activity documentation and analysis
```

---

## Lab Walkthrough

### Task 1: Examine a Custom Rule in Suricata
Analyzed the custom rule defined in `rules/custom.rules`:

```snort
alert http $HOME_NET any ->$EXTERNAL_NET any (msg:"GET on WIRE"; flow:established,to_server; content:"GET"; http_method; sid:1000001; rev:1;)
```

#### Rule Syntax Breakdown:
* **Action (`alert`):** Directs Suricata to generate an alert upon matching network traffic.
* **Header (`http $HOME_NET any -> $EXTERNAL_NET any`):** Inspects HTTP traffic originating from any port on the internal network destined for any port on an external network.
* **Rule Options:**
  * `msg:"GET on WIRE"`: Defines the human-readable text included in alert logs.
  * `flow:established,to_server`: Restricts inspection to active, established TCP sessions directed toward the server.
  * `content:"GET"; http_method;`: Specifies payload inspection targeting the HTTP request method.
  * `sid:1000001`: Assigns a unique Signature ID for the custom rule.
  * `rev:1`: Tracks the rule revision version.

---

### Task 2: Trigger a Custom Rule in Suricata
Executed Suricata in packet capture processing mode against a sample PCAP file using the custom rule set:

```bash
sudo suricata -r sample.pcap -S rules/custom.rules -k none
```

* `-r sample.pcap`: Reads and analyzes recorded network packets.
* `-S rules/custom.rules`: Applies the custom detection rule set.
* `-k none`: Disables checksum validation to ensure packets with invalid checksums during testing are not dropped.

#### Generated Outputs:
* `/var/log/suricata/fast.log`: Compact single-line text alerts for rapid triage.
* `/var/log/suricata/eve.json`: Highly granular Extensible Event Format (EVE) JSON logs containing full metadata and flow statistics.

---

### Task 3: Examine `eve.json` Output
Utilized the `jq` command-line JSON processor to inspect, filter, and format security events.

#### 1. Pretty-Printing JSON Output
Formatted the raw `eve.json` log for readable terminal inspection:
```bash
jq . /var/log/suricata/eve.json | less
```
* **Key Finding:** Triggered alerts evaluated to a `severity` level of `3`.

#### 2. Extracting Specific Attributes
Filtered JSON payloads to display essential fields (`timestamp`, `flow_id`, `alert.signature`, `proto`, `dest_ip`):
```bash
jq -c "[.timestamp, .flow_id, .alert.signature, .proto, .dest_ip]" /var/log/suricata/eve.json
```
* **First Event Signature:** `"GET on WIRE"`
* **Last Event Destination IP:** `142.250.1.102`

#### 3. Flow Correlation
Filtered telemetry by a specific 16-digit `flow_id` to aggregate all activity linked to a single network session:
```bash
jq "select(.flow_id==14500150016149)" /var/log/suricata/eve.json
```

---

## Key Takeaways
1. **Targeted Detection:** Using HTTP-specific protocol options like `http_method` optimizes detection accuracy and reduces false positives compared to raw payload matching.
2. **Session Correlation:** The unique `flow_id` in `eve.json` serves as a critical pivot point for correlating disparate events across an entire TCP connection.
3. **Log Automation:** Command-line JSON parsing with `jq` enables fast log filtering and streamlines integration into modern SIEM platforms.