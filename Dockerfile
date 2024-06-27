FROM ubuntu

RUN apt update && apt install -y build-essential libssl-dev libffi-dev zlib1g-dev libncurses5-dev libncursesw5-dev libreadline-dev libsqlite3-dev libgdbm-dev libdb5.3-dev libbz2-dev libexpat1-dev liblzma-dev tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
ADD https://www.python.org/ftp/python/3.11.4/Python-3.11.4.tgz /
RUN tar -xf Python-3.11.4.tgz && cd /Python-3.11.4 && ./configure --enable-optimizations && make -j $(nproc) &&  make altinstall
RUN pip3.11 install --upgrade pip

WORKDIR /app

COPY . /app/

RUN pip3.11 install -r requirements.txt

EXPOSE 8501

CMD ["streamlit", "run", "app.py", "--server.port=8501"]