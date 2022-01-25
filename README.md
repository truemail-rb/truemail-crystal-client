# ![Truemail web API client library for Crystal](https://truemail-rb.org/assets/images/truemail_logo.png)

[![CircleCI](https://circleci.com/gh/truemail-rb/truemail-crystal-client/tree/develop.svg?style=svg)](https://circleci.com/gh/truemail-rb/truemail-crystal-client/tree/develop)
[![Shard Version](https://img.shields.io/github/v/release/truemail-rb/truemail-crystal-client)](https://github.com/truemail-rb/truemail-crystal-client/releases)
[![Gitter](https://badges.gitter.im/truemail-rb/community.svg)](https://gitter.im/truemail-rb/community?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)
[![GitHub](https://img.shields.io/github/license/truemail-rb/truemail-crystal-client)](LICENSE.txt)
[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-v1.4%20adopted-ff69b4.svg)](CODE_OF_CONDUCT.md)

`truemail-crystal-client` shard - Truemail web API client library for Crystal.

> Actual and maintainable documentation :books: for developers is living [here](https://truemail-rb.org/truemail-crystal-client).

## Table of Contents

- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
  - [Creating configuration instance](#creating-configuration-instance)
  - [Establishing connection with Truemail API](#establishing-connection-with-truemail-api)
- [Truemail family](#truemail-family)
- [Contributing](#contributing)
- [License](#license)
- [Code of Conduct](#code-of-conduct)
- [Credits](#credits)
- [Versioning](#versioning)
- [Changelog](CHANGELOG.md)

## Requirements

Crystal 1.3.2+

## Installation

1. Add the dependency to your `shard.yml`:

```yaml
dependencies:
  truemail-client:
    github: truemail-rb/truemail-crystal-client
    branch: master
```

2. Run `shards install`

## Usage

```crystal
require "truemail-client"
```

To have an access for `Truemail::Client` you must create configuration instance first as in the example below:

### Creating configuration instance

```crystal
configuration = Truemail::Client::Configuration.new do |config|
  # Optional parameter (Boolean). By default it is equal false
  config.secure_connection = false

  # Required parameter (String). It should be a hostname or an ip address where Truemail server runs
  config.host = "example.com"

  # Optional parameter (Int32). By default it is equal 9292
  config.port = 80

  # Required parameter (String). It should be valid Truemail server access token
  config.token = "token"
end
```

### Establishing connection with Truemail API

After successful configuration, you can establish connection with Truemail server.

```crystal
Truemail::Client.validate("admin@bestweb.com.ua", configuration)

=>

{
  "date": "2020-05-05 19:30:42 +0200",
  "email": "admin@bestweb.com.ua",
  "validation_type": "smtp",
  "success": true,
  "errors": null,
  "smtp_debug": null,
  "configuration": {
    "validation_type_by_domain": null,
    "whitelist_validation": false,
    "whitelisted_domains": null,
    "blacklisted_domains": null,
    "smtp_safe_check": false,
    "email_pattern": "default gem value",
    "smtp_error_body_pattern": "default gem value"
  }
}
```

`Truemail::Client.validate` always returns JSON data. If something goes wrong you will receive JSON with error details:

```json
{
  "truemail_client_error": "error details"
}
```

---

## Truemail family

All Truemail solutions: https://truemail-rb.org

| Name | Type | Description |
| --- | --- | --- |
| [truemail](https://github.com/truemail-rb/truemail) | ruby gem | Configurable framework agnostic plain Ruby email validator, main core |
| [truemail server](https://github.com/truemail-rb/truemail-rack) | ruby app | Lightweight rack based web API wrapper for Truemail |
| [truemail-rack-docker](https://github.com/truemail-rb/truemail-rack-docker-image) | docker image | Lightweight rack based web API [dockerized image](https://hub.docker.com/r/truemail/truemail-rack) :whale: of Truemail server |
| [truemail-ruby-client](https://github.com/truemail-rb/truemail-ruby-client) | ruby gem | Truemail web API client library for Ruby |
| [truemail-java-client](https://github.com/truemail-rb/truemail-java-client) | java lib | Truemail web API client library for Java |
| [truemail-rspec](https://github.com/truemail-rb/truemail-rspec) | ruby gem | Truemail configuration and validator RSpec helpers |

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/truemail-rb/truemail-crystal-client. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct. Please check the [open tickets](https://github.com/truemail-rb/truemail-crystal-client/issues). Be sure to follow Contributor Code of Conduct below and our [Contributing Guidelines](CONTRIBUTING.md).

## License

The shard is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the `truemail-crystal-client` project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](CODE_OF_CONDUCT.md).

## Credits

- [The Contributors](https://github.com/truemail-rb/truemail-crystal-client/graphs/contributors) for code and awesome suggestions
- [The Stargazers](https://github.com/truemail-rb/truemail-crystal-client/stargazers) for showing their support

## Versioning

`truemail-crystal-client` uses [Semantic Versioning 2.0.0](https://semver.org)
