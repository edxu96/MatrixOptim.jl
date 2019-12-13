echo on

opt=optimset;
opt=optimset(opt,'Display','iter');

z0=[1; 1]; 

[z,val,flag]=fminsearch('fopt',z0,opt)
echo off
