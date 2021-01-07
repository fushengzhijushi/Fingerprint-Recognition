function [Outputprint,XofCenter,YofCenter] = centralizing(fingerprint,ctrl)


x=[-16:1:16];
y=[-16:1:16];
dimx=size(x,2);
dimy=size(y,2);
% varianza gaussiana, ordine filtro complesso
varianza=sqrt(55);
ordine=1;
gamma=2;
filtro_core=zeros(dimx,dimy);
filtro_delta=zeros(dimx,dimy);
for ii=1:dimx
    for jj=1:dimy
        esponente=exp(-(x(ii)^2+y(jj)^2)/(2*varianza^2));
        % filtro core
        fattore=x(ii)+i*y(jj);
        filtro_core(ii,jj)=esponente*fattore^ordine;
        % filtro delta        
        fattore=x(ii)-i*y(jj);
        filtro_delta(ii,jj)=esponente*fattore^ordine;
    end
end
%--------------------------------------------------------------------------

x=[-16:1:16];
y=[-16:1:16];
dimx=size(x,2);
dimy=size(y,2);
varianza=sqrt(1.2);
filtro=zeros(dimx,dimy);
for ii=1:dimx
    for jj=1:dimy
        esponente=exp(-(x(ii)^2+y(jj)^2)/(2*varianza^2));
        filtro(ii,jj)=esponente;
    end
end
% normalization
filtro=filtro/sum(sum(filtro)); 
%------------------------------------
%------------------------------------
img=fingerprint;
img=double(img);
%--------------------------------------------------------------------------
% complex field at 0 level
[gx,gy]=gradient(img);
num=(gx+i*gy).^2;
den=abs((gx+i*gy).^2);
pos=find(den);
num(pos)=num(pos)./den(pos);
z=zeros(size(img,1),size(img,2));
z(pos)=num(pos);
pos=find(den==0);
z(pos)=1;
%**********************************
%--------------------------------------------------------------------------

if 1==0
    %-------------------------------------
    % complex field at  level 1
    z1=conv2fft(z,filtro,'same');
    z1=dyaddown(z1,1,'m');
    num=z1;
    den=abs(z1);
    pos=find(den);
    num(pos)=num(pos)./den(pos);
    z1=zeros(size(z1,1),size(z1,2));
    z1(pos)=num(pos);
    pos=find(den==0);
    z1(pos)=1;
    
    z2=conv2fft(z1,filtro,'same');
    z2=dyaddown(z2,1,'m');
    num=z2;
    den=abs(z2);
    pos=find(den);
    num(pos)=num(pos)./den(pos);
    z2=zeros(size(z2,1),size(z2,2));
    z2(pos)=num(pos);
    pos=find(den==0);
    z2(pos)=1;
    
    z3=conv2fft(z2,filtro,'same');
    z3=dyaddown(z3,1,'m');
    num=z3;
    den=abs(z3);
    pos=find(den);
    num(pos)=num(pos)./den(pos);
    z3=zeros(size(z3,1),size(z3,2));
    z3(pos)=num(pos);
    pos=find(den==0);
    z3(pos)=1;
    %-------------------------------------
    
    z_f=conv2fft(z,filtro_core,'same');
    z_f=abs(z_f);
    temp0=z_f;%temp0
    %-------------------
    z_1f=conv2fft(z1,filtro_core,'same');
    z_1f=abs(z_1f);
    temp1=z_1f;%temp1
    %-------------------
    z_2f=conv2fft(z2,filtro_core,'same');
    z_2f=abs(z_2f);
    temp2=z_2f;%temp2
    %---------------------
    z_3f=conv2fft(z3,filtro_core,'same');
    z_3f=abs(z_3f);
    temp3=z_3f;%temp3
    %-------------------------------------------------------------------
    
    [massimo_vettore,posizione_vettore]=max(temp3);
    [massimo,posizione]=max(massimo_vettore);
    y_max=posizione;
    x_max=posizione_vettore(posizione);
    massimo;
    
    x0=2*x_max;
    y0=2*y_max;
    
    dx=10;
    dy=10;
    
    posizioni=zeros(size(temp2));
    posizioni(max(1,x0-dx):min(size(temp2,1),x0+dx),max(1,y0-dy):min(size(temp2,2),y0+dy))=1;
    temp2=temp2.*posizioni;
    
    [massimo_vettore,posizione_vettore]=max(temp2);
    [massimo,posizione]=max(massimo_vettore);
    y_max=posizione;
    x_max=posizione_vettore(posizione);
    massimo;
    
    x0=2*x_max;
    y0=2*y_max;
    
    dx=10;
    dy=10;
    
    posizioni=zeros(size(temp1));
    posizioni(max(1,x0-dx):min(size(temp1,1),x0+dx),max(1,y0-dy):min(size(temp1,2),y0+dy))=1;
    temp1=temp1.*posizioni;
    
    [massimo_vettore,posizione_vettore]=max(temp1);
    [massimo,posizione]=max(massimo_vettore);
    y_max=posizione;
    x_max=posizione_vettore(posizione);
    massimo;
    
    x0=2*x_max;
    y0=2*y_max;
    
    dx=5;
    dy=5;
    
    posizioni=zeros(size(temp0));
    posizioni(max(1,x0-dx):min(size(temp0,1),x0+dx),max(1,y0-dy):min(size(temp0,2),y0+dy))=1;
    temp0=temp0.*posizioni;
    
    [massimo_vettore,posizione_vettore]=max(temp0);
    [massimo,posizione]=max(massimo_vettore);
    y_max=posizione;
    x_max=posizione_vettore(posizione);
    massimo;
    
    disp('Coordinate x y');
    disp(x_max);
    disp(y_max);
    
    XofCenter=y_max;
    YofCenter=x_max;
    Outputprint=zeros(50);
end
%--------------------------------------------------------------------------

angle=0;        % angolo rotazione immagine iniziale
bxv=8;          % dimensione blocco varianza
byv=8;
bxc=64;         % dimensione blocco core point
byc=64;
soglia_var=20;  % soglia varianza
dimseclose=10;  % dimensione se operazione closing
dimseerode=44;  % dimensione se operazione erosione
maxcore=200;   % max number of core points calculated during scanning
[dimx,dimy]=size(fingerprint);
%--------------------------------------------------------------------------
temp=z;
[temp,dimxt,dimyt]=mirror(temp);
z_f=conv2fft(temp,filtro_core,'same');
z_f=recrop(z_f,dimxt,dimyt);
z_f=abs(z_f);
%--------------------------------------------

imgd=double(fingerprint);
dimxr=dimx-mod(dimx,bxv);
dimyr=dimy-mod(dimy,byv);
imgr=imgd(1:dimxr,1:dimyr);
%---------------------------
nbx=dimxr/bxv;
nby=dimyr/byv;
mat_var=zeros(dimxr,dimyr);
for ii=1:nbx
    for jj=1:nby
        blocco=imgr((ii-1)*bxv+1:ii*bxv,(jj-1)*byv+1:jj*byv);
        media=sum(sum(blocco))/(bxv*byv);
        varianza=1/(bxv*byv)*sum(sum(abs(media.^2-blocco.^2)));
        mat_var((ii-1)*bxv+1:ii*bxv,(jj-1)*byv+1:jj*byv)=sqrt(varianza);
    end
end
mat_ok=zeros(dimxr,dimyr);
pos=find(mat_var>soglia_var);
mat_ok(pos)=1;
mat_ok(dimx,dimy)=0;


mat_ok=imclose(mat_ok,ones(dimseclose));


mat_ok=imerode(mat_ok,ones(dimseerode));

%--------------------------------------------------------------------------

dimxr=dimx-mod(dimx,bxc);
dimyr=dimy-mod(dimy,byc);
imgr=imgd(1:dimxr,1:dimyr);
matrice_finale=z_f.*mat_ok;

%--------------------------------------------------------------------------
if 1==0
    nbx=dimxr/bxc;
    nby=dimyr/byc;
    mat_core=zeros(maxcore,2);
    cont=1;
    for ii=1:nbx
        for jj=1:nby
            blocco = matrice((ii-1)*bxc+1:ii*bxc,(jj-1)*byc+1:jj*byc);
            [massimo_vettore,posizione_vettore]=max(blocco);
            [massimo,posizione]=max(massimo_vettore);
            y_max=posizione;
            x_max=posizione_vettore(posizione);
            x0=(ii-1)*bxc+1+(x_max-1);
            y0=(jj-1)*byc+1+(y_max-1);
            if massimo>0
                mat_core(cont,1)=x0;
                mat_core(cont,2)=y0;
                cont=cont+1;
            end
        end
    end
    out=mat_core;
end
%--------------------------------------------------------------------------

[massimo_vettore,posizione_vettore]=max(matrice_finale);
[massimo,posizione]=max(massimo_vettore);
y_max=posizione;
x_max=posizione_vettore(posizione);

XofCenter=y_max;
YofCenter=x_max;
Outputprint=zeros(50);
