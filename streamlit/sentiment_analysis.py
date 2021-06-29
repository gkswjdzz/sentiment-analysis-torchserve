import streamlit as st
import json
import requests


models = {
    'FinBERT for Sentiment Analysis': 'finbert',
    'Twitter-roBERTa-base for Sentiment Analysis': 'twitter-roberta-base-emotion',
    'DistilBERT base uncased finetuned SST-2': 'distilbert-base-uncased-finetuned-sst-2-english',
    'KoELECTRA for Sentiment Analysis (Korean)': 'kcelectra-base-nsmc',
}


def process():
    data = {
        'text': text,
    }
    res = requests.post('http://localhost/api/' + model_value, data=json.dumps(data), headers={"Content-Type": "application/json"})
    return res


FAVICON_URL = "https://ainize.ai/images/github-ainize-box@2x.png"

# Set page title and favicon.
st.set_page_config(
    page_title="Sentiment Analysis Text!", page_icon=FAVICON_URL,
)

st.title("Sentiment Analysis with teachable NLP!")

st.subheader("Select model and write sentence.")

model = st.selectbox('Select', list(models.keys()))
model_value = models[model]
text = st.text_input("Write the sentence you want to analysis!")

if st.button("Analysis!"):
    sts = process()
    res = sts.json()
    st.write("")
    st.write(res)
