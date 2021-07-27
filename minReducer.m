function minReducer(intermKey, intermValIter, outKVStore)
%Calculating the minimum value from the results of the mapper
  minVal = Inf;
  while hasnext(intermValIter)
    minVal = min(getnext(intermValIter), minVal);
  end
  add(outKVStore,'Min',minVal);
end