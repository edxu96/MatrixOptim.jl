
## Free Dynamic Programming

Consider the problem of payment of a (study) loan which at the start of the period is 50.000 DKK. Let us focus on the problem for a period of 10 years. We are going to determine the optimal pay back strategy for this loan, i.e. to determine how much we have to pay each year. Assume that the rate of interests is 5% per year (<img src="/examples/dynamic/tex/0fb0a90a27d21e3e7a2beadc23f90e2b.svg?invert_in_darkmode&sanitize=true" align=middle width=61.717981049999985pt height=21.18721440000001pt/>) (and that the loan is credited each year), then the dynamics of the problem can be described by:

<p align="center"><img src="/examples/dynamic/tex/2d5d07e619e1954075306f7ec2e18680.svg?invert_in_darkmode&sanitize=true" align=middle width=235.69902015pt height=16.438356pt/></p>

where <img src="/examples/dynamic/tex/9fc20fb1d3825674c6a279cb0d5ca636.svg?invert_in_darkmode&sanitize=true" align=middle width=14.045887349999989pt height=14.15524440000002pt/> is the actual size of the loan (including interests) and <img src="/examples/dynamic/tex/194516c014804d683d1ab5a74f8c5647.svg?invert_in_darkmode&sanitize=true" align=middle width=14.061172949999989pt height=14.15524440000002pt/> is the annual payment.

On the one hand, we are interested in minimizing the amount we have to pay to the bank. On the other hand, we don't want to pay too much at one time. The objective function, which we might use in the minimization could be

<p align="center"><img src="/examples/dynamic/tex/5a24b641a3f8f17a750e89097bc0df4f.svg?invert_in_darkmode&sanitize=true" align=middle width=244.19174835pt height=47.806078649999996pt/></p>

where <img src="/examples/dynamic/tex/97508462f9677c6712ed4facd82f8fe7.svg?invert_in_darkmode&sanitize=true" align=middle width=46.97476244999999pt height=26.76175259999998pt/>. The weights <img src="/examples/dynamic/tex/89f2e0d2d24bcf44db73aab8fc03252c.svg?invert_in_darkmode&sanitize=true" align=middle width=7.87295519999999pt height=14.15524440000002pt/> and <img src="/examples/dynamic/tex/2ec6e630f199f589a2402fdf3e0289d5.svg?invert_in_darkmode&sanitize=true" align=middle width=8.270567249999992pt height=14.15524440000002pt/> are at our disposal. Let us for a start choose <img src="/examples/dynamic/tex/2739ad0df0f8943bffcfbb357b18bccd.svg?invert_in_darkmode&sanitize=true" align=middle width=37.71869144999999pt height=14.15524440000002pt/> and <img src="/examples/dynamic/tex/c2c49e1d7381be624319ea37c3129da2.svg?invert_in_darkmode&sanitize=true" align=middle width=38.11630349999999pt height=14.15524440000002pt/> (but let the parameters be variable in your program in order to change them easily).

### Solution

<p align="center"><img src="/examples/dynamic/tex/81c20079db702e373cfd6005d03ae3eb.svg?invert_in_darkmode&sanitize=true" align=middle width=181.3731051pt height=120.93929924999999pt/></p>

The Hamiltonian function of the problem is:

<p align="center"><img src="/examples/dynamic/tex/570a67e6efed9d5f3186cc7c66ec0c26.svg?invert_in_darkmode&sanitize=true" align=middle width=388.86735195pt height=32.990165999999995pt/></p>

The Euler-Lagrange equations can be expressed as:

<p align="center"><img src="/examples/dynamic/tex/8700038f517b51564b85e8038bf29a9d.svg?invert_in_darkmode&sanitize=true" align=middle width=178.87260105pt height=65.47944315pt/></p>
