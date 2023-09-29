.PHONY : build

build:
	docker build . -t docker.io/rocwind/dev-env
