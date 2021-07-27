function minMapper (data, info, intermKVStore)
%Working out partially the min value of a block of data
  partMin = min(data.Vibration_sensor_4);
%Add block of data to be passed to the reducer
  add(intermKVStore, 'PartialMin',partMin);
end