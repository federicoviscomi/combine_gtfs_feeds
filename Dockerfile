FROM python:3.12-slim

WORKDIR /app

# Set noninteractive for apt
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies and locales
RUN apt-get update && \
    apt-get install -y locales && \
    echo "en_GB.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen en_GB.UTF-8

# Set environment variables for Python
ENV LANG=en_GB.UTF-8
ENV LANGUAGE=en_GB:en
ENV LC_ALL=en_GB.UTF-8

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY ./combine_gtfs_feeds ./combine_gtfs_feeds

RUN pwd && ls -al

CMD ["python", "-m", "combine_gtfs_feeds.cli.main", "run", "-g", "/data", "-o", "/output", "--service_date", "20260210"]


