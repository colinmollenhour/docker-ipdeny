Block all IPs from the given countries using iptables and ipset, if available.

- Refreshes data every 30 days from ipdeny.com.
- Pre-built image blocks only Russia and China. Build your own to customize.
- Firewall rules are removed when the container is stopped gracefully.
- Blocks for INPUT, FILTER and DOCKER-USER tables.

# Usage

Use the pre-built image:

```
docker pull ghcr.io/colinmollenhour/docker-ipdeny:main
docker run -d --cap-add NET_ADMIN --network host --restart unless-stopped --name my-firewall ghcr.io/colinmollenhour/docker-ipdeny:main
```

Build your own image:


```
git clone https://github.com/colinmollenhour/docker-ipdeny
cd docker-ipdeny
docker build . -t my-firewall --build-arg 'FW_COUNTRY_CODES=ru cn sa ua'
docker run -d --cap-add NET_ADMIN --network host --restart unless-stopped --name my-firewall my-firewall
```

Or with Docker Compose:

```
version: '3'

services:
  my-firewall:
    image: ghcr.io/colinmollenhour/docker-ipdeny:main
    container_name: my-firewall
    cap_add:
      - NET_ADMIN
    network_mode: host
    restart: unless-stopped
```

## Build Args

- `FW_COUNTRY_CODES=ru cn` - Required. Space-separated list of lowercase two-character country codes to block.

## Environment Variables

- `USE_IPSET=1` - Optional - Set to 0 if ipset is not to be used.
