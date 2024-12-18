# Minimal example of Digital-RF

Working with numpy v2 and 2.6.9 on a base `ubuntu:24.10` or `python:3-bookworm` image.

```bash
docker compose up --build --watch
```

## Changing base image

Both `ubuntu:24.04` and `python:3-slim-bookworm` failed with the following error:

```bash
demo-1  |       [stderr]
demo-1  |       /home/ubuntu/.cache/uv/builds-v0/.tmpAplD3F/lib/python3.13/site-packages/setuptools/_distutils/dist.py:261:
demo-1  |       UserWarning: Unknown distribution option: 'tests_require'
demo-1  |         warnings.warn(msg)
demo-1  |       In file included from lib/py_rf_write_hdf5.c:24:
demo-1  |       /home/ubuntu/.cache/uv/sdists-v6/pypi/digital-rf/2.6.9/9lE1GU3ny0WuTfNuyDXzC/src/include/digital_rf.h:46:10:
demo-1  |       fatal error: hdf5.h: No such file or directory
demo-1  |          46 | #include "hdf5.h"
demo-1  |             |          ^~~~~~~~
demo-1  |       compilation terminated.
demo-1  |       error: command '/usr/bin/cc' failed with exit code 1
demo-1  |
demo-1  |       hint: This error likely indicates that you need to install a library
demo-1  |       that provides "hdf5.h" for `digital-rf@2.6.9`
demo-1  |   help: `digital-rf` (v2.6.9) was included because `drf-tests` (v0.1.0)
demo-1  |         depends on `digital-rf`
```
