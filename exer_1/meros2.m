function m = meros2(val)
  
  % load image
  F = imread("cameraman.tif");
  
  % get rows and columns
  [x y]=size(F);
  
  subplot(2, 2, 1);
  imshow(F,[]);
  title("BEFORE");
  %imagesc(F);
  %colormap(gray);
  
  % dct of the image
  D = dct2(F);
  
  %counter for the 0s
  zeros=0;
  
  % make F(u, v)| < given val --> 0
  for i=1:x
    for j=1:y
        if abs(D(i,j))<val
           D(i,j)=0;
           zeros = zeros + 1;
        end
    end
  end
  % print number of zeros
  zeros 
  
  %get idct2
  Rev = idct2(D);
  
  %convert image to uint8
  U = uint8(Rev);
  
  %print the converted image
  subplot(2, 2, 2);
  imshow(U,[]);
  title("AFTER");

  beforeImg = double(F);  
  afterImg = double(U); 
  myError = (beforeImg - afterImg).^2;
  
  subplot(2, 2, 3);
  imshow(myError,[]);
  title("ERROR");
  
   
  %calculate mse
  myMse=sum(sum(myError))/(x*y);
  
  %calculate and print psnr
  myPsnr=10*log10(255^2/myMse)
  


endfunction
