# SviluppoSito

Crea un ambiente di sviluppo per i plugin del sito di AIRIcerca

## Prerequisiti

Installa Docker, disponibile per:
* [https://docs.docker.com/install/#server](Linux)
* [https://docs.docker.com/docker-for-mac/](Mac)
* [https://docs.docker.com/docker-for-windows/](Windows)

(per Linux, devi installare separatamente anche [https://docs.docker.com/compose/install/](Docker-compose).)

## Istruzioni

Docker crea due macchine virtuali, una chiamata `svilupposito_db_1` contenente MySQL, e una chiamata `svilupposito_wordpress_1` contenente PHP 5.6 e Wordpress 5.0.4.
Le due macchine sono in comunicazione tra loro ed il database può essere riempito con utenti e articoli fittizi per testare nuovi plugin.

### 1. Partenza macchine virtuali

Apri una console sulla macchina locale e digita:

```
cd <path_to_SviluppoSito>
docker-compose up
```

Dopo aver scaricato le immagini, le macchine virtuali partiranno e si metteranno in comunicazione tra loro.
Se vuoi puoi loggarti su queste macchine per fare il debugging con questi comandi:

```
docker exec -ti svilupposito_db_1 /bin/bash
docker exec -ti svilupposito_wordpress_1 /bin/bash
```

### 2. Spegnimento macchine virtuali

Puoi spegnere le macchine virtuali premendo `CTRL+c` nella console dove vedi il log delle macchine.
Oppure puoi aprire una nuova console nella directory `SviluppoSito` e usare il comando `docker-compose stop`.
Potrai riavviare in ogni momento eseguendo ancora `docker-compose up` e ritroverai tutte le modifiche che hai eseguito.

Il comando `docker-compose down` cancella ogni cambiamento eseguito sulle macchine virtuale e serve se vuoi ripartire da zero.
Se vuoi anche eliminare i dati dal database devi eseguire `docker volume prune`

### 3. Primo utilizzo

Una volta attivate le macchine come al punto 1, puoi accedere al sito all'indirizzo [http://localhost:8000](http://localhost:8000) .
Se stai accedendo al sito per la prima volta, ti verrà chiesto di creare un nuovo utente e di procedere all'installazione di Wordpress.
I [plugin standard AIRIcerca](https://github.com/AIRIOpenLab/AIRIplugin) sono già installati ma devono essere attivati dal pannello di controllo di Wordpress.
Devi inoltre installare [PaidMembershipPro](https://www.paidmembershipspro.com/documentation/download/).

A meno di utilizzare `docker-compose down` per reinizializzare le macchine, dovrai eseguire questi passi una volta sola.
A questo punto, il pannello di controllo di Wordpress si trova su [http://localhost:8000/wp-admin/](http://localhost:8000/wp-admin/).

### 4. Importazione dati

Possiamo importare alcuni utenti e post fittizi usando lo script contenuto nella directory `scripts`:

```
cd SviluppoSito/scripts
./import_db.sh
```

Lo script funziona solo per Mac e Linux per il momento, ne posso creare uno per Windows all'occorrenza.

Tutti gli utenti creati e le pagine protette usano la password `pippo` per convenienza.

**IMPORTANTE:** Puoi usare lo script solo una volta installato ed attivato [PaidMembershipPro](https://www.paidmembershipspro.com/documentation/download/).


### 5. Pagine supportate

* Pagina assemblee: [http://localhost:8000/?page_id=5208](http://localhost:8000/?page_id=5208)
* Pagina iscrizione: [http://localhost:8000/?page_id=6822](http://localhost:8000/?page_id=6822)
* Pagina gestione utenti: [http://localhost:8000/?page_id=7336](http://localhost:8000/?page_id=7336)
* Pagina revisori: [http://localhost:8000/?page_id=11708](http://localhost:8000/?page_id=11708)
* Pagina AIRIediting: [http://localhost:8000/?page_id=12275](http://localhost:8000/?page_id=12275)


### 6. Varie

Per controllare le tavole del database, una volta loggati sulla macchina del database, puoi eseguire il comando:

```
mysql -uroot -p"$MYSQL_ROOT_PASSWORD" "$MYSQL_DATABASE"
```

ed eseguire le queries.