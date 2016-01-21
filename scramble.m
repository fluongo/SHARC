function [C2] = scramble(C)

N = size(C);
ncells = N(1);

n=0;
for i=1:ncells,
    for j=i+1:ncells,
        n = n+1;
        pair(n,:) = [i j];
    end
end

R = rand(1,n);
[Y,I] = sort(R);
newpair = pair(I,:);

for i=1:ncells,
    C2(i,i) = 0;
end

for m=1:n,
    C2(newpair(m,1), newpair(m,2)) = C(pair(m,1), pair(m,2));
    C2(newpair(m,2), newpair(m,1)) = C(pair(m,1), pair(m,2));
end
