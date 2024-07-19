# Minecraft message of the day

Set your colourful message of the day in `server.properties` using adjectives from WordNet.

## Scheduling

Run the job daily at 03:00 and restart the server.

```cron
0 3 * * * /srv/minecraft-server/motd.sh && /usr/bin/systemctl restart minecraft-server.service
```

## Dependencies

```sh
apt install wordnet
```

Data files can be found at `/usr/share/wordnet/`.
