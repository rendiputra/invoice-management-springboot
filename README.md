# Aplikasi Invoice Management

Aplikasi ini dipakai untuk mengelola invoice dan menyambungkan dengan berbagai metode pembayaran.

## Setup project
### Install package
```bash
$ mvn clean package -DskipTests
```

### running project
```bash
$ mvn clean spring-boot:run
```

### running posgreSQL on docker
```bash
$ docker run --rm \
	--name invoice-db \
	-e POSTGRES_DB=invoicedb \
	-e POSTGRES_USER=invoice \
	-e POSTGRES_PASSWORD=randompasswordinvoice123 \
	-e PGDATA=/var/lib/postgresql/data/pgdata \
	-v "$PWD/invoicedb-data:/var/lib/postgresql/data" \
	-p 5432:5432 \
	postgres:13
```
> catatan: 
>
> --rm untuk menghapus (destroy) setelah distop
> 
> -d untuk berjalan di background
> 
> $PWD jalan di macos/linux