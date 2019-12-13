echo on

z0=[1;1];

opt=optimset;
opt=optimset(opt,'Display','iter');

[z,val,flag]=fsolve('fz',z0,opt)

echo off
