# Rust HTTP Function

# RUSTFLAGS='-C target-feature=+crt-static' cargo build --release --target x86_64-unknown-linux-musl

# Maybe just build it locally and create a docker from it for development
# this should be so much faster

https://github.com/bjorn3/rustc_codegen_cranelift

https://github.com/kolloch/crate2nix
nix-env -i -f https://github.com/kolloch/crate2nix/tarball/master
~/.nix-profile/bin/crate2nix generate
nix-build Cargo.nix -A rootCrate.build
./result/bin/${your_crate_name}


nix-build myfunc/myfunc.nix
docker load < result
docker run -t hello-docker:y74sb4nrhxr975xs7h83izgm8z75x5fc
docker run -t myfunc-docker:7qydnrsy3sq6v6hsxrrqq7ms0grf8lrp

https://nix.dev/tutorials/building-and-running-docker-images

Welcome to your new Rust function project! The boilerplate
[actix](https://actix.rs/) web server is in
[`src/main.rs`](./src/main.rs). It's configured to invoke the `index`
function in [`src/handler.rs`](./src/handler.rs) in response to both
GET and POST requests. You should put your desired behavior inside
that `index` function. In case you need to configure
some resources for your function, you can do that in the [`configure` function](./src/config.rs).

The app will expose three endpoints:

  * `/` Triggers the `index` function, for either GET or POST methods
  * `/health/readiness` The endpoint for a readiness health check
  * `/health/liveness` The endpoint for a liveness health check

You may use any of the available [actix
features](https://actix.rs/docs/) to fulfill the requests at those
endpoints.

## Development

This is a fully self-contained application, so you can develop it as
you would any other Rust application, e.g.

```shell script
cargo build
cargo test
cargo run
```

Once running, the function is available at <http://localhost:8080> and
the health checks are at <http://localhost:8080/health/readiness> and
<http://localhost:8080/health/liveness>. To POST data to the function,
a utility such as `curl` may be used:

```console
curl -d '{"hello": "world"}' \
  -H'content-type: application/json' \
  http://localhost:8080
```

## Deployment

Use `func` to containerize your application, publish it to a registry
and deploy it as a Knative Service in your Kubernetes cluster:

```shell script
func deploy --registry=docker.io/<YOUR_ACCOUNT>
```

You can omit the `--registry` option by setting the `FUNC_REGISTRY`
environment variable. And if you forget, you'll be prompted.

The output from a successful deploy should show the URL for the
service, which you can also get via `func info`, e.g.

```console
curl $(func info -o url)
```

Have fun!
