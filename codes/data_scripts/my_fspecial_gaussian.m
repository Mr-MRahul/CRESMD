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
