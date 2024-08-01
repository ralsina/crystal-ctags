all: clean build

build: $(wildcard src/**/*) shard.yml
	shards install
	shards build crystal-ctags -d --error-trace

release: $(wildcard src/**/*) shard.yml
	shards install
	shards build crystal-ctags --release
	strip ./bin/crystal-ctags

clean:
	rm -f ./bin/crystal-ctags

test:
	crystal spec --verbose

spec: test

.PHONY: all build clean test spec
