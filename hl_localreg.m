function [est_cnts, gt_cnts] = hl_localreg(opt)

r = opt.localreg.r;
sigma = opt.localreg.sigma;
xsize = opt.localreg.xsize;

% load trained model
model = fullfile(opt.modeldir, opt.model_path);
if exist(model, 'file')
    load(model);
else
    fprintf('No such model!\n');
end


net = vl_simplenn_tidy(net);
% vl_simplenn_display(net);

% deploy network
net = hl_deploy_model(net);
vl_simplenn_display(net);

%move to GPU
net=vl_simplenn_move(net,'gpu');

test_idx = opt.test_idx;
num_test = length(test_idx);
gt_cnts = zeros(1, num_test);
est_cnts = zeros(1, num_test);
  
%return
if ~exist(opt.resdir)
    mkdir(opt.resdir);
end
   
stride = get_stride(net);
im3u = imread(opt.images{test_idx(1)});
im3f = im2single(imresize(im3u, r));
[subim, subrefim] = sampling_subim(im3u, xsize, stride);
[h, w, ~] = size(im3u);
immap = zeros(h, w);
for j = 1:size(subrefim,3)
    immap(subrefim(:, :, j)) = immap(subrefim(:, :, j)) + ones(xsize);
end
immap = ones(h,w,'single')./ (immap + 1e-12)/xsize/xsize;
[t_n, ~] = sampling_subim(immap, xsize, stride);
t_n=sum(sum(t_n,1),2);
t_n=squeeze(t_n);
t_n = gpuArray(t_n);


    for i = 1:num_test
        
        [~,name,~]=fileparts(opt.images{test_idx(i)});
        im3u = imread(opt.images{test_idx(i)});
        
        im3f = im2single(imresize(im3u, r));%divide 255 to 0-1
        im3f = bsxfun(@minus, im3f, net.meta.normalization.rgbMean);
        
        im3f = gpuArray(im3f);
        res = vl_simplenn(net, im3f);
        x = res(end).x;clear res;
        x=squeeze(x);
        x=x';
        x=x(:);
       
        x=x.*t_n;
        x= gather( sum(x(:)) );  
        
        imcounts = x;
            
        gt = load(opt.annotations{test_idx(i)});
        bbs = gt.sub_bnd_box;     
        gtdens = zeros(size(im3f, 1), size(im3f, 2), 'single');
        if ~isempty(bbs)
            dots = round((bbs(:, 1:2) + bbs(:, 3:4) / 2) * r);
            dots=max(1,dots);
            gtdens(sub2ind(size(gtdens), dots(:, 2), dots(:, 1))) = 1;
            gtdens = imfilter(gtdens, fspecial('gaussian', 6 * sigma, sigma));
        end
        
        est_cnts(i) = imcounts;
        gt_cnts(i) = sum(gtdens(:));
        fprintf('fccn: %d/%d est:%.2f  gt:%.2f  est:%.2f\n', i, num_test,est_cnts(i),gt_cnts(i), est_cnts(i)-gt_cnts(i));
    end

    
end

    function [subim, subrefim] = sampling_subim(im, sz,stride)

        [H, W, ~] = size(im);
        x = 1:stride:(W - sz + 1);
        y = 1:stride:(H - sz + 1);
        X = repmat(x, 1, length(y))';
        Y = kron(y, ones(1, length(x)))';
        SZ = sz * ones(length(X), 2) - 1;
        bbs = [X Y SZ];
        
        refim = reshape(1:H*W, H, W);
        
        if ndims(im) == 3,
            subim = zeros(sz, sz, 3, size(bbs, 1), 'single');
        else
            subim = zeros(sz, sz, 1, size(bbs, 1), 'single');
        end
        subrefim = zeros(sz, sz, size(bbs, 1), 'single');
        for j = 1:size(bbs, 1)
            subim(:, :, :, j) = imcrop(im, bbs(j, :));
            subrefim(:, :, j) = imcrop(refim, bbs(j, :));
        end
        
    end
