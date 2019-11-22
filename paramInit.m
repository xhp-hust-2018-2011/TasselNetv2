function opt = paramInit
% set for enviromnrt
opt.matconvnet_path = 'D:/matconvnet-1.0-beta22';
opt.vlfeat_path = 'vlfeat-0.9.18';


% set for dataset
opt.dataset = 'data';
opt.sequences = {
    'Henan_Zhengzhou (2012-2013)',
    'Shandong_Taian (2012-2013 Camera 1)'
    };

opt.annotationsdir = 'Annotations';
opt.imagesdir = 'Images';
opt.modeldir = 'model';
opt.resdir='results';


opt.save_time=1;

%save the i_th imdb,named imdb_i
opt.expDir = fullfile('localreg', 'exp');
opt.dataDir = fullfile('localreg', 'data');


opt.localreg.r = 1;
opt.localreg.sigma = 4;
opt.localreg.xsize = 64;