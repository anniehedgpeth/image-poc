variable "client_id" {
  default = env("ARM_CLIENT_ID")
}

variable "client_secret" {
  default = env("ARM_CLIENT_SECRET")
}

variable "subscription_id" {
  default = env("ARM_SUBSCRIPTION_ID")
}

variable "tenant_id" {
  default = env("ARM_TENANT_ID")
}

source "azure-arm" "basic-example" {
  client_id           = "${var.client_id}"
  client_secret       = "${var.client_secret}"
  subscription_id     = "${var.subscription_id}"
  tenant_id           = "${var.tenant_id}"

  os_type         = "Linux"
  image_publisher = "Canonical"
  image_offer     = "UbuntuServer"
  image_sku       = "18.04-LTS"

  azure_tags = {
    Owner = "TFE:OP"
  }

  location = "Central US"
  vm_size  = "Standard_A2"

  # shared_image_gallery {
  #   subscription        = "${var.subscription_id}"
  #   resource_group      = "ImagePOC-RG"
  #   gallery_name        = "TFEImageGalleryPOC"
  #   image_name          = "BaseTFE"
  #   image_version       = "1.0.0"
  # }

  shared_image_gallery_destination {
    subscription        = "${var.subscription_id}"
    resource_group      = "ImagePOC-RG"
    gallery_name        = "TFEImageGalleryPOC"
    image_name          = "BaseTFE"
    image_version       = "1.0.1"
    replication_regions = ["South Central US"]
  }

  managed_image_name                = "BaseTFE"
  managed_image_resource_group_name = "ImagePOC-RG"

}

build {
  sources = ["sources.azure-arm.basic-example"]

  provisioner "shell" {
    script = "./base_config_setup.sh"
  }
}
# az sig image-definition create --resource-group 'ImagePOC-RG' --gallery-name 'TFEImageGalleryPOC' --gallery-image-definition 'BaseTFE' --publisher Canonical --offer UbuntuServer --sku 18.04-LTS --os-type linux