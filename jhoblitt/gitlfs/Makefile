UNAME := $(shell uname -s | tr A-Z a-z)
DL_DIR = downloads
ARCH = amd64
TF_PLUG_DIR := terraform.d/plugins/$(UNAME)_$(ARCH)

# the filename in the archive as an extra _x4 suffix
TF_K8S_ZIP_VER = v1.3.0-custom
TF_K8S_BIN_VER = v1.3.0-custom_x4
TF_K8S_ZIP_FILE := terraform-provider-kubernetes_$(TF_K8S_ZIP_VER)_$(UNAME)_$(ARCH).zip
TF_K8S_BIN_FILE := terraform-provider-kubernetes_$(TF_K8S_BIN_VER)
TF_K8S_ZIP_DL := $(DL_DIR)/$(TF_K8S_ZIP_FILE)
TF_K8S_BIN := $(TF_PLUG_DIR)/$(TF_K8S_BIN_FILE)
TF_K8S_URL := https://github.com/sl1pm4t/terraform-provider-kubernetes/releases/download/$(TF_K8S_ZIP_VER)/$(TF_K8S_ZIP_FILE)

.PHONY: all
all: $(TF_K8S_BIN)

$(TF_K8S_BIN): | $(TF_K8S_ZIP_DL)
	unzip -j $(TF_K8S_ZIP_DL) $(TF_K8S_BIN_FILE) -d $(TF_PLUG_DIR)

$(TF_K8S_ZIP_DL): | $(DL_DIR) $(TF_PLUG_DIR)
	wget -nc $(TF_K8S_URL) -O $@

$(DL_DIR) $(TF_PLUG_DIR):
	mkdir -p $@

.PHONY: clean
clean:
	-rm -rf $(TF_K8S_BIN)
