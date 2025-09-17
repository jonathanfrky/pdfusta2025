# Yangiroq Python bazasi
FROM python:3.11-bookworm

# Kerakli papkalar
RUN mkdir /pdf && chmod 777 /pdf
WORKDIR /ILovePDF

# Python kutubxonalarini o‘rnatamiz
COPY ILovePDF/requirements.txt requirements.txt
RUN pip install --upgrade pip && pip install -r requirements.txt

COPY ILovePDF/libgenesis/requirements.txt requirements-libgenesis.txt
RUN pip install -r requirements-libgenesis.txt

# System kutubxonalarini o‘rnatamiz
RUN apt-get update && apt-get install -y \
    ocrmypdf \
    wkhtmltopdf \
    tree \
    libssl3 \
    && rm -rf /var/lib/apt/lists/*

# Kodni ichkariga nusxalash
COPY /ILovePDF .

# Strukturani ko‘rsatish (faqat debugging uchun)
RUN tree

# Asosiy komandani ishga tushirish
CMD ["bash", "run.sh"]
