%para = 1, unsure = 2, nonpara = 3
function img_total = clf (result)
for m = 1:965
   for n = 1:1024
       n_para = 0;
       n_nonpara = 0;
       n_bg = 0;
       n_unsure = 0;
       for i = 1:7
           if result(m,n,i) == 1
               n_para = n_para+1;
           elseif result(m,n,i) == 3
                   n_nonpara = n_nonpara+1;
           elseif result(m,n,i) < 1
               n_bg = n_bg+1;
           end
       end
       if n_para >= 4
           img_total(m,n) = 1;
       elseif n_nonpara >= 4
           img_total(m,n) = 3;
       elseif n_bg >= 5
           img_total(m,n) = 0;
       else img_total(m,n) = 2;
       end
   end
end
end

