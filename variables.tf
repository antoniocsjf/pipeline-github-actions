variable "location" {
  type        = string
  default     = "Brazil South"
  description = "variavel indica a região dos recursos criados"
}

variable "aws_pub_key" {
  type        = string
  description = "Public key para VM na AWS"
}

variable "azure_pub_key" {
  type        = string
  description = "Public key para VM na AZURE"
}
