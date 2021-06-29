FROM pytorch/torchserve:0.4.0-gpu

USER root

ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8

RUN apt update \
  && apt install -y nginx curl \
  && rm -rf /var/lib/apt/lists/*

RUN echo default_workers_per_model=1 >> /home/model-server/config.properties

WORKDIR /app
COPY requirements.txt .

RUN pip install --upgrade pip
RUN pip install -r requirements.txt

COPY nginx.conf .
COPY streamlit /streamlit

ARG DISTILBERT_BASE_UNCASED_FINETUNED_SST_2_ENGLISH_LINK
ENV DISTILBERT_BASE_UNCASED_FINETUNED_SST_2_ENGLISH_LINK $DISTILBERT_BASE_UNCASED_FINETUNED_SST_2_ENGLISH_LINK

ARG FINBERT_LINK
ENV FINBERT_LINK $FINBERT_LINK

ARG KOELECTRA_BASE_NSMC_LINK
ENV KOELECTRA_BASE_NSMC_LINK $KOELECTRA_BASE_NSMC_LINK

ARG TWITTER_ROBERTA_BASE_EMOTION_LINK
ENV TWITTER_ROBERTA_BASE_EMOTION_LINK $TWITTER_ROBERTA_BASE_EMOTION_LINK

COPY entrypoint.sh .
EXPOSE 80

ENTRYPOINT [ "bash", "entrypoint.sh" ]
