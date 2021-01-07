function [out]=recrop(in,dimxt,dimyt)
% recroppping

extx=20;
exty=20;

out=in(extx+1:extx+dimxt,exty+1:exty+dimyt);