# Contributing

## Local testing

Run an end-to-end test against the current working tree:

```shell
scripts/test.bash
```

Pass a version and an optional verification command when needed:

```shell
scripts/test.bash 1.140.0 sam --version
```

The script creates an isolated `ASDF_DATA_DIR`, links the current working tree as
the plugin, installs SAM CLI, runs the verification command, and removes the
temporary environment. It does not change your normal asdf installation or any
`.tool-versions` file outside that environment.

Set `ASDF_PLUGIN_DEBUG=1` to enable shell tracing. Set
`ASDF_TEST_KEEP_TEMP=1` to retain the isolated environment for inspection.

## VS Code debugging

Install the recommended extensions and start **Debug end-to-end plugin test**
from the Run and Debug view. The debug configuration enables tracing in the
test harness and plugin hooks and keeps the isolated test environment; its path
is printed when the debug session ends. Use **Debug latest-stable** or
**Debug list-all** to set breakpoints and step through those hooks directly.

The **asdf-samcli: integration test latest**, **asdf-samcli: lint**, and
**asdf-samcli: latest stable** commands are also available from **Run Task**.

Tests are automatically run in GitHub Actions on push and PR.
