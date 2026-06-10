# FoggyKitchen Instance Group Hello World

Sample static application for OCI DevOps compute instance group deployments.

This repository is intentionally small. It represents an application repository that can be connected to an OCI DevOps external GitHub trigger. A push to the configured branch can start a build pipeline that packages the static site as a binary artifact, and a deployment pipeline can roll that artifact out to private OCI Compute instances behind a public Load Balancer.

## Repository Layout

- `site/`: static web content deployed to `nginx`
- `scripts/install.sh`: install script executed on each target instance by the OCI DevOps deployment specification
- `build_spec.yaml`: OCI DevOps build specification that packages the site and install script into a tarball artifact

## OCI DevOps Flow

```text
GitHub push
  -> OCI DevOps trigger
  -> build pipeline
  -> package static site artifact
  -> deliver artifact
  -> trigger deployment pipeline
  -> rolling deployment to compute instance group
  -> public HTTP access through OCI Load Balancer
```

The build pipeline does not build a container image. For compute instance group deployments, the build output is a binary artifact such as a `tar.gz` archive. The deployment specification downloads that artifact to each target instance and runs the install script through the Compute Instance Run Command plugin.

## Local Packaging Test

```bash
mkdir -p dist
tar -czf dist/foggykitchen-instance-group-hello-world-local.tar.gz site scripts VERSION
tar -tzf dist/foggykitchen-instance-group-hello-world-local.tar.gz
```

## License

Licensed under the **Universal Permissive License (UPL), Version 1.0**.
See [LICENSE](LICENSE) for details.

© 2026 [FoggyKitchen.com](https://foggykitchen.com) - Cloud. Code. Clarity.
