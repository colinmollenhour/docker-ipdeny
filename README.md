Block all IPs from the given countries using iptables and ipset if available.

Refreshes data every 30 days from ipdeny.com. Pre-built image blocks only Russia and China.

# Usage

Use the pre-built image:

```
docker pull ghcr.io/colinmollenhour/docker-ipdeny:main
docker run -d --cap-add NET_ADMIN --network host --restart unless-stopped --name my-firewall ghcr.io/colinmollenhour/docker-ipdeny:main
```

Build your own image:


```
git clone 
docker build . -t my-firewall --build-arg 'FW_COUNTRY_CODES=ru cn sa ua'
docker run -d --cap-add NET_ADMIN --network host --restart unless-stopped --name my-firewall my-firewall
```

## Build Args

- `FW_COUNTRY_CODES=ru cn` - Required. Space-separated list of lowercase two-character country codes to block.

## Environment Variables

- `USE_IPSET=1` - Optional - Defaults to yes if ipset command is found.
