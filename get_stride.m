function stride = get_stride(net)
stride = 1;
for li = 1:length(net.layers)
  try
    stride = stride .* net.layers{1,li}.stride;
  catch
    stride = stride;
  end
end

if length(stride)>1
  stride = stride(1);
end

end