# Environment specific variables

### Action

#### Action options

| Prop                | description                                                                                                                                         |
| ------------------- | --------------------------------------------------------------------- |
| environment_name\*  | Environment name                                                      |
| mode\*              | options: env / output set as output or set it as global env variable  |
\* = required

to extract the branch/tag name you can use the `elseu/sdu-env-specific-variables-action` action.

```yaml
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: elseu/sdu-env-specific-variables-action@v1
        with:
          mode: env
          environment_name: release
        env:
          DEFAULT_DATABASE_URL: "psql://login:test@localhost"
          PRODUCTION_DATABASE_URL: "psql://login:test@localhost"
          RELEASE_DATABASE_URL: "psql://login:test@localhost"
          DEVELOP_DATABASE_URL: "psql://login:test@localhost"
```

#### Variables

You can add environment variables that you want to pass to the deploy script. First it will rename the environment variable based on the defined environment name. So for example when you have as environment name `MASTER` and you have an environment variable defined with `MASTER_DATABASE_URL` that becomes `DATABASE_URL` so that you can define variables based on specific environment.

Those variables can be used based on the mode as output variables or as env variable.

##### Default

If you use DEFAULT as prefix as name when there cannot any match found then DEFAULT_ will be set instead.
