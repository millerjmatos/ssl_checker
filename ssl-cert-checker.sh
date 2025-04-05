#!/bin/bash
# Created by: Muller Matos
# Website: www.mullertec.com.br
# Creation: apr-2025

# Script to check the validity of SSL certificates for multiple URLs
# The URLs are defined directly in the script, one per line

# List of URLs to check (add as many as you want, one per line)
URLS=(
  "mullertec.com.br"
  "roadmap.sh"
  "github.com"
  # Add more URLs below
)

# Loop to process each URL in the list
for URL in "${URLS[@]}"; do
  echo "Checking: $URL"

  # Get SSL certificate data
  data=$(openssl s_client -servername "$URL" -connect "$URL:443" 2>/dev/null | openssl x509 -noout -enddate | sed -e 's#notAfter=##')

  # Check if data was retrieved
  if [ -z "$data" ]; then
    echo "✘ ERROR: Could not retrieve certificate information for $URL"
    continue
  fi

  # Convert dates to Unix seconds
  ssldate=$(date -d "${data}" '+%s')
  nowdate=$(date '+%s')

  # Calculate difference in days
  diff="$((${ssldate}-${nowdate}))"
  days="$((${diff}/86400))"

  # Format output
  if [ "$days" -lt 0 ]; then
    echo "✘ EXPIRED: $URL - Certificate expired $((days * -1)) days ago (${data})"
  elif [ "$days" -lt 30 ]; then
    echo "⚠ WARNING: $URL - Certificate expires in $days days (${data})"
  else
    echo "✓ VALID: $URL - Certificate valid for $days more days (${data})"
  fi

  echo "----------------------------------------"
done
