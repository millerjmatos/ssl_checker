# SSL Certificate Checker

A bash script to check SSL certificate expiration dates for multiple websites.

## Features

- Monitor multiple domains
- Visual status indicators (✓, ⚠, ✘)
- No external dependencies

## Usage

1. Clone and make executable:
   ```
   chmod +x ssl-cert-checker.sh
   ```

2. Edit domains list:
   ```bash
   URLS=(
     "example.com"
     "yourdomain.com"
     # Add more URLs here
   )
   ```

3. Run:
   ```
   ./ssl-cert-checker.sh
   ```

___
Created by [Muller Matos](https://linktr.ee/millerjmatos)
