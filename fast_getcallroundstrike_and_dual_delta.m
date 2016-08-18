function [y dual_delta]=fast_getcallroundstrike_and_dual_delta(date,expiry,target,vixoptionsprice,rowIndex,columnIndex)
%load('columnIndex.mat')
y=0;
low=0;
up=1000;
for i=1:38
    if target<=columnIndex(i,1)
       strike=columnIndex(i,1);
       price_up=fast_getoptionprice(date,expiry,strike,0,0,vixoptionsprice,rowIndex,columnIndex);
       if price_up>0
          up=strike;
          break
       end
    end
end
for i=38:-1:1
    if target>columnIndex(i,1)
       strike=columnIndex(i,1);
       price_low=fast_getoptionprice(date,expiry,strike,0,0,vixoptionsprice,rowIndex,columnIndex);
       if price_low>0
          low=strike;
          break
       end
    end
end

if (up-target)<=(target-low)
    y=up;
else
    y=low;
end
dual_delta=(price_up(1)-price_low(1))/(up-low);

end