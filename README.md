Block all IPs from the given countries using iptables and ipset if available.

Refreshes data every 30 days from ipdeny.com

### Environment Variables

- `FX_COUNTRY_CODES=ru cn` - Required. Space-separated list of lowercase two-character country codes to block.
- `USE_IPSET=1` - Optional - Defaults to yes if ipset command is found.
