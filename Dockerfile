FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
    sudo \
    wget \
    vim

WORKDIR /opt
RUN wget https://repo.continuum.io/archive/Anaconda3-2019.10-Linux-x86_64.sh && \
    sh Anaconda3-2019.10-Linux-x86_64.sh -b -p /opt/anaconda3 && \
    rm -f Anaconda3-2019.10-Linux-x86_64.sh

ENV PATH /opt/anaconda3/bin:$PATH

RUN pip install --upgrade pip
RUN pip install optuna
RUN pip install xgboost
RUN pip install --upgrade gensim
RUN apt-get install -y unzip
RUN conda install -y pytorch==1.2.0 torchvision==0.4.0 cpuonly -c pytorch
WORKDIR /
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--allow-root", "--LabApp.token=''", "--NotebookApp.iopub_data_rate_limit=1e10"]