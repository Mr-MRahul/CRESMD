1;
%source('my_fspecial_gaussian.m');
1;
function my_fspecial_gaussian(filter_xsize, sigxma)
  filter_xsize = 21
  % Create a Gaussian filter of size filter_size x filter_size with standard deviation sigma
  x = -floor(filter_xsize / 2):floor(filter_xsize / 2);
  y = x;
  [X, Y] = meshgrid(x, y);
  gauss_filter = exp(-(X.^2 + Y.^2) / (2*sigxma^2));
  gauss_filter = gauss_filter ./ sum(gauss_filter(:));
end

function generate_mod_LR_bic()


% put test data here
input_path = '../../datasets/input';
save_LR_root = '../../datasets/modified_input';

file_type = '.png';

% kernel
kernel_list = [0, 1, 4];
kernel_label_list = kernel_list*10;

% noise
noise_list = [0, 15, 50];
noise_label_list = noise_list;

for k_ind = 1:length(kernel_list)
    kernelwidth = kernel_list(k_ind);
    kernel_label = kernel_label_list(k_ind);
    if kernel_label > 0
        kernel = my_fspecial_gaussian(21, kernelwidth);
    end 

    for s_ind = 1:length(noise_list)
        noiseSigma = noise_list(s_ind);
        noise_label = noise_label_list(s_ind);

        save_LR_path = fullfile(save_LR_root, ['blur' num2str(kernel_label) '_noise' num2str(noise_label)]);

        if exist('save_LR_path', 'var')
            if exist(save_LR_path, 'dir')
                disp(['It will cover ', save_LR_path]);
            else
                mkdir(save_LR_path);
            end
        end

        randn('seed', 0);

        idx = 0;
        filepaths = dir(fullfile(input_path,'*.*'));
        for i = 1 : length(filepaths)
            % randn('seed', 0);
            [paths,imname,ext] = fileparts(filepaths(i).name);
            if isempty(imname)
                disp('Ignore . folder.');
            elseif strcmp(imname, '.')
                disp('Ignore .. folder.');
            else
                idx = idx + 1;
                str_rlt = sprintf('%d\t%s.\n', idx, imname);
                fprintf(str_rlt);

                % read image
                img = im2double(imread(fullfile(input_path, [imname, ext])));

                % add blur
                if kernel_label > 0
                    blurry_img = imfilter(img, kernel, 'replicate');
                else
                    blurry_img = img;
                end

                % add noise
                if noise_label > 0
                    noise = noiseSigma/255.*randn(size(blurry_img));
                    im_noise = blurry_img + noise;
                    im_noise = im2uint8(im_noise);
                else
                    im_noise = blurry_img;
                end

                if exist('save_LR_path', 'var')
                    imwrite(im_noise, fullfile(save_LR_path, [imname '_' num2str(kernel_label, '%02d') num2str(noise_label, '%02d') file_type]));
                end
            end
        end
    end
end
end
