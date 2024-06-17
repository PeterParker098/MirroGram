FROM 5hojib/aeon:dev

WORKDIR /usr/src/app
RUN pip3 install --no-cache-dir aiofiles aiohttp aioshutil anytree apscheduler aria2p asyncio cloudscraper dnspython feedparser flask gevent google-api-python-client google-auth-httplib2 google-auth-oauthlib gunicorn httpx lxml motor natsort pillow psutil pycryptodome pymongo pyrofork==2.2.11 python-dotenv python-magic qbittorrent-api requests telegraph tenacity tgcrypto urllib3 uvloop xattr yt-dlp
RUN apt-get -y update && apt-get -qq install -y --no-install-recommends curl git gnupg2 unzip wget pv jq mediainfo

# add mkvtoolnix
RUN wget -q -O - https://mkvtoolnix.download/gpg-pub-moritzbunkus.txt | apt-key add - && \
    wget -qO - https://ftp-master.debian.org/keys/archive-key-10.asc | apt-key add -
RUN sh -c 'echo "deb https://mkvtoolnix.download/debian/ buster main" >> /etc/apt/sources.list.d/bunkus.org.list' && \
    sh -c 'echo deb http://deb.debian.org/debian buster main contrib non-free | tee -a /etc/apt/sources.list' && apt update && apt install -y mkvtoolnix

    
COPY . .
CMD ["bash", "start.sh"]
