function main(mod_idx)
close all; clc
warning off %#ok<WNOFF>

rng('default')


% init parameters
opt = paramInit;
run(fullfile(opt.vlfeat_path,'toolbox/vl_setup.m'))
run(fullfile(opt.matconvnet_path,'matlab/vl_setupnn.m'))

% generate annotations
opt = genAnnotations(opt);
% - choose model for testing on WSC dataset
model_list = {'TasselNetv2_alex_patch64.mat','TasselNetv2_vgg16_pre.mat'};
opt.model_path = model_list{mod_idx};


% train and test counting methods
[est_cnts, gt_cnts] = hl_localreg(opt);

% parse results
MAE = mean(abs(est_cnts - gt_cnts));
RMSE = sqrt(mean((est_cnts - gt_cnts) .^ 2));

% save results
fprintf('MAE = %3.2f\nRMSE = %3.2f\n', MAE, RMSE);
end
