OS = $(shell uname -s | tr A-Z a-z)
DL_DIR = downloads
ARCH = amd64
# https://www.terraform.io/docs/extend/how-terraform-works.html#plugin-locations
TF_PLUG_DIR := terraform.d/plugins/$(OS)_$(ARCH)

TF_INFLUXDB_VER := v1.0.2-custom
TF_INFLUXDB_ZIP_FILE := terraform-provider-influxdb_$(TF_INFLUXDB_VER)_$(OS)_$(ARCH).zip
TF_INFLUXDB_BIN_FILE := terraform-provider-influxdb
TF_INFLUXDB_ZIP_DL := $(DL_DIR)/$(TF_INFLUXDB_ZIP_FILE)
TF_INFLUXDB_BIN := $(TF_PLUG_DIR)/$(TF_INFLUXDB_BIN_FILE)
TF_INFLUXDB_URL := https://github.com/lsst-sqre/terraform-provider-influxdb/releases/download/$(TF_INFLUXDB_VER)/$(TF_INFLUXDB_ZIP_FILE)

.PHONY: all
all: $(TF_INFLUXDB_BIN)

$(TF_INFLUXDB_BIN): | $(TF_INFLUXDB_ZIP_DL)
	unzip -j $(TF_INFLUXDB_ZIP_DL) $(TF_INFLUXDB_BIN_FILE) -d $(TF_PLUG_DIR)

$(TF_INFLUXDB_ZIP_DL): | $(DL_DIR) $(TF_PLUG_DIR)
	wget $(TF_INFLUXDB_URL) -O $@

$(DL_DIR) $(TF_PLUG_DIR):
	mkdir -p $@

.PHONY: clean
clean:
	rm -rf $(DL_DIR)
	rm -rf $(TF_INFLUXDB_BIN)
