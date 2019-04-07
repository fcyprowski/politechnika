################ GCS ####################
# autoryzacja

install.packages("googleAuthR")
install.packages("googleCloudStorageR")
# autoryzacja -------------------------------------------------------------
# 1 sposob: automatyczny (niepolecany przy budowaniu aplikacji, ale wygodny
# w trybie interaktywnym)
Sys.setenv(GCS_AUTH_FILE = "gcs_key.json")
library(googleCloudStorageR)
# drugi sposob - gar auth (mamy wieksza kontrole)
# lista scope'ow
# https://developers.google.com/identity/protocols/googlescopes
googleAuthR::gar_auth_service(
  "gcs_key.json", 
  scope = "https://www.googleapis.com/auth/devstorage.full_control"
)

library(googleCloudStorageR)
our_test_bucket = "ad_explorer_shiny_pb"
gcs_list_buckets("private-lab-218014")
bucket = gcs_get_bucket(our_test_bucket)
objects = gcs_list_objects(our_test_bucket)
# test read ---------------------------------------------------------------
gcs_get_object("model.rds", 
               bucket = our_test_bucket,
               saveToDisk = "model_downloaded.rds")
model = readRDS("model_downloaded.rds")

# test save ---------------------------------------------------------------
gcs_upload("iris.csv", 
           bucket = our_test_bucket, 
           name = "fcyprowski/iris.csv")
gcs_list_objects(our_test_bucket)

