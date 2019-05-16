# Build this image on a Python 3.7.1 image
FROM python:3.7.1

# Make the default shell bash
ENV SHELL=/bin/bash

# Update apt and install some bare essentials
RUN apt-get update && \
    apt-get install -y vim \
                    emacs \
                    nano \
                    wget \
                    curl \
                    sudo


# Upgrade pip
RUN pip install --upgrade pip

# Copy requirements.txt in so that pip can access it
COPY requirements.txt /home/requirements.txt

# Install the requirements.txt
RUN pip install -r /home/requirements.txt

ENTRYPOINT ["python3","/scripts/server.py"]
