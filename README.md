# tf-performance-issue-test

This repository contains a Terraform workspace that exacerbates a performance
issue.

The resources of the real workspace this is based upon have been replaced with
`null_resource` resources that use a harmless `local-exec` provisioner command
to allow for easier investigation of the graph-related performance issues
separate from the provider/cloud interactions.
