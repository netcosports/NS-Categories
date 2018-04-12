lint:
	pod lib lint --private --sources=https://github.com/netcosports/PodsSpecs,master --verbose --allow-warnings

VERSION := $(shell pod ipc spec NSTCategories.podspec | ./scripts/jq .version)
NEW_VERSION := $(shell ./scripts/semver bump patch $(VERSION))

release: lint
	sed -i '' -e "s/\(.*s\.version.*=.*\)\"\(.*\)\"/\1\"${NEW_VERSION}\"/" NSTCategories.podspec
	git commit NSTCategories.podspec -m "Update to version ${NEW_VERSION}"
	git tag ${NEW_VERSION}
	git push --tags origin master
	pod repo add PodsSpecs git@github.com:netcosports/PodsSpecs.git --silent || true
	pod repo push PodsSpecs NSTCategories.podspec --verbose --allow-warnings --sources=https://github.com/netcosports/PodsSpecs,master
