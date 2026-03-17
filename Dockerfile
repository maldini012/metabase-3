FROM metabase/metabase:latest

# Plugin dizinini image içine göm - oracle driver için
COPY plugins/ /plugins/
