mod case "justfiles/case.just"

serve-jupyter:
    pm2 start 'uv run --with=ipython,jupyterlab,matplotlib,seaborn,h5netcdf,netcdf4,scikit-learn,scipy,xarray,numpy,"nbconvert==5.6.1" jupyter lab --notebook-dir="~"' --name=jupyter-generic

run-ipython:
    uv run --with=ipython,scikit-learn,numpy,scipy,xarray ipython

local_port := "11434"
server_port := "11436"
target := "tars"

open-autossh-tunnel:
    pm2 start 'autossh -M 0 -gNC -o "ExitOnForwardFailure=yes" -o "ServerAliveInterval=10" -o "ServerAliveCountMax=3" -L {{local_port}}:localhost:{{server_port}} {{target}}' --name=tunnel-{{local_port}}:{{server_port}}
