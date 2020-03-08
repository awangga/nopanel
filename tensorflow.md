# Source Compile Tensorflow
Compile tensorflow in old CPU without AVX support

## Windows
Requirements:
1. tensorflow_gpu-2.0.0	
2. python 3.7
3. MSVC 2017
4. Bazel 0.26.1	
5. cuDNN 7.4.2.24
6. CUDA 10.0.130 and replace C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v10.0\bin\cudafe++.exe from CUDA 10.1 update 1(check only to install nvcc)

```sh
git clone https://github.com/tensorflow/tensorflow.git
cd tensorflow
git checkout r2.0
cmd admin:
python configure.py

/arch:SSE4.2
/arch:SSE4
SSE4

bazel build --config=opt --config=cuda --define=no_tensorflow_py_deps=true --copt=-nvcc_options=disable-warnings //tensorflow/tools/pip_package:build_pip_package
```
