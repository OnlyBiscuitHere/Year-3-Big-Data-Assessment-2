function result = Mode(data)
%Calculating the mode of the data
for i = 2:13
    disp(data.Properties.VariableNames{i})
    result = mode(data{:,i})
end
end