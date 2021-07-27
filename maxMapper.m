function maxMapper (data, info, intermKVStore)
%Working out partially the max value of a block of data
  partMax = max(data.Vibration_sensor_4);
%Add block of data to be passed to the reducer
  add(intermKVStore, 'PartialMax',partMax);
end