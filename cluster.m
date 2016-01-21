function [C2] = cluster(C)

N = size(C);
ncells = N(1);

n=0;
for i=1:ncells,
    for j=i+1:ncells,
        n = n+1;
        pair(n,:) = [i j];
        distance(n) = j-i;
        allcorrs(n) = C(i,j);
    end
end

corrsorted = sort(allcorrs, 'descend');

count = 0;

for d=1:ncells-1,
    % find all pairs with this distance
    in = find(distance == d);
    N = length(in);
    R = rand(1,N);
    [Y,I] = sort(R);
    for i=1:N,
        cell1 = pair(in(I(i)), 1);
        cell2 = pair(in(I(i)), 2);
        count = count + 1;
        C2(cell1, cell2) = corrsorted(count);
    end
end

for i=1:ncells,
    for j=1:i-1,
        C2(i,j) = C2(j,i);
    end
    C2(i,i) = 0;
end