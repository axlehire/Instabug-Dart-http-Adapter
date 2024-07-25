SHELL := /bin/bash

generate:
	fvm flutter pub run build_runner build --delete-conflicting-outputs

publish:
	PUB_HOSTED_URL=http://nexus.gojitsu.com:7777 fvm dart pub publish