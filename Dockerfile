# Base image for the container
FROM postgres:13
LABEL authors="rendiputra"

# Set environment variables
ENV POSTGRES_DB=invoicedb
ENV POSTGRES_USER=invoice
ENV POSTGRES_PASSWORD=randompasswordinvoice123
ENV PGDATA=/var/lib/postgresql/data/pgdata

# Define a volume to persist database data
#VOLUME /var/lib/postgresql/data/pgdata

# Copy initial data from the host machine (optional)
# Replace with your data directory if needed
COPY invoicedb-data /var/lib/postgresql/data

# Expose the container port
EXPOSE 5432

# Command to run when the container starts
CMD ["postgres", "-d"]