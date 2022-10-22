```bash

https://github.com/vmware-tanzu/sonobuoy

./sonobuoy run
./sonobuoy status
./sonobuoy logs
export outfile=$(./sonobuoy retrieve)
./sonobuoy results $outfile
./sonobuoy delete --wait
