#!/bin/bash

download_folder="raw/"
BUCKET="movies_data_lake"

# Download movies dataset from Kaggle
kaggle datasets download -d rounakbanik/the-movies-dataset

# Unzip the dataset
unzip the-movies-dataset.zip -d "${download_folder}/the-movies-dataset"
rm the-movies-dataset.zip

# Download St Louis Fred's CPI dataset.
url="https://fred.stlouisfed.org/graph/fredgraph.csv?bgcolor=%23e1e9f0&chart_type=line&drp=0&fo=open%20sans&graph_bgcolor=%23ffffff&height=450&mode=fred&recession_bars=on&txtcolor=%23444444&ts=12&tts=12&width=1138&nt=0&thu=0&trc=0&show_legend=yes&show_axis_titles=yes&show_tooltip=yes&id=CUSR0000SS62031&scale=left&cosd=1999-01-01&coed=2023-02-01&line_color=%234572a7&link_values=false&line_style=solid&mark_type=none&mw=3&lw=2&ost=-99999&oet=99999&mma=0&fml=a&fq=Monthly&fam=avg&fgst=lin&fgsnd=2020-02-01&line_index=1&transformation=lin&vintage_date=2023-04-03&revision_date=2023-04-03&nd=1999-01-01"

echo "downloading ${url} to ${download_folder}..."
wget "${url}" -O "${download_folder}/cpi.csv"

# Upload the dataset to GCS
echo "uploading ${download_folder} to ${BUCKET}..."
gsutil -m cp -r "${download_folder}"/* gs://"${BUCKET}"/

# Remove the dataset
echo "removing ${download_folder}..."
rm -r "${download_folder}"