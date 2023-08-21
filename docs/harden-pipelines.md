# Steps to use hardened images in a pipeline

The "Use hardened containers" section of the [container hardening epic](https://github.com/cloud-gov/product/issues/1723) lists the pipelines that need to be updated to use hardened images. Here are the steps to complete each of those issues.

You will need:

1. [Container hardening spreadsheet](https://docs.google.com/spreadsheets/d/1ingzLJtGiosYH0wADDAy7iSlEh49x5na_iaZn_6xfhI/edit#gid=0)

## Planning

1. Find the pipeline in the Git repository the issue references. It will be named `pipeline.yml`. You may need to check the spreadsheet for reference.
1. Make a list of all resource types under `resource_types` and add checkboxes for them to the ticket.
1. Make a list of all built-in resource types used by `resources` in the pipeline, like `s3` and `git`, and add checkboxes for them to the ticket.

## Implementation

1. Add a resource type to the pipeline for `registry-image` that uses our custom `registry-image-resource` image from ECR. It must be the first resource type under the `resource_types` section. This way, it will override the built-in `registry-image` resource type. (See [Resource Types](https://concourse-ci.org/resource-types.html#schema.resource_type), "resource_type schema", "source".)
	* Example code:
		```
		type: registry-image
		  source:
		    aws_access_key_id: ((ecr_aws_key))
		    aws_secret_access_key: ((ecr_aws_secret))
		    repository: registry-image-resource
		    aws_region: us-gov-west-1
		    semver_constraint: ">= 1.0.0"
		```
1. Update each `resource_type` to use our hardened version. See the spreadsheet for details.
	1. Change `type: docker-image` to `type: registry-image`
1. Add a new new `resource_type` for each built-in type and use our custom, hardened images.
