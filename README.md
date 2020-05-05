# <img src='https://repository-images.githubusercontent.com/257071695/2dd71b80-8f02-11ea-8730-5b7a886390e2' height='250' alt='Truemail web API client library for Crystal' />

[![CircleCI](https://circleci.com/gh/truemail-rb/truemail-crystal-client/tree/develop.svg?style=svg)](https://circleci.com/gh/truemail-rb/truemail-crystal-client/tree/develop) [![Shard Version](https://img.shields.io/github/v/release/truemail-rb/truemail-crystal-client)](https://github.com/truemail-rb/truemail-crystal-client/releases) [![Gitter](https://badges.gitter.im/truemail-rb/community.svg)](https://gitter.im/truemail-rb/community?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge) [![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-v1.4%20adopted-ff69b4.svg)](CODE_OF_CONDUCT.md)

`truemail-crystal-client` shard - Truemail web API client library for Crystal.

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

Crystal 0.34.0 and upper.

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

All Truemail extensions: https://github.com/truemail-rb

### truemail

gem `truemail` - Configurable plain Ruby email validator, https://github.com/rubygarage/truemail

### truemail server

Lightweight rack based web API wrapper for Truemail, https://github.com/truemail-rb/truemail-rack

### truemail-rack-docker-image

Lightweight rack based web API [dockerized image](https://hub.docker.com/r/truemail/truemail-rack) :whale: of Truemail server, https://github.com/truemail-rb/truemail-rack-docker-image

### truemail-ruby-client

gem `truemail-client` - Truemail web API client library for Ruby, https://github.com/truemail-rb/truemail-ruby-client

### truemail-rspec

gem `truemail-rspec` - Truemail configuration and validator RSpec helpers, https://github.com/truemail-rb/truemail-rspec

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/truemail-rb/truemail-crystal-client. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct. Please check the [open tikets](https://github.com/truemail-rb/truemail-crystal-client/issues). Be shure to follow Contributor Code of Conduct below and our [Contributing Guidelines](CONTRIBUTING.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the `truemail-crystal-client` project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](CODE_OF_CONDUCT.md).

## Credits

- [The Contributors](https://github.com/truemail-rb/truemail-crystal-client/graphs/contributors) for code and awesome suggestions
- [The Stargazers](https://github.com/truemail-rb/truemail-crystal-client/stargazers) for showing their support

## Versioning

`truemail-crystal-client` uses [Semantic Versioning 2.0.0](https://semver.org)
