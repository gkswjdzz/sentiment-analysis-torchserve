curl -X GET $DISTILBERT_BASE_UNCASED_FINETUNED_SST_2_ENGLISH_LINK -o /home/model-server/model-store/distilbert-base-uncased-finetuned-sst-2-english.mar
curl -X GET $FINBERT_LINK -o /home/model-server/model-store/finbert.mar
curl -X GET $KOELECTRA_BASE_NSMC_LINK -o /home/model-server/model-store/kcelectra-base-nsmc.mar
curl -X GET $TWITTER_ROBERTA_BASE_EMOTION_LINK -o /home/model-server/model-store/twitter-roberta-base-emotion.mar

nginx -c /app/nginx.conf
nginx -s reload
torchserve --start --ncs --model-store=/home/model-server/model-store --ts-config /home/model-server/config.properties
sleep 10
ls /home/model-server/model-store > model_list.txt
cat model_list.txt | xargs -I {} curl -X POST http://localhost:8081/models?url={}
streamlit run /streamlit/summarize.py --server.enableXsrfProtection=false --server.enableCORS=true