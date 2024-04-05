function gauss_filter = my_fspecial_gaussian(filter_size, sigma)
  % Create a Gaussian filter of size filter_size x filter_size with standard deviation sigma
  x = -floor(filter_size / 2):floor(filter_size / 2);
  y = x;
  [X, Y] = meshgrid(x, y);
  gauss_filter = exp(-(X.^2 + Y.^2) / (2*sigma^2));
  gauss_filter = gauss_filter ./ sum(gauss_filter(:));
end
