all:
	RUSTFLAGS='-C target-feature=+crt-static -C linker=clang -C link-arg=--ld-path=/usr/bin/mold' cargo build --target x86_64-unknown-linux-musl
	DOCKER_BUILDKIT=1 docker build -t myfunc .
	docker run -p 8080:8080/tcp myfunc