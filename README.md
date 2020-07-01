# Bootstrap

This repository holds the code to setup the initial seed project within a GCP organization.
It was used to setup my "personal" organization in Google Cloud as preparation for the
Senacor StreamedCon Presentation.

This repository consists of 2 terraform modules, [bootstrap](./bootstrap) and [organization-repository](./organization-repository).

## Gotchas

You could potentially run the inital bootstrap as well in a pipeline and set required secrets
in Github or the desired Ci/Cd Tool. Nevertheless, since ServiceAccounts in Google are bound to
a project, and there is potentially no project, I used my personal organization admin credentials
to setup the initial project and I didn't want to enter those as Gitlab Actions secrets. Therefore
these terraform scripts were executed on my local machine with my own organization admin credentials.
After this initial one-time setup, everything can be automated. Since this is a one time setup, there won't
be a remote state for these scripts. Nevertheless you could upload the state file later to the created bucket.

## Manual steps

For setting up the automation for new repositories to CloudBuild, you'll need to install the Google Cloud Build application to
the organization with access to all repositories. Since I personally don't want manual steps, I went for Github Actions as my Ci/Cd tool.

## Step-by-step walkthrough

### Pre-requisites

* Terraform version >=  `v0.12.28`. Installation guides and source code can be found [here](https://github.com/hashicorp/terraform).
* Terragrunt version >= `v0.23.0`. Installation guides and source code can be found [here](https://github.com/gruntwork-io/terragrunt).

### GSuite Groups Module

#### SHOULD (2020-06-30)

This module will create the 2 initially needed GSuite groups of organization admins and billing admins, needed by the bootstrap module.
I am using the non-official [GSuite provider](https://github.com/DeviaVir/terraform-provider-gsuite) for this.
With terraform >=0.13 this will get installed automatically. With terraform 0.12.x you'll need to install it yourself.
Installation guide can be found in the repo.

#### IS (2020-06-30)

I was unable to get the code working. It always failed when applying with:

```bash
Error: [ERROR] Error creating group: googleapi: Error 403: Request had insufficient authentication scopes.
More details:
Reason: insufficientPermissions, Message: Insufficient Permission
```

Since I had no time to debug this further, I created the groups manually via the Admin Console of GSuite. Later those
groups can be imported for automated user management. I also opened [this issue](https://github.com/DeviaVir/terraform-provider-gsuite/issues/148) in the provider itself.

### Bootstrap Module

I am mainly using the existing module of the Cloud Foundation Toolkit that Google offers. Namely
[terraform-google-bootstrap](https://github.com/terraform-google-modules/terraform-google-bootstrap).
This will create a seed project, enable all defined API's there, create a service account for future projects and folder
creations and grant this service account the needed rights. Also a state bucket is created that will hold the main part
of the organization setup.

#### Crap

The bootstrap module uses the project-factory under the hood. The project factory in versions `>v8.0.0` comes shipped with the gcloud command
line and for each project, it will update it. Therefore the main part of the process is basically updating the gcloud command line,
that already exists on your machine / the docker image. I've raised an issue there as well in order to update the project factory to the latest
version.

### Organization Module

This module creates the initial github organization setup repository. It also already created template files for Github actions and sets
some required secrets like the Service Account key to use to authenticate against Google Cloud.
This is needed in order to run the source code for the organization-setup within CloudBuild.
