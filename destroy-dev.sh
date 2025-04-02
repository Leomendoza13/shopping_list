#!/bin/bash
set -e

cd terraform/env/dev/

terraform destroy -auto-approve

cd setup/

terraform destroy -auto-approve