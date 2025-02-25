#!/bin/bash

# Ensure all tools are installed and available in the system's PATH

# Check if a domain argument is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <domain>"
    exit 1
fi

DOMAIN=$1

# Function to install missing tools
install_tool() {
    TOOL=$1
    PACKAGE=$2
    if ! command -v $TOOL &>/dev/null; then
        echo "[+] $TOOL not found, installing..."
        sudo apt-get update && sudo apt-get install -y $PACKAGE
    else
        echo "[+] $TOOL is already installed."
    fi
}

# Install dependencies if not present
install_tool "subfinder" "subfinder"
install_tool "httpx" "httpx"
install_tool "subdominator" "subdominator"
install_tool "waybackurls" "waybackurls"
install_tool "katana" "katana"
install_tool "gau" "gau"
install_tool "knoxnl" "knoxnl"
install_tool "uro" "uro"
install_tool "anew" "anew"

# Step 1: Find subdomains
echo "[+] Finding subdomains using subfinder..."
subfinder -d $DOMAIN -all | httpx -silent -o subs1

echo "[+] Finding subdomains using subdominator..."
subdominator -d $DOMAIN | httpx -silent -o subs2

# Step 2: Merge all subdomains into one file
echo "[+] Merging subdomain files..."
cat subs1 subs2 | anew subs

# Step 3: Find history
echo "[+] Extracting history from Wayback Machine..."
cat subs | waybackurls | anew xss-wayback

echo "[+] Extracting history using Katana..."
katana -list subs -silent -o xss-katana

echo "[+] Extracting history using gau..."
cat subs | gau --subs --o xss-gau

# Step 4: Combine all history into one file
echo "[+] Combining history files into xss.txt..."
cat xss-wayback xss-katana xss-gau | anew xss.txt

# Step 5: Remove unnecessary extensions
echo "[+] Filtering URLs and removing unnecessary extensions..."
cat xss.txt | sort -u | grep "=" | egrep -iv "\.(css|woff|woff2|txt|js|m4r|m4p|m4b|ipa|asa|pkg|crash|asf|asx|wax|wmv|wmx|avi|bmp|class|divx|doc|docx|exe|gif|gz|gzip|ico|jpg|jpeg|jpe|webp|json|mdb|mid|midi|mov|qt|mp3|m4a|mp4|m4v|mpeg|mpg|mpe|webm|mpp|_otf|odb|odc|odf|odg|odp|ods|odt|ogg|pdf|png|pot|pps|ppt|pptx|ra|ram|svg|svgz|swf|tar|tif|tiff|_ttf|wav|wma|wri|xla|xls|xlsx|xlt|xlw|zip)" | uro | httpx | anew xss

# Step 6: Run Knoxnl
echo "[+] Running Knoxnl against filtered URLs..."
knoxnl -i xss -X BOTH -o xssoutput.txt

# Cleanup intermediate files if desired
echo "[+] Cleanup temporary files..."
rm subs1 subs2 xss-wayback xss-katana xss-gau xss.txt

echo "[+] Script execution completed. Results saved in xssoutput.txt."
