function opt = genAnnotations(opt)

for i = 1:length(opt.sequences)
  filelist = dir(fullfile(opt.dataset, opt.sequences{i}, opt.imagesdir, '*.jpg'));
  impath = cell(length(filelist), 1);
  annopath = cell(length(filelist), 1);
  for j = 1:length(filelist)
    impath{j} = fullfile(opt.dataset, opt.sequences{i}, opt.imagesdir, filelist(j).name);
    [pathstr, name, ext] = fileparts(impath{j});
    annopath{j} = fullfile(opt.dataset, opt.sequences{i}, opt.annotationsdir, [name '.mat']);
  end
  imseqimages{i} = impath;
  imseqannos{i} = annopath;
end


impath = cat(1, imseqimages{:});
annopath = cat(1, imseqannos{:});
test_idx = 1:length(impath);

opt.images = impath;
opt.annotations = annopath;
opt.test_idx = test_idx;