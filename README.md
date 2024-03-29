# SIRV-based PolSAR dual-domain-filter

## This is a simple Matlab implementation demo of PolSAR dual-domain filter.

* The high-resolution PolSAR image is regarded as the result of amplitude modulation of the fast-changing Gaussian random speckle (contains polarization information) by the slow-changing texture (RCS) in the SIRV model. Inspired by this simple but effective viewpoint, a dual-domain filter is designed, which takes full advantage of the SIRV model to decompose the task of PolSAR speckle suppression into polarimetric domain filtering and texture domain filtering. More details can be referred to the paper:
**Ren et al."SIRV-Based High-Resolution PolSAR Image Speckle Suppression via Dual-Domain Filtering" ,IEEE Trans. Geosci. Remote Sens.**（https://ieeexplore.ieee.org/document/8675755）

* __The PolSAR dual-domain filter is designed and programmed by Yexian Ren. If you have any questions about the algorithm and experimental details, please contact Yexian Ren at  renyexian@foxmail.com.__

---------------------------------------------
Copyright (c) 2018 Yexian Ren
---------------------------------------------

## Remarks
1. The basis of the dual-domain filter is the SIRV model and PWF. The SIRV model is used to model the PolSAR data and the PWF is the key connection between the polarimetric domain filtering and the texture domain filtering. **The dual-domain filter may fail when SIRV model and PWF are physically invalid.**

2. For single-look PolSAR images without multilook, some strong point targets are not filtered in the polarimetric domain filtering program (their normalized coherency matries remain a single-look coherency matrix), because they do not possess the random characteristics of speckle in reality. However, in some subsequent application algorithms, singular matrices may cause miscalculation (such as inversion (A <sup>- 1</sup>) and log-determinant (log(det (A))).           
**The solution is to force at least four pixel samples to participate in the estimation of the normalized coherency matrix. Specific approach: NL_SIRV.m,line 82: Change "index = ind (1);" to "index = ind (1:4);".**

3. The excellent SAR-POTDF method in single-channel SAR despeckling is applied for texture domain filtering. More details can be referred to the paper   
**B. Xu et al. "Patch Ordering based SAR Image Despeckling via Transform-Domain Filtering" IEEE J. Sel. Topics Appl. Earth Observ. Remote Sens., vol. 8, no. 4, pp. 1682–1695, Apr. 2015.**  
**Readers are also encouraged to use some more recent single-channel SAR despeckling methods for texture domain filtering to further improve the result of texture reconstruction.**  

4. The cut-off threshold in polarimetric domain filtering and the ENL (theoretical value is 3*the number of looks of the PolSAR data) in texture domain filtering  play an important role in dual-domain processing. Adjusting these two parameters can often improve the results.

5. The computational load of the dual domain filter is very large. The efficiency of dual-domain filter can be improved by some approximation methods and acceleration techniques in the future, which is a challenging problem in algorithmic and mathematical skills.

Thank you for your reading！

Yexian Ren  
Email: renyexian@foxmail.com  
QQ: 2538715345  


2019-3-29



