FROM python:3.11

# Katalog yaratish
RUN mkdir /pdf && chmod 777 /pdf

# Ishchi katalog
WORKDIR /ILovePDF

# Python kutubxonalarini o‘rnatish
COPY ILovePDF/requirements.txt requirements.txt
RUN pip install --upgrade pip && pip install -r requirements.txt

COPY ILovePDF/libgenesis/requirements.txt requirements.txt
RUN pip install -r requirements.txt

# Zarur paketlar va wkhtmltopdf ni o‘rnatish
RUN apt-get update && apt-get install -y \
    ocrmypdf \
    xfonts-75dpi \
    xfonts-base \
    wget \
    tree && \
    wget https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6-1/wkhtmltox_0.12.6-1.buster_amd64.deb && \
    apt install -y ./wkhtmltox_0.12.6-1.buster_amd64.deb && \
    rm wkhtmltox_0.12.6-1.buster_amd64.deb && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Kodingizni konteynerga ko‘chirish
COPY /ILovePDF .

# Fayl strukturasini ko‘rish
RUN tree

# Run script
CMD ["bash", "run.sh"]

