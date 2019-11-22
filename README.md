# TasselNetv2

This is the repository for TasselNetv2, presented in:

**TasselNetv2: in-field counting of wheat spikes with context-augmented local regression networks**

Haipeng Xiong<sup>1</sup>, [Zhiguo Cao](http://aia.hust.edu.cn/info/1150/3453.htm)<sup>1</sup>, [Hao Lu](https://sites.google.com/site/poppinace/)<sup>1</sup>, Simon Madec<sup>2</sup>,
Liang Liu<sup>1</sup>,  [Chunhua Shen](http://cs.adelaide.edu.au/~chhshen/)<sup>3</sup>

<sup>1</sup>Huazhong University of Science and Technology, China

<sup>2</sup>INRA-EMMAH-CAPTE, 84914 Avignon, France

<sup>3</sup>The University of Adelaide, Australia

## Installation
- [matconvnet-1.0-beta22](http://www.vlfeat.org/matconvnet/) 
- [vlfeat-0.9.18](http://www.vlfeat.org)

## Data
You can download the Wheat Spike Counting (WSC) dataset from:
[Google Drive](https://drive.google.com/file/d/1sJdSLfHsCjsJa0l7kj_ei7KXzvHWCd6Y/view?usp=sharing)

## Model
Pretrained models can be downloaded from:
[Google Drive](https://drive.google.com/file/d/1869_ZrfgPtFgV073Z0QmQlqvJajJQxI4/view?usp=sharing)

## A Quick Demo
1. Download the code, data and model.

2. Organize them into one folder. The final path structure looks like this:
```
-->The whole project
    -->data
    -->model
        -->TasselNetv2_alex_patch64.mat
        -->TasselNetv2_vgg16_pre.mat
    -->vlfeat-0.9.18
    -->main.m
    -->paramInit.m
    -->genAnnotations.m
    -->hl_localreg.m
    -->hl_deploy_model.m
    -->get_stride.m
```


