```bash

https://github.com/vmware-tanzu/sonobuoy

./sonobuoy run
./sonobuoy status
./sonobuoy logs -f
export outfile=$(./sonobuoy retrieve)
./sonobuoy results $outfile
./sonobuoy delete --wait
