.PHONY : build

build:
	docker build . -t rocwind/dev-env
