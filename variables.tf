variable "namespace" {
  type        = string
  default     = ""
  description = "A name of the existing namespace"
}

variable "module_depends_on" {
  default     = []
  type        = list(any)
  description = "A list of explicit dependencies"
}

variable "chart_version" {
  type        = string
  description = "A Helm Chart version"
  default     = "4.3.0"
}

variable "aws_private" {
  type        = bool
  description = "Set true or false to use private or public infrastructure"
  default     = false
}

variable "argocd" {
  type        = map(string)
  description = "A set of values for enabling deployment through ArgoCD"
  default     = {}
}

variable "conf" {
  type        = map(string)
  description = "A custom configuration for deployment"
  default     = {}
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A tags for attaching to new created AWS resources"
}

variable "internal" {
  type        = bool
  default     = false
  description = "Internal or external mode"
}
