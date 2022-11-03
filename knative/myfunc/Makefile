all:
	RUSTFLAGS='-C target-feature=+crt-static -C linker=clang -C link-arg=--ld-path=/usr/bin/mold' cargo build --target x86_64-unknown-linux-musl