<h1 align="center">
Docker Stack Deploy Action
</h1>

GitHub Action used to deploy a Docker stack on a Docker Swarm.

## Configuration options

| GitHub Action Input     | Environment Variable    | Summary                                                                                                               | Required | Default Value |
| ----------------------- | ----------------------- | --------------------------------------------------------------------------------------------------------------------- | -------- | ------------- |
| `remote_host`           | `REMOTE_HOST`           | Hostname or address of the machine running the Docker Swarm manager node                                              | ✅       |               |
| `remote_port`           | `REMOTE_PORT`           | SSH port to connect on the the machine running the Docker Swarm manager node.                                         |          | **22**        |
| `remote_user`           | `REMOTE_USER`           | User with SSH and Docker privileges on the machine running the Docker Swarm manager node.                             | ✅       |               |
| `remote_private_key`    | `REMOTE_PRIVATE_KEY`    | Private key used for ssh authentication.                                                                              | ✅       |               |
| ~~`deploy_timeout`~~    | ~~`DEPLOY_TIMEOUT`~~    | ~~Seconds, to wait until the deploy finishes~~                                                                        |          | ~~**600**~~   |
| `stack_file`            | `STACK_FILE`            | Path to the stack file used in the deploy.                                                                            | ✅       |               |
| `stack_name`            | `STACK_NAME`            | Name of the stack to be deployed.                                                                                     | ✅       |               |
| `stack_param`           | `STACK_PARAM`           | Additional parameter (env var) to be passed to the stack.                                                             |          |               |
| `docker_login_registry` | `DOCKER_LOGIN_REGISTRY` | Registry to use if a `docker login` is required on the remote machine. If this is not provided, no login is performed |          |               |
| `docker_login_username` | `DOCKER_LOGIN_USERNAME` | Username to use if a `docker login` is required on the remote machine.                                                |          |               |
| `docker_login_password` | `DOCKER_LOGIN_PASSWORD` | Password to use if a `docker login` is required on the remote machine.                                                |          |               |
| ~~`env_file`~~          | ~~`ENV_FILE`~~          | ~~Additional environment variables to be passed to the stack.~~                                                       |          |               |
| `debug`                 | `DEBUG`                 | Verbose logging                                                                                                       |          | **0**         |

## Using the GitHub Action

A sample action can be found below to deploy a remote server.

Make sure to setup your [action secrets](https://docs.github.com/en/actions/security-for-github-actions/security-guides/using-secrets-in-github-actions).

### Examples

#### Deploying public images

```yaml
name: Deploy Staging

on:
  push:
    branches: ["main"]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout codebase
        uses: actions/checkout@v4

      - name: Deploy
        uses: jrm402/docker-stack-deploy@latest
        with:
          remote_host: ${{ secrets.REMOTE_HOST }}
          remote_user: ${{ secrets.REMOTE_USER }}
          remote_private_key: ${{ secrets.REMOTE_PRIVATE_KEY }}
          stack_file: "/opt/projects/docker-stack.yml"
          stack_name: "vps-staging"
```

## Test Locally

You can use the docker image locally. Adjust the environment variables in the `Dockerfile.dev` appropriately.

Then run the following commands:

```bash
# Build
# docker build -t docker-stack-deploy .
# Or dev build
docker build -t docker-stack-deploy -f Dockerfile.dev .

# Run
docker run --rm docker-stack-deploy

# Combined commands
docker build -t docker-stack-deploy -f Dockerfile.dev . && docker run --rm docker-stack-deploy
```

## Credits

Originally inspired by [Docker Stack Deploy Tool by kitconect](https://github.com/kitconcept/docker-stack-deploy).

## License

This project is licensed under the [MIT License](/LICENSE).
