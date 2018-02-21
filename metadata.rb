maintainer        "swarna ravi"
maintainer_email  "swarnaravistar@gmail.com"
license           "Apache 2.0"
description       "Installs and configures splunk server & forwarder"
version           "0.1.0"

recipe "splunk::server", "Installs and configures splunk server"
recipe "splunk::forwarder", "Installs and configures splunk forwarder"

supports "ubuntu"
supports "debian"
