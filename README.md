```
ooooo                                      oooo  oooo              
`888'                                      `888  `888              
 888          .ooooo.   .ooooo.   .oooo.    888   888  oooo    ooo 
 888         d88' `88b d88' `\"Y8 `P  )88b   888   888   `88.  .8'
 888         888   888 888        .oP\"888   888   888    `88..8'
 888       o 888   888 888   .o8 d8(  888   888   888     `888'
o888ooooood8 `Y8bod8P' `Y8bod8P' `Y888\"\"8o o888o o888o     .8'
                                                       .o..P'
                                                       `Y8P'
```

# WordPress on Locally (App Service + MySQL)

This example shows how to deploy WordPress on App Service, to [Locally Build](https://locally.build).

## Requirements

* [Locally Build](https://locally.build).
* Either [HashiCorp Terraform](https://terraform.io) or [OpenTofu](https://opentofu.org).
* Either [Docker](https://www.docker.com) or [Podman](https://podman.io) (recommended).
* The Locally Plugin for `Microsoft.DBforPostgreSQL` installed (`locally plugin install --name Microsoft.DBforPostgreSQL`).
* The Locally Plugin for `Microsoft.Web` installed (`locally plugin install --name Microsoft.Web`).

## Running the example

First up, we need to ensure Locally is running, which can be launched via:

```bash
locally build
```

With Locally running, in another terminal we can initialise Terraform, which both downloads the providers we need and then configures the modules for use:

```bash
cd environments/locally
terraform init
```

> [!NOTE]
> It's possible to use OpenTofu here by substituting `terraform` for `tofu`.

With Terraform initialised, we can then provision the example by running:

```bash
locally run terraform apply
```

Once you approve the plan and the resources have been deployed, you can view the Wordpress site [using the URL in the outputs](https://locally-demo-wordpress.furnace.locally:5663).

