binary = [0 0 0 0 0 0 0 0 0; 0 0 1 0 0 0 0 1 0;0 0 1 0 0 0 0 1 0;
          0 0 0 0 1 1 0 0 0; 0 0 0 0 0 0 0 0 0;0 0 1 0 0 0 0 1 0;
          0 0 0 1 0 0 1 0 0; 0 0 0 0 1 1 0 0 0;0 0 0 0 0 0 0 0 0];
structuring = [1 0 1; 0 0 0; 0 0 1];
binary2 = zeros(9,9);
%Binary2 = imdilate(Binary,structuring);
for i = 1:9
    for j = 1:9
        if binary(i,j)==1
            binary2(i-1,j-1)=1;
            binary2(i-1,j+1)=1;
            binary2(i+1,j+1)=1;
        end
    end
end

            
