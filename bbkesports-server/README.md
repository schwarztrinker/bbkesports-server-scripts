# BBKESports Server Collection

## SSH delete old key

```bash
ssh-keygen -R bbke.mstoecker.de -f C:\Users\marti\.ssh\known_hosts
```



## .env File

```cfg
CLOUDFLARE_API_TOKEN=0kO8Vxxxxxxx
```

## After Deployment steps 
``` bash
steamcmd

> login mstoeckersteamserver
```


## Server Configuration / Console 

```bash 
cd /opt/gmodserver
./gmodserver console
./gmodserver debug
```

## GMOD Server 

Open ULX and enable admin


```bash 
cd /opt/gmodserver
./gmodserver console

ulx adduser schwarztrinker superadmin
```
In Garrys Mod: bind m xgui

Open ULX in GarrysMod via Key "m"


## Import Backups 
scp -r "../backups/necserver_backup_zbz_202411/opt/necserver/serverfiles/saves/worlds/MyWorld" adminuser@bbke.mstoecker.de:/opt/necserver/serverfiles/saves/worlds
