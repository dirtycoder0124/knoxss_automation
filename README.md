# XSS Recon Automation Script

## Overview
This Bash script automates the process of discovering subdomains and extracting historical URLs to identify potential cross-site scripting (XSS) vulnerabilities. It utilizes several tools to streamline reconnaissance and vulnerability detection efficiently.

## Features
- Finds subdomains using `subfinder` and `subdominator`
- Extracts historical URLs from `waybackurls`, `katana`, and `gau`
- Filters URLs to remove unnecessary file extensions
- Runs `knoxnl` to analyze URLs for potential XSS vulnerabilities
- Outputs results to `xssoutput.txt`

## Prerequisites
Ensure your system has the following dependencies installed:
- `subfinder`
- `httpx`
- `subdominator`
- `waybackurls`
- `katana`
- `gau`
- `knoxnl`
- `uro`
- `anew`

The script will automatically install missing dependencies using `apt-get` if they are not found in the system.

## Installation
1. Clone this repository:
   ```bash
   git clone https://github.com/dirtycoder0124/knoxss_automation.git
   cd <repository-folder>
   ```
2. Make the script executable:
   ```bash
   chmod +x knoxss_automation.sh
   ```

## Usage
Run the script by providing a domain name as an argument:
```bash
./knoxss_automation.sh example.com
```

### Output Files
- `xssoutput.txt`: The final output containing potential XSS vulnerable URLs.
- Intermediate files are cleaned up automatically after execution.

## Notes
- The script is optimized for automation and should be run in an environment where tools can be installed via `apt-get`.
- Use responsibly and only on domains you have permission to test.
- Modify the script as needed to fit your specific reconnaissance workflow.

## Disclaimer
This script is intended for educational and lawful security testing purposes only. The author is not responsible for any misuse or unauthorized testing conducted with this tool.

