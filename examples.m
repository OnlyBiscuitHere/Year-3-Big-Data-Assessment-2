function result = examples(data)
%Calculating the number of examples with in the training and test set
normal = nnz(strcmp(data{:,1},"Normal"));
abnormal = nnz(strcmp(data{:,1},"Abnormal"));
result = "Normal: " + normal + " Abnormal: " + abnormal; 
end