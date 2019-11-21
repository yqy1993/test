numImagePairs=10;
imageFiles1=cell(numImagePairs,1);
imageFiles2=cell(numImagePairs,1);
imageDir=fullfile(matlabroot,'toolbox','vision','visiondata',...
    'calibration','stereo');
for i=1:numImagePairs
    imageFiles1{i}=fullfile(imageDir,'left',sprintf('left%02d.png',i));
    imageFiles2{i}=fullfile(imageDir,'right',sprintf('right%02d.png',i));
end

images1=cast([],'uint8');
images2=cast([],'uint8');
for i=1:numel(imageFiles1)
    im=imread(imageFiles1{i});
    im(3:700,1247:end,:)=0;
    images1(:,:,:,i)=im;
    im=imread(imageFiles2{i});
    im(1:700,1198:end,:)=0;
    images2(:,:,:,i)=im;
end

[imagePoints,boardSize]=detectCheckerboardPoints(images1,images2);
figure;
imshow(images1(:,:,:,1),'InitialMagnification',50);
hold on;
plot(imagePoints(:,1,1,1),imagePoints(:,2,1,1),'*-g');
title('Successful Checkerboard Detection');

squareSize=108;
worldPoints=generateCheckerboardPoints(boardSize,squareSize);
stereoParams=estimateCameraParameters(imagePoints,worldPoints);

    
