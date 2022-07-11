FROM mcr.microsoft.com/playwright:focal

WORKDIR /app

#Install CDK and Frontend
RUN apt-get update && apt-get install -y \
    make \
    software-properties-common \
    && npm install -g aws-cdk ts-node

# Install deps for SAM Backend
RUN apt-get install -y \
    python3.9 python3-pip \
    python3.8-venv python3.9-venv 

# Keep jinja version to specific to avoid breaking
# https://www.datasciencelearner.com/importerror-cannot-import-name-escape-from-jinja2-solved/
RUN pip install pip \
    && pip install Jinja2==3.0.3 awscli aws-sam-cli==1.12.0 \
    && rm -rf /var/lib/apt/lists/*

# we are able to override the CMD instruction and execute any command successfully. 
# However, while we were successful, this process of overriding the CMD instruction 
# is rather clunky.
CMD ["make", "_run"]
