# Authorized GAB PoC

Reproduces the `SAP/open-ux-tools` `.github/workflows/sonar.yml` shape in a controlled repo:
`workflow_run` -> checkout of the untrusted PR head -> artifact from the untrusted run ->
values piped into `$GITHUB_ENV` -> Sonar scanner invoked with `-D` args and
`sonar-project.properties` taken from untrusted code.

No real secrets are used. SONAR_TOKEN is wired to the ephemeral GITHUB_TOKEN.
