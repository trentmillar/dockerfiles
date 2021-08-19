# Terraform (v1 & v0.14) / Sentinel v0.18 / AZ CLI / + dev tools

Uses,
- CI|CD pipelines to run sentinel tests, terraform commands or AZ CLI commands
- Run interactively (-it) and mount (-v) your sentinal or terraform code
    - `docker run -v /Users/tmillar/dev/repo/my-project:/my-project -w /my-project -it terraform-sentinel-az-tools`
    - `$ sentinel test ./sentinel`

Contains 
- terraform 1.0.4
- terraform 0.14
- sentinel 0.18.4
- azure cli 2.27.0