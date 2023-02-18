
variable "name" {
  type        = string
  description = "the name of the application"
}

variable "namespace" {
  type        = string
  description = "the kubernetes namespace"
  default     = "default"
}

variable "deployment_annotations" {
  description = "annotations for deployment"
  type        = map(string)
  default     = null
}

variable "service_annotations" {
  type = map(string)
  default = {}
}

variable "template_annotations" {
  description = "annotations for pod"
  type        = map(string)
  default     = null
}

variable "image" {
  type        = string
  description = "the image to deploy"
}

variable "image_pull_policy" {
  type        = string
  default     = "IfNotPresent"
  description = "kubernetes pull image policy"
}

variable "args" {
  type        = list(string)
  description = "arguments to the entrypoint"
  default     = []
}

variable "command" {
  type        = list(string)
  description = "entrypoint command to execute"
  default     = []
}

variable "env" {
  type        = map(string)
  description = "key value env variables"
  default     = {}
}

variable "env_field" {
  description = "key value env variables"
  default     = {}
}

variable "env_secret" {
  description = "use an existing secret and inject the values into env variables"
  default     = {}
}

variable "resources" {
  description = "set cpu and memory requests and limits"
  default     = {}
}

variable "volume_mount" {
  description = "mount paths from pods to volume"
  default     = []
}

variable "volume_host_path" {
  description = "host path to mount"
  default     = []
}

variable "volume_config_map" {
  type = list(object({
    name        = string
    mode        = string
    volume_name = string
  }))
  description = "mount an existing configmap and mount it as a volume"
  default     = []
}

variable "volume_empty_dir" {
  type    = list(object({ volume_name = string }))
  default = []
}

variable "volume_secret" {
  description = "create volume from secret"
  default     = []
}

variable "tolerations" {
  description = "add pod toleratons"
  default     = []
}

variable "hosts" {
  type = list(object({
    hostname = list(string),
    ip       = string
  }))
  description = "add /etc/hosts records to pods"
  default     = []
}

variable "security_context" {
  description = "securityContext holds pod-level security attributes and common container settings"
  default     = []
}

variable "security_context_capabilities" {
  description = "security context in pod. Only capabilities."
  default     = []
}

variable "security_context_container" {
  description = "security context in pod."
  default     = []
}

variable "labels" {
  description = "add labels to the pods"
  default     = null
  type        = map(string)
}

variable "tty" {
  description = "does the pod need a ttl"
  type        = bool
  default     = true
}

variable "termination_grace_period_seconds" {
  type        = number
  description = "duration in the pod needs to terminate gracefully"
  default     = null
}

variable "service_account_token" {
  type        = bool
  description = "whether a service account token should be automatically mounted"
  default     = true
}

variable "restart_policy" {
  type        = string
  description = "restart policy for all containers"
  default     = "Always"
}

variable "replicas" {
  type        = number
  description = "how many pods"
  default     = 1
}

variable "min_ready_seconds" {
  type        = number
  description = "(Optional) Field that specifies the minimum number of seconds for which a newly created Pod should be ready without any of its containers crashing, for it to be considered available"
  default     = null
}

variable "liveness_probe" {
  description = "liveness probe settings"
  default     = []
}

variable "readiness_probe" {
  description = "readiness probe settings"
  default     = []
}

variable "lifecycle_events" {
  description = "actions should take in response to container lifecycle events"
  default     = []
}

variable "image_pull_secrets" {
  description = "list of pull secrets"
  type        = map(string)
  default     = {}
}

variable "node_selector" {
  description = "node selector for pod"
  type        = map(string)
  default     = null
}

variable "strategy_update" {
  description = "type of deployment strategy"
  default     = "RollingUpdate"
}

variable "rolling_update" {
  description = "rolling update config params"
  default     = []
}

variable "wait_for_rollout" {
  default     = true
  description = "whether to wait for the deployment to finish"
}

variable "prevent_deploy_on_the_same_node" {
  description = "Pod pod_anti_affinity rule, which prevents deploy same pod on one node."
  type        = bool
  default     = false
}

# variable "iam_role" {
#   type = object({
#     create     = bool
#     iam_policy = optional(string)
#   })
# }

variable "service" {
  type = object({
    type   = string
    port   = number
    target = number
  })
  default = {
    port   = 5000
    type   = "NodePort"
    target = 5000
  }
}

variable "ports" {
  type = list(object({
    name           = string
    container_port = number
    service_port   = optional(number)
  }))
  description = "ports to expose"
}

variable "service_type" {
  type    = string
  default = null
}

variable "ingress_rules" {
  type = list(object({
    name        = string
    path        = string
    path_type   = optional(string)
    host        = string
    annotations = optional(map(string))
  }))
  default = []
}

variable "ingress_secret_name" {
  type    = string
  default = null
}

variable "ingress_class_name" {
  type    = string
  default = null
}

variable "init_containers" {
  type    = list(any)
  default = []
}

variable "custom_kubernetes_name" {
  type        = string
  default     = null
  description = "used to avoid any existing conflicts in kubernetes"
}

variable "service_monitor" {
  type = object({
    port     = number
    path     = string
    interval = string
  })
}

variable "prometheus_rules" {
  type = list(object({
    name = string
    expr = string
  }))
  default = []
}
