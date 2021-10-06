variable "consul" {
  type = object ({

    # Helm Release Name
    release_name = string

    # Kubernetes Namespace where Consul will be deployed
    namespace = string

    # Helm Chart configuration
    helm_chart = object({
      # Version
      version = string
      # Path to yaml file containing the helm values
      values_filepath = string

      # Values to override on yaml file.
      # Example:
      #   Consider you have a values.yaml file with the follwing content:
      #   ```
      #   foo:
      #     bar = null
      #   ```
      #   To override foo you would write in your .tfvars:
      #   ```
      #   consul = {
      #     ...
      #     helm_chart = {
      #       ...
      #       override = {
      #         "foo.bar" = "some value"
      #       }
      #     }
      #   }
      #   ```
      override = map(any)
    })

  })
}
