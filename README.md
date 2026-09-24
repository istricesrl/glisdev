# GlisWeb

**Framework PHP per siti e applicazioni web gestionali: CMS, backoffice, e-commerce e documenti in
un'unica base di codice, pensata per il mercato italiano.**

> **Questo è `glisdev`, la linea unstable.** È qui che avviene lo sviluppo: il codice di
> [**glisweb**](https://github.com/istricesrl/glisweb), la linea stable, viene riscritto e portato su
> questo repository un pezzo alla volta. **È la linea consigliata per i progetti nuovi**, a meno che
> non serva un modulo o un'integrazione che qui non è ancora arrivato: in quel caso si parte da
> glisweb. Il confronto fra le due linee è al paragrafo [stable e unstable](#stable-e-unstable).

---

## Cos'è GlisWeb

GlisWeb è un framework PHP full-stack per costruire **siti dinamici e applicazioni web gestionali**:
il sito pubblico, l'area riservata e il backoffice con cui si gestiscono anagrafiche, contenuti,
catalogo, ordini, documenti, attività e contratti nascono dalla stessa installazione e condividono lo
stesso database.

Non è un CMS da installare e usare così com'è, e non è nemmeno un micro-framework da cui partire da
zero. Sta nel mezzo: dà a chi sviluppa un'infrastruttura completa ( routing, configurazione
multi-ambiente, autenticazione e permessi, database, cache, code di mail e SMS, job in background,
stampe, API ) e un catalogo di moduli già pronti, e lascia a chi sviluppa il compito di comporli e
personalizzarli per il cliente.

## Quale problema risolve

Chi realizza software per piccole e medie imprese si trova a costruire sempre le stesse cose: un sito
con qualche pagina gestibile, un'area riservata, un backoffice con le schede di clienti e fornitori,
un catalogo, un carrello, i documenti di vendita, le stampe in PDF, l'invio di mail, la fatturazione
elettronica. Con un CMS si arriva presto al sito ma il gestionale diventa una collezione di plugin
che non si parlano; con un framework generico il gestionale si fa bene, ma va scritto da capo ogni
volta.

GlisWeb nasce per non riscrivere le stesse cose: **la parte comune è già fatta, ed è fatta sempre
nello stesso modo**. Una schermata di elenco o una scheda del backoffice non richiedono codice ma una
tabella, una vista e un array di configurazione; un modulo si attiva creando una cartella; un file
del framework si personalizza scrivendone uno con lo stesso nome senza underscore. Il tempo del
progetto va nelle cose che sono davvero di quel cliente.

## Un po' di storia

GlisWeb nasce dal codice scritto da **Fabio Mosti** ed **Emiliano Volta** a cavallo fra la fine degli
anni '90 e l'inizio degli anni 2000; la prima stesura del sorgente come framework unico è dell'**8
marzo 2003**. Da allora non ha mai smesso di essere usato in produzione e aggiornato, e oggi è
sviluppato e mantenuto da Fabio Mosti insieme al team di [Istrice srl](https://www.istricesrl.it).

Vent'anni di uso reale sono il suo punto di forza e anche la ragione di alcuni suoi limiti: molte
soluzioni sono collaudate da centinaia di casi concreti, ma nel codice convivono strati di età
diverse. Per questo il framework è in una fase di **riscrittura progressiva**: il codice
viene rivisto, semplificato e portato su questo repository, e quando il lavoro sarà finito le due
linee torneranno a essere una sola.

## A chi è rivolto

- **agenzie web e sviluppatori freelance** che realizzano siti e gestionali per PMI e vogliono una base
  unica per tutti i progetti, invece di un CMS diverso per ogni esigenza;
- **software house** che hanno bisogno di un backoffice completo senza scriverlo da zero, e di
  integrazioni già pronte con servizi usati in Italia;
- **chi deve manutenere nel tempo molti progetti simili**: le convenzioni sono le stesse ovunque, e
  un progetto aperto dopo tre anni si legge come uno scritto ieri.

Non è rivolto a chi cerca uno strumento da usare **senza scrivere codice**: GlisWeb si installa e si
configura da riga di comando, e un progetto richiede comunque uno sviluppatore PHP. Una volta
realizzato il progetto, invece, il CMS è pensato per operatori non tecnici.

## Come è fatto

### Il ciclo di una richiesta

Ogni richiesta passa dal `.htaccess`, che la instrada verso un piccolo numero di punti di ingresso
( pagine, API REST, download, upload, task, job, cron ). Ciascuno carica il bootstrap del framework,
che legge la configurazione ed esegue in ordine i **runlevel**: file numerati che inizializzano un
pezzo alla volta database, sessione, autenticazione, pagine, servizi esterni. Poi la **macro** della
pagina prepara i dati, e un **template Twig** li disegna.

```
richiesta → .htaccess → _src/_api/ → bootstrap e runlevel → macro → template Twig → risposta
```

### Standard e personalizzazione: la regola dell'underscore

È l'idea su cui si regge tutto. **I file e le cartelle che iniziano con `_` sono il framework**:
vengono sovrascritti a ogni aggiornamento e non si modificano. **I file con lo stesso nome senza
underscore sono il progetto**: il framework li cerca da solo e li usa al posto dello standard, o in
aggiunta.

```
_src/_lib/_mail.tools.php    → lo standard
src/lib/mail.tools.php       → lo sostituisce
src/lib/mail.tools.add.php   → lo estende
```

La conseguenza pratica è che **aggiornare il framework non rompe le personalizzazioni**, e che in
ogni progetto si vede a colpo d'occhio cosa è standard e cosa è stato fatto per quel cliente.

### Configurazione multi-ambiente

La configurazione sta in `src/config.yaml` ( o `.json` ) e le credenziali in `src/shadow.yaml`, che
non va mai in git. Ogni valore che cambia fra sviluppo, collaudo e produzione si scrive una volta per
ambiente, e **il framework capisce da solo in che ambiente si trova** guardando il dominio con cui
viene chiamato: lo stesso file di configurazione si copia identico su tutte le macchine.

### Moduli e template

Le funzioni gestionali sono organizzate in **moduli** ( `_mod/` ), tutti spenti finché non vengono
attivati; l'aspetto del sito e del backoffice è dato dai **template** ( `_src/_tpl/` ), basati su
Twig e Bootstrap. Un progetto attiva i moduli che gli servono, sceglie o personalizza un template, e
aggiunge solo quello che è suo.

## Come si presenta

Dal punto di vista di chi usa il prodotto finito, un'applicazione GlisWeb ha tre facce:

- il **sito pubblico**, multilingua, con pagine gestite dal CMS o scritte nel codice;
- l'**area riservata**, con registrazione, login e i servizi per clienti e soci;
- il **backoffice** ( `/admin` ), in cui gli operatori gestiscono tutto con schermate di elenco,
  filtri, schede e sottoschede, esportazioni e stampe. Tutte le schermate sono costruite con lo stesso
  schema, per cui chi ne ha usata una sa usarle tutte.

A chi sviluppa, il framework si presenta invece con la **pagina di status** ( `/status` ): un
rapporto che controlla l'installazione voce per voce e dice cosa manca e cosa è configurato male.

## Cosa offre

### Il nucleo

Quello che segue è il framework come lo si trova su questa linea; dove una funzione è ancora solo su
glisweb, lo dice il testo.

- **CMS** multilingua e multi-sito: una sola installazione può servire più siti, in più lingue;
- **backoffice** con schermate di elenco e scheda generate a partire dalle tabelle, senza codice;
- **autenticazione e permessi**: account, gruppi, privilegi, permessi per tabella, login via form,
  JWT, HTTP Basic;
- **database MySQL/MariaDB** con schema versionato e applicato dal framework, viste, cache delle query;
- **cache** su Memcached, Redis e APCu, con cache delle pagine e governo di Varnish;
- **mappe**: proxy con cache per le tile di OpenStreetMap;
- **invio di mail** via SMTP;
- **job in background** e **cron**, per i lavori lunghi e le attività periodiche;
- **API REST** sulle stesse tabelle del backoffice, con gli stessi permessi;
- **esportazioni** in CSV e gestione di file XML;
- **privacy**: gestione dei consensi, dei cookie e del titolare del trattamento;
- **documentazione** generata dal codice: manuale sviluppatore, manuale utente e guide introduttive.

Le stampe in PDF, la generazione di documenti Office, le code di invio degli SMS e le importazioni da
Excel ci sono su glisweb e sono fra le prossime da portare.

### I moduli

Su questa linea ci sono **24 moduli**, tutti di nuova generazione: account, anagrafica, contatti,
attività, contenuti, pagine, notizie, immagini, video, file, template, mail, catalogo, prodotti,
listini, documenti, fatture, offerte, commerciale, produzione, logistica, amministrazione e acquisti.

Su glisweb i moduli sono 79: e-commerce, coupon, contratti, abbonamenti, tesseramenti, corsi,
agenda, ticket, mailing, casse, SMS e i verticali ( immobiliare, veicoli, macchine, software ) sono
fra quelli non ancora portati. Ogni modulo ha il suo `READ.md`; i manuali li raccolgono tutti.

### Integrazioni con terze parti

Il framework porta con sé le integrazioni che nei progetti per il mercato italiano servono più
spesso. **Su questa linea quelle già portate sono** l'invio di mail via SMTP, Google reCAPTCHA,
Memcached, Redis, APCu, FTP, i token JWT e Varnish; per le altre esiste già la configurazione per
ambiente, ma la libreria che le usa è ancora solo su glisweb. L'elenco completo, com'è su glisweb, è
questo:

| ambito | servizi |
|---|---|
| pagamenti | PayPal ( anche Advanced Checkout ), Nexi, Monetaweb |
| fatturazione elettronica | invio al Sistema di Interscambio tramite Archivium, e ricerca delle aziende |
| paghe e presenze | esportazione delle ore in formato Zucchetti |
| Google | Analytics, Tag Manager, reCAPTCHA, API di YouTube |
| Meta | Facebook Pixel ed eventi |
| mail | qualunque server SMTP, con firma DKIM, e verifica degli indirizzi con Emailable |
| SMS | Skebby, Ehiweb |
| geolocalizzazione | geocoding con MapQuest, tile di OpenStreetMap |
| notifiche | Slack |
| infrastruttura | Memcached, Redis, FTP, Varnish |
| documenti | PDF ( TCPDF ), Word, Excel, PowerPoint ( PhpOffice ) |

Per altri servizi ( TeamSystem, Microsoft, Amazon, Hotjar ) esiste già la configurazione per
ambiente, ma non ancora un'integrazione completa: sono punti di aggancio da cui partire.

### Commercio elettronico

> **Su questa linea il commercio elettronico non c'è ancora**: il modulo e-commerce e i pagamenti
> sono su glisweb, e un progetto che vende online oggi parte da lì. Qui ci sono già catalogo,
> prodotti, listini, offerte e fatture, su cui l'e-commerce verrà ricostruito.

Su glisweb, il modulo e-commerce gestisce **carrello, cassa e pagamenti** ( PayPal, Nexi, Monetaweb ), e si
appoggia ai moduli di catalogo, listini, coupon e documenti: un ordine diventa un documento di vendita
e poi una fattura, nello stesso database in cui stanno il magazzino e le anagrafiche. È pensato per
chi vende online **e** deve gestire quello che succede dopo l'ordine, non per aprire un negozio in
dieci minuti: in quel caso Shopify o WooCommerce sono più rapidi.

### Intelligenza artificiale

Su due fronti diversi, con due livelli di maturità diversi.

**Sviluppare con l'AI: sì, ed è un caso d'uso curato.** Il framework include una skill per
[Claude Code](https://claude.com/claude-code) ( `.claude/skills/glisweb/` ) e un manuale operativo
pensato per gli assistenti AI ( `_etc/_claude/_claude.framework.md` ), con le regole, le convenzioni e
le trappole note. Il fatto che GlisWeb ripeta ovunque gli stessi schemi lo rende un terreno
particolarmente favorevole: un assistente che ha capito un modulo sa scriverne un altro.

**Integrare l'AI nelle applicazioni: solo le basi.** C'è la configurazione per ambiente delle
credenziali OpenAI ( e su glisweb un esempio di chiamata alle API in `_usr/_examples/_openai/`, che
usa un modello ormai dismesso da OpenAI ), ma nessuna funzione del CMS o dei moduli usa ancora un
modello linguistico. Chi vuole integrare l'AI in un progetto ha l'infrastruttura per le chiamate REST, non una
funzione pronta.

## GlisWeb e gli altri

Il confronto onesto con gli strumenti con cui GlisWeb viene più spesso paragonato.

| | GlisWeb | WordPress | Drupal | Joomla | Laravel | Symfony |
|---|---|---|---|---|---|---|
| tipo | framework con CMS e gestionale | CMS | CMS / framework | CMS | framework | framework |
| backoffice gestionale pronto | **sì, completo** | no, plugin | in parte, moduli | no, estensioni | no ( pacchetti a pagamento o da scrivere ) | no |
| integrazioni italiane ( SDI, Nexi… ) | **incluse** | plugin di terzi | moduli di terzi | estensioni di terzi | da scrivere | da scrivere |
| uso senza sviluppatore | no | **sì** | in parte | sì | no | no |
| ecosistema di estensioni | piccolo | **enorme** | grande | medio | **enorme** | **enorme** |
| community | piccola | **enorme** | grande | media | **enorme** | grande |
| documentazione | italiano | tutte le lingue | inglese e altre | tutte le lingue | inglese | inglese |
| stile del codice | procedurale, convenzioni | procedurale, hook | OOP, Symfony | OOP | OOP moderno, PSR | OOP moderno, PSR |
| sviluppatori sul mercato | pochi | moltissimi | molti | molti | moltissimi | molti |

**Rispetto a WordPress, Joomla e Drupal**, GlisWeb vince dove il sito è solo una parte del progetto:
anagrafiche, documenti, magazzino, contratti, abbonamenti, fatturazione elettronica sono nativi e
condividono lo stesso database, invece di essere plugin di autori diversi che non si parlano e che
vanno aggiornati uno per uno. Perde, e nettamente, su tutto il resto: non ha un marketplace di temi e
plugin, non si installa con un clic, non si usa senza uno sviluppatore, e la community è una frazione
minuscola della loro.

**Rispetto a Laravel e Symfony**, GlisWeb dà subito un backoffice completo e decine di moduli
gestionali che con quei framework andrebbero scritti o comprati, e porta con sé integrazioni
specifiche per l'Italia. In cambio è meno moderno: il codice è procedurale e organizzato per
convenzioni invece che per classi e namespace, non segue gli standard PSR, non ha un ORM né un
container di dipendenze, e non ha l'ecosistema di pacchetti, strumenti e formazione che hanno loro.
Uno sviluppatore Laravel si trova sul mercato; uno sviluppatore GlisWeb, di solito, si forma.

**In sintesi:** GlisWeb conviene quando si realizzano per le PMI italiane progetti in cui sito e
gestionale sono la stessa cosa, e quando lo stesso team deve manutenere molti progetti simili per anni.
Non conviene per un blog, per un sito vetrina che il cliente vuole gestire da solo, né per un team
che deve poter assumere sviluppatori già formati sullo strumento.

## È facile da usare?

**La curva di apprendimento è ripida all'inizio e poi si appiattisce molto.** Le prime ore sono le più
difficili, perché GlisWeb non assomiglia a nient'altro: le pagine sono voci di un array, i form sono
campi nominati secondo una convenzione, la personalizzazione passa dai nomi dei file. Chi viene da
Laravel o Symfony deve mettere da parte alcune abitudini.

Superato questo scoglio, però, **tutto si ripete**: chi ha capito un runlevel li ha capiti tutti, chi
ha scritto una macro sa scrivere la successiva, chi ha attivato un modulo sa attivarli tutti. È una
scelta di progetto esplicita, e il motivo per cui il framework è rigoroso nel rifiutare soluzioni
nuove quando ne esiste già una: ogni eccezione toglierebbe questa proprietà a chi viene dopo.

**Un progetto GlisWeb è facile da manutenere** per le stesse ragioni: le personalizzazioni sono
separate dallo standard, quindi si aggiorna il framework senza perderle; la struttura è la stessa in
tutti i progetti; su glisweb lo script di aggiornamento fa il backup e mette da parte le modifiche
fatte per errore ai file del framework, invece di cancellarle in silenzio, e su questa linea arriverà
con il resto.

## È moderno? È sicuro?

**È un framework maturo e mantenuto, non un progetto abbandonato**: riceve commit quasi ogni giorno,
supporta PHP 8 ( la versione consigliata è la 8.2 ), usa Twig, Bootstrap 5 e Composer. Ma porta i
segni della sua età, e conviene saperlo: il codice non è orientato agli oggetti, Twig è ancora alla
versione 2, alcuni template sono ancora su Bootstrap 4 e la migrazione a Bootstrap 5 è a metà, e sulla
linea stable convivono moduli di due generazioni. La riscrittura in corso su glisdev esiste proprio
per questo, e su questa linea il codice nuovo è già più pulito e coerente di quello che sostituisce.

**Sulla sicurezza**, il framework applica di serie le protezioni che in altri strumenti vanno
configurate a mano: il `.htaccess` nega l'accesso a configurazione, log, sessioni e file sensibili; i
cookie di sessione sono `secure`, `httponly` e `samesite`; l'id di sessione viene rigenerato al login;
le password sono salvate con `password_hash()` di PHP ( bcrypt, con salt ), e gli hash MD5 delle versioni
precedenti vengono ricalcolati da soli al primo login di ciascun utente;
i permessi sono verificati per tabella anche sulle API; lo script dei permessi impedisce al web server
di scrivere nei file del framework, e se la cartella di installazione è scrivibile il framework si
rifiuta di partire. Le vulnerabilità si segnalano in privato secondo la
[security policy](https://github.com/istricesrl/glisdev/blob/develop/SECURITY.md),
che prevede **una ricompensa in denaro** per le segnalazioni confermate.

**Compatibilità:** il framework è pensato per **Debian stable e Ubuntu** con Apache, PHP 8 e
MySQL/MariaDB. Su questa linea funziona anche con **Nginx** ( per esempio su CloudPanel ) e IIS,
grazie al front controller `index.php`, che su glisweb non c'è. Gli script di
amministrazione sono scritti per Debian e Ubuntu e su altri sistemi potrebbero non funzionare. Su
Windows si sviluppa con XAMPP.

## Come si comincia

La strada completa, dal server vuoto al primo login, è nella
[**guida all'installazione**](https://github.com/istricesrl/glisdev/blob/develop/_usr/_docs/_quickstart/020.installazione.md). In breve, su un server
Debian o Ubuntu con Apache, PHP e Composer:

```bash
cd /var/www/miosito
wget https://github.com/istricesrl/glisdev/archive/refs/heads/develop.zip
bsdtar --strip-components=1 -xf develop.zip
rm -f develop.zip
composer update
```

poi si scrive una configurazione minima in `src/config.yaml` e `src/shadow.yaml`, si sistemano i
permessi con `sudo _src/_sh/_lamp.permissions.secure.sh` e si apre `/status` nel browser: da lì in
poi è il framework a dire cosa manca. Con il database, `/task/mysql.patch` crea le tabelle e `/admin`
porta al CMS.

> **nota** — si installa sempre il ramo `develop`, che è più aggiornato di `master`.

## Documentazione, esempi e tutorial

| cosa | dove |
|---|---|
| **guida all'installazione**, dal server vuoto al primo login | [`_usr/_docs/_quickstart/020.installazione.md`](https://github.com/istricesrl/glisdev/blob/develop/_usr/_docs/_quickstart/020.installazione.md) |
| **da zero a hero**, la guida introduttiva al framework | [`_usr/_docs/_quickstart/010.da-zero-a-hero.md`](https://github.com/istricesrl/glisdev/blob/develop/_usr/_docs/_quickstart/010.da-zero-a-hero.md) |
| **manuale sviluppatore**: architettura, funzioni, reference di file e database, howto, integrazioni | [`_usr/_docs/_read/`](https://github.com/istricesrl/glisdev/tree/develop/_usr/_docs/_read/) |
| **manuale utente**: le schermate e le operazioni quotidiane | [`_usr/_docs/_user/`](https://github.com/istricesrl/glisdev/tree/develop/_usr/_docs/_user/) |
| **domande frequenti** e glossario | [`_usr/_docs/_read/910.faq.md`](https://github.com/istricesrl/glisdev/blob/develop/_usr/_docs/_read/910.faq.md), [`950.glossario.md`](https://github.com/istricesrl/glisdev/blob/develop/_usr/_docs/_read/950.glossario.md) |
| documentazione dei singoli moduli e template | il `READ.md` di ogni cartella in `_mod/` e `_src/_tpl/` |
| **esempi** di codice per il nucleo e le librerie ( su glisweb ce ne sono per una trentina di servizi ) | [`_usr/_examples/`](https://github.com/istricesrl/glisdev/tree/develop/_usr/_examples/) |
| dove si legge tutto questo via web, e come si genera | [`READ.md`](https://github.com/istricesrl/glisdev/blob/develop/READ.md) |

I manuali sono scritti in markdown e si generano in HTML e PDF con `_src/_sh/_docs.build.sh --all`.
La documentazione è **in italiano**, come il codice; il passaggio all'inglese di tutto il progetto è
previsto ma non ancora iniziato. La reference delle API generata dai commenti del codice è un lavoro in
corso e dichiara in testa la propria copertura.

**Video:** quelli pubblicati finora riguardano la versione precedente del framework e non sono più
aggiornati; nuovi tutorial sono previsti insieme al sito del progetto, in costruzione.

## Licenza e costi

GlisWeb è **gratuito**, senza costi di licenza né limiti di utilizzo, anche commerciale. È rilasciato
sotto la licenza [SVDOL](https://github.com/istricesrl/glisdev/blob/develop/LICENSE.md) ( *SeanVonDrake Open License* ), che non è una licenza standard
approvata dalla OSI e va letta prima dell'uso. In sintesi consente di usare, copiare, modificare e
redistribuire il framework, anche a pagamento, a condizione di:

- includere la licenza inalterata, con l'attribuzione all'autore, in ogni copia;
- distribuire sempre i sorgenti e la documentazione originale;
- **inviare all'autore una copia dei software derivati**, con sorgenti e documentazione, perché le
  migliorie possano tornare nel framework; è considerato derivato qualunque software che ne incorpori
  anche solo una parte;
- segnalare nella licenza che il software è stato modificato da altri.

Il software è fornito così com'è, senza garanzie. `LICENSE.md` e questo `README.md` fanno parte del
framework e non vanno rimossi dalle installazioni.

## Community e assistenza

- **[issue di GitHub](https://github.com/istricesrl/glisdev/issues)** per segnalare bug e chiedere
  nuove funzioni;
- **[server Discord](https://discord.gg/2nynQcXAWf)** per le domande, l'aiuto e le discussioni con chi
  sviluppa e usa il framework;
- **vulnerabilità di sicurezza**: mai in una issue pubblica, ma secondo la
  [security policy](https://github.com/istricesrl/glisdev/blob/develop/SECURITY.md).

La community è piccola, e conviene dirlo chiaramente: le risposte arrivano da chi sviluppa il
framework, non da migliaia di utenti. In compenso arrivano da chi il codice lo conosce.

### Contribuire

Ogni aiuto è benvenuto: segnalazioni di bug, richieste di funzioni, traduzioni, refactoring, pull
request. Le regole sono in [CONTRIBUTING.md](https://github.com/istricesrl/glisdev/blob/develop/CONTRIBUTING.md)
e nel [codice di condotta](https://github.com/istricesrl/glisdev/blob/develop/CODE_OF_CONDUCT.md). Lo
sviluppo del framework avviene su questo repository: chi vuole contribuire al codice clona questo, e
deve attivare i git hook di sviluppo come spiegato nella guida all'installazione. Chi non può contribuire con il codice può sostenere il progetto tramite
[GitHub Sponsors](https://github.com/sponsors/istricesrl).

## Stable e unstable

GlisWeb è diviso temporaneamente in due repository, che sono due fasi di sviluppo dello stesso
progetto:

| | **glisweb** | **glisdev** ( questa linea ) |
|---|---|---|
| ruolo | stable | unstable, dove avviene lo sviluppo |
| release attuale | 2.0 | 2.1 |
| contenuto | il framework completo | il framework riscritto, un sottoinsieme che cresce |
| moduli | 79, di due generazioni | 24, solo di nuova generazione |
| integrazioni | tutte quelle elencate sopra | in porting: per ora mail, reCAPTCHA, FTP, Redis, Memcached |
| web server | Apache | Apache, Nginx, IIS |
| aggiornamento automatico | `_src/_sh/_gw.upgrade.sh` | non ancora |
| per chi | i progetti che hanno bisogno di moduli e integrazioni non ancora portati | **i progetti nuovi** |

Le funzioni vengono portate da glisweb a glisdev una alla volta, riviste e semplificate. Quando il
porting sarà finito i due repository verranno riuniti. Il framework viene aggiornato continuamente:
ogni commit ha un numero di versione ( `_etc/_current.version` ), e le release sono in
`_etc/_current.release`, con la cronologia in `_etc/_changelog.json`.
Un'installazione sa da sola se è aggiornata: la pagina di status la confronta con l'ultima versione
pubblicata.

## Chi c'è dietro

GlisWeb è ideato e mantenuto da **Fabio Mosti** con il team di [Istrice srl](https://www.istricesrl.it),
che lo usa ogni giorno per i progetti dei propri clienti. Negli anni hanno contribuito, fra gli altri,
Emiliano Volta, Chiara Giardino Di Lollo, Silvia De Falco, Federico Pierantoni e Valeria Troiano.

Il framework si appoggia a librerie open source a cui va il nostro ringraziamento, fra cui Twig,
PHPMailer, TCPDF, PhpSpreadsheet, PhpWord, PhpPresentation, Predis, league/commonmark, html2text,
Bootstrap, jQuery e Codeception.
