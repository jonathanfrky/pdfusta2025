FROM python:3.11

# PDF uchun papka
RUN mkdir /pdf && chmod 777 /pdf

WORKDIR /ILovePDF

# Python kutubxonalarini o‘rnatish
COPY ILovePDF/requirements.txt requirements.txt
RUN pip install --upgrade pip && pip install -r requirements.txt

COPY ILovePDF/libgenesis/requirements.txt requirements.txt
RUN pip install -r requirements.txt

# Kerakli paketlar
RUN apt-get update && apt-get install -y \
    ocrmypdf \
    xfonts-75dpi \
    xfonts-base \
    wget \
    tree

# libssl1.1 ni qo‘lda o‘rnatamiz
RUN wget http://security.debian.org/debian-security/pool/updates/main/o/openssl/libssl1.1_1.1.1w-0+deb11u1_amd64.deb && \
    apt install -y ./libssl1.1_1.1.1w-0+deb11u1_amd64.deb && \
    rm ./libssl1.1_1.1.1w-0+deb11u1_amd64.deb

# wkhtmltopdf ni qo‘lda o‘rnatamiz
RUN wget https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6-1/wkhtmltox_0.12.6-1.buster_amd64.deb && \
    apt install -y ./wkhtmltox_0.12.6-1.buster_amd64.deb && \
    rm ./wkhtmltox_0.12.6-1.buster_amd64.deb

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Loyihani ichiga nusxalash
COPY /ILovePDF .

# Tekshirish uchun
RUN tree

# Run script
CMD ["bash", "run.sh"]
