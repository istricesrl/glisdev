come installare GlisWeb
=======================
Accedete via SSH al vostro server e scaricate lo zip del repository nella document root:

```
wget https://github.com/istricesrl/glisdev/archive/refs/heads/develop.zip
```

una volta scaricato il file, scompattatelo:

```
bsdtar --strip-components=1 -xf develop.zip
rm -f develop.zip
```

A questo punto il framework è raggiungibile tramite web, ma non configurato. Per vedere la situazione
e verificare che sia tutto ok aprite un browser su *http://nomesito/status*.

Per iniziare a lavorare con il framework è necessario creare un file di configurazione minimale
in */src/config.yaml*:

```
sites:
  1:
    __label__: "nome del tuo sito"
    name:
      it-IT: "nome del tuo sito"
    protocols:
      DEV: "https"
    hosts: 
      DEV: "nome host del tuo sito"
    domains:
      DEV: "dominio del tuo sito"
    homes:
      DEV: 1
auth:
  accounts:
    root:
      password: "hash md5 della password di root"
mysql:
  servers:
    default:
      address: "indirizzo del tuo server MySQL"
      port: "porta del tuo server MySQL"
      username: "nome utente per l'accesso al database"
      password: "password per l'accesso al database"
      db: "nome del database"
  profiles:
    DEV:
      servers:
        - "default"
mods:
  active:
    array:
      - "AN000.anagrafica"
      - "03000.contenuti"
      - "PA000.pagine"
      - "CO000.contenuti"
```
