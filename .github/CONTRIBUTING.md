# erinyoung/needles: Contributing Guidelines

Hi there!
Many thanks for taking an interest in improving erinyoung/needles.

## Contribution workflow

If you'd like to write some code for erinyoung/needles, the standard workflow is as follows:

1. Check that there isn't already an issue about your idea in the [erinyoung/needles issues](https://github.com/erinyoung/needles/issues) to avoid duplicating work. If there isn't one already, please create one so that others know you're working on this
2. [Fork](https://help.github.com/en/github/getting-started-with-github/fork-a-repo) the [erinyoung/needles repository](https://github.com/erinyoung/needles) to your GitHub account
3. Make the necessary changes / additions within your forked repository following [Pipeline conventions](#pipeline-contribution-conventions)
4. Use `nf-core pipelines schema build` and add any new parameters to the pipeline JSON schema (requires [nf-core tools](https://github.com/nf-core/tools) >= 1.10).
5. Submit a Pull Request against the `dev` branch and wait for the code to be reviewed and merged

If you're not used to this workflow with git, you can start with some [docs from GitHub](https://help.github.com/en/github/collaborating-with-issues-and-pull-requests) or even their [excellent `git` resources](https://try.github.io/).
