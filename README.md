# `declarative-hydra-example`

An example illustrating declarative hydra projects

# How it works

1. You configure a declarative project in Hydra once with values:
  * **Declarative spec file**: `spec.json`
  * **Declarative input type**: Git checkout, *your git url*
2. Hydra fetches the `spec.json` from your repository.
3. Hydra creates the `.jobsets` jobset in your project, based on `spec.json`
4. Hydra builds the `jobsets` *job* in the `.jobsets` *jobset*
5. Hydra replaces all jobsets in your project by the jobset specifications it has built + the `spec.json` jobset with name `.jobsets`

The last step will be repeated every time the `.jobsets/jobsets` job is done.
