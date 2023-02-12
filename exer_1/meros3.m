function m = meros3(val)
 
  % load image
  F = imread("cameraman.tif");
  
  % get rows and columns
  [x y]=size(F);
  
  subplot(2, 2, 1);
  imshow(F,[]);
  title("BEFORE");
  
  % divide image to blocks 8 x 8 and for each block get the dct2
  blockSize = [ 8 8 ];
  dBlock = blockproc(F, blockSize, @dct2); 
  
  %counter for the 0s
  zeros=0;
  
  % make F(u, v)| < given val --> 0
  for i=1:x
    for j=1:y
        if abs(dBlock(i,j))<val
           dBlock(i,j)=0;
           zeros = zeros + 1;
        end
    end
  end
  
  %print number of 0s
  zeros
  
  %get idct2 of each block 
  revBlock= blockproc(dBlock,blockSize,@idct2);
  
  %convert to uint8
  uBlock = blockproc(revBlock,blockSize,@uint8);
  
   
  %print the converted image
  subplot(2, 2, 2);
  imshow(uBlock,[]);
  title("AFTER");
  
  beforeImg = double(F);
  afterImg = double(uBlock);
  myError = (beforeImg - afterImg).^2;
  
  subplot(2, 2, 3);
  imshow(myError,[]);
  title("ERROR");
  
  
   
  %calculate mse
  myMse=sum(sum(myError))/(x*y);
  
  %calculate and print psnr
  myPsnr=10*log10(255^2/myMse)
  


endfunction
