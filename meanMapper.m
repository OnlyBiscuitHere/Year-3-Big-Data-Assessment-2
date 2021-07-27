function meanMapper (data, info, intermKVStore)
%Checks for NAN values and replaces them with nothing
  data(isnan(data.Vibration_sensor_4),:) = [];
%Stores the length of each block and the sum of the block
  partCountSum = [length(data.Vibration_sensor_4), sum(data.Vibration_sensor_4)];
  add(intermKVStore, "PartialCountSum",partCountSum);
end