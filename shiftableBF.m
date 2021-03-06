function [ outImg , param ]  =  shiftableBF(inImg, sigma1, sigma2, w, tol)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Filtering operation
%
%  inImg      :  grayscale image
%  sigma1     : width of spatial Gaussian
%  sigma2     : width of range Gaussian
%  [-w, w]^2  : domain of spatial Gaussian
%  tol        : truncation error
%
%  Author: Kunal N. Chaudhury
%  Date:   March 1, 2012
%
%  Ref:  K.N. Chaudhury, D. Sage, and M. Unser, "Fast O(1) bilateral
%  filtering using trigonometric range kernels," IEEE Trans. Image Proc.,
%  vol. 20, no. 11, 2011.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% create spatial Gaussian filter
filt     = fspecial('gaussian', [w w], sigma1);

% set range interval and the order of raised cosine
T  =  maxFilter(inImg, w);
N  =  ceil( 0.405 * (T / sigma2)^2 );

gamma    =  1 / (sqrt(N) * sigma2);
twoN     =  2^N;

% compute truncation 
if sigma2 > 40
    M = 0;
elseif sigma2 > 10
    sumCoeffs = 0;
    for k = 0 : round(N/2)
        sumCoeffs = sumCoeffs + nchoosek(N,k)/twoN;
        if sumCoeffs > tol/2
            M = k;
            break;
        end
    end
else
    M = ceil( 0.5 * ( N - sqrt(4*N*log(2/tol)) ) );
end

% main filter

[m, n]   =  size(inImg);
outImg1  =  zeros(m, n);
outImg2  =  zeros(m, n);
outImg   =  zeros(m, n);

h = waitbar(0, 'Computing filter ...'); 

warning('off'); %#ok<WNOFF>

parfor k = M : N - M
    
    waitbar(k / N - 2*M + 1, h);
    
    coeff = nchoosek(N,k) / twoN;
    
    temp1  = cos( (2*k - N) * gamma * inImg);
    temp2  = sin( (2*k - N) * gamma * inImg);
    
    phi1 =  imfilter(inImg .* temp1, filt);
    phi2 =  imfilter(inImg .* temp2, filt);
    phi3 =  imfilter(temp1, filt);
    phi4 =  imfilter(temp2, filt);
    
    outImg1 = outImg1 + coeff * ( temp1 .* phi1 +  temp2 .* phi2 );
    outImg2 = outImg2 + coeff * ( temp1 .* phi3 +  temp2 .* phi4 );
    
end

close(h);

idx1 = find( outImg2 < 0.0001);
idx2 = find( outImg2 > 0.0001);

outImg( idx1 ) = inImg( idx1 );
outImg( idx2 ) = outImg1( idx2 ) ./ outImg2 (idx2 );

% save parameters
param.T  = T;
param.N  = N;
param.M  = M;

