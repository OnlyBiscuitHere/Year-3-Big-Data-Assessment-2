function result = coeff(data)
%Correlation featuring every feature compared against another feature
for i = 2:13
    for j = 2:13
        disp(data.Properties.VariableNames{i} + " Comparing against " + data.Properties.VariableNames{j})
        result = corrcoef(data{:,i},data{:,j})
    end
end
end