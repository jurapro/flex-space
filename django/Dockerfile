FROM python:3.10
ARG SSH_PASS=password
ARG SSH_USER=login
ARG DJANGO

ENV PYTHONUNBUFFERED 1


#Install django
RUN mkdir /web_django
WORKDIR /web_django
COPY requirements.txt /web_django/
RUN pip install --upgrade pip && pip install -r requirements.txt

#Install ssh
RUN apt-get update && apt-get -y install --fix-missing openssh-server

#Add user
RUN useradd -m -s /bin/bash -p $(openssl passwd -1 $SSH_PASS) $SSH_USER
RUN usermod -g $SSH_USER $SSH_USER
RUN usermod -aG sudo $SSH_USER
RUN chown -R $SSH_USER.$SSH_USER /web_django
RUN echo "cd /web_django">>/home/$SSH_USER/.bashrc

COPY start.sh /var/start.sh
RUN chmod 777 /var/start.sh

#USER $SSH_USER

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

ENTRYPOINT /var/start.sh && \
        python /web_django/manage.py runserver 0.0.0.0:8000