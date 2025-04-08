<div align="center">

# asdf-samcli [![Build](https://github.com/Toshiyuki-Yamashita/asdf-samcli/actions/workflows/build.yml/badge.svg)](https://github.com/Toshiyuki-Yamashita/asdf-samcli/actions/workflows/build.yml) [![Lint](https://github.com/Toshiyuki-Yamashita/asdf-samcli/actions/workflows/lint.yml/badge.svg)](https://github.com/Toshiyuki-Yamashita/asdf-samcli/actions/workflows/lint.yml)

[samcli](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/what-is-sam.html) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

- `bash`, `curl`, `unzip`, and [POSIX utilities](https://pubs.opengroup.org/onlinepubs/9699919799/idx/utilities.html).

# Install

Plugin:

```shell
asdf plugin add samcli
# or
asdf plugin add samcli https://github.com/Toshiyuki-Yamashita/asdf-samcli.git
```

samcli:

```shell
# Show all installable versions
asdf list-all samcli

# Install specific version
asdf install samcli latest

# Set a version globally (on your ~/.tool-versions file)
asdf set --home  samcli latest

# Now samcli commands are available
sam --version
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Related Repositories

* AWS SAM CLI https://github.com/aws/aws-sam-cli

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/Toshiyuki-Yamashita/asdf-samcli/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Toshiyuki-Yamashita](https://github.com/Toshiyuki-Yamashita/)
