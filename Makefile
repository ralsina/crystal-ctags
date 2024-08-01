all: clean build

build: $(wildcard src/**/*)
	shards install
	shards build crystal-ctags

clean:
	rm -f ./bin/crystal-ctags

test:
	crystal spec --verbose

spec: test

.PHONY: all build clean test spec
