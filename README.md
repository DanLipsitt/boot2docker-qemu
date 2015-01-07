This is a Docker image that can be used to build a customized boot2docker.iso as described in the [boot2docker docs][boot2docker].

The customized image is set up to allow arm images to be executed using qemu ([more info][armhf-ubuntu-docker]).

To build the iso:

```
docker run --rm danimal/boot2docker-qemu > boot2docker-qemu.iso
```

Then init and start a new boot2docker VM with the iso:

```
boot2docker init --iso="./boot2docker-qemu.iso \
		--vm="boot2docker-qemu-vm"
boot2docker up --vm="boot2docker-qemu-vm"
$(boot2docker --vm=boot2docker-qemu-vm shellinit)
```

You can switch back to your normal boot2docker VM like this:

```
$(boot2docker --vm=boot2docker-vm shellinit)
```

[boot2docker]: https://github.com/boot2docker/boot2docker/blob/master/doc/BUILD.md

[armhf-ubuntu-docker]: https://github.com/djmaze/armhf-ubuntu-docker

