function maxReducer(intermKey, intermValIter, outKVStore)
%Calculating the maximum value from the results of the mapper
  maxVal = -Inf;
  while hasnext(intermValIter)
    maxVal = max(getnext(intermValIter), maxVal);
  end
  add(outKVStore,'Max',maxVal);
end