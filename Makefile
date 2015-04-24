project = boot2docker-qemu
iso_file = $(project).iso

all: $(iso_file)

docker-build: Dockerfile
	docker build -t $(project) .

$(iso_file): docker-build
	docker run --rm $(project) > $@
