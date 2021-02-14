# GitHub Action to synchronise forks using rebase

## Example Workflow file

```yaml
jobs:
  rebase_upstream:
    runs-on: ubuntu-latest
    steps:
      - uses: finbotsdev/actions/git/rebase@main
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          target_repository: finbotsdev/airflow
          target_branch: master
          upstream_repository: apache/airflow
          upstream_branch: master
```

## Inputs

| name                | value  | default  | description                                                                                                                                                                                                                                            |
| ------------------- | ------ | -------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| github_token        | string |          | Token for the repo. Can be passed in using `${{ secrets.GITHUB_TOKEN }}`.                                                                                                                                                                              |
| target_repository   | string |          | Repository name. Default or empty repository name represents current github repository. If you want to push to other repository, you should make a [personal access token](https://github.com/settings/tokens) and use it as the `github_token` input. |
| target_branch       | string | 'master' | Destination branch to push changes.                                                                                                                                                                                                                    |
| upstream_branch     | string | 'master' | Source branch from which changes will be pushed.                                                                                                                                                                                                       |
| upstream_repository | string |          | Repository name. If you want to pull from private repository, you should make a [personal access token](https://github.com/settings/tokens) and use it as the `github_token` input.                                                                    |

## Pull from public repository and push to current repository

GitHub automatically creates a `GITHUB_TOKEN` secret to use in your workflow.
You can use the `GITHUB_TOKEN` to authenticate in a workflow run.
`github_token` input can be passed in as `${{ secrets.GITHUB_TOKEN }}`.
To learn more about this secret check the [official docs](https://docs.github.com/en/actions/configuring-and-managing-workflows/authenticating-with-the-github_token).

## Pull from private repository and/or push to other repository

Create Personal Access Token (PAT) with repo permissions and store it as a secret.
Then it can be passed as in the example below:

```yaml
github_token: ${{ secrets.GH_PERSONAL_ACCESS_TOKEN }}
```

To learn more about creating PAT check the [official docs](https://docs.github.com/en/github/authenticating-to-github/creating-a-personal-access-token).
