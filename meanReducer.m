function meanReducer(intermKey, intermValIter, outKVStore)
%Calculating the mean passed from the mapper function
  count = 0;
  sum = 0;
  while hasnext(intermValIter)
    countSum = getnext(intermValIter);
    count = count + countSum(1);
    sum = sum + countSum(2);
  end
  mean = sum/count;
  add(outKVStore,"MeanV4",mean);
end