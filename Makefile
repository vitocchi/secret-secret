BASENAME := $(shell basename $(CURDIR))

compile:
	docker run --rm -v "$(CURDIR)":/code \
	--mount type=volume,source="$(BASENAME)_cache",target=/code/target \
	--mount type=volume,source=registry_cache,target=/usr/local/cargo/registry \
	cosmwasm/rust-optimizer:0.10.3

up: 
	docker run -it --rm \
	-p 26657:26657 -p 26656:26656 -p 1317:1317 \
	-v $(CURDIR)/artifacts:/root/code \
	--name secretdev enigmampc/secret-network-sw-dev:v1.0.2

cli:
	docker exec -it secretdev /bin/bash

clean:
	cargo clean
	-rm -f ./contract.wasm ./contract.wasm.gz