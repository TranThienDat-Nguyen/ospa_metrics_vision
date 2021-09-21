function ospa2 = ospa2_metric(X,Y,wl,flagGIoU)

if (size(X,1) ~= size(Y,1)) || (size(X,2) ~= size(Y,2))
    error('Dimensions of X and Y are inconsistent');
end
eval_idx = 1:size(X,2);
win_off = (-wl+1):0;

num_x = size(X,3);
num_y = size(Y,3);
num_step = size(X,2);
num_eval = length(eval_idx);

distances = zeros(num_x,num_y,num_step);
x_exists = false(num_x,num_step);
y_exists = false(num_y,num_step);

for i = 1:num_step
    % Compute distance between every pair of points
    x = permute(X(:,i,:),[1 3 2]);
    y = permute(Y(:,i,:),[1 3 2]);
    n = size(x,2) ; 
    m = size(y,2) ; 
    xx = repmat(x,[1,m]) ;
    yy = reshape(repmat(y,[n 1]),[size(y,1) n*m]);
    ax = prod(xx(3:4,:)-xx(1:2,:)); % The rectangle areas in X
    ay = prod(yy(3:4,:)-yy(1:2,:)); % The rectangle areas in Y
    xym = min(xx,yy);
    xyM = max(xx,yy);
    Int = zeros(1,size(xx,2));
    ind = all(xyM(1:2,:)<xym(3:4,:));
    Int(1,ind) = prod(xym(3:4,ind)-xyM(1:2,ind));
    Unn = ax+ay-Int;
    IoU = Int./Unn;
    if flagGIoU
        Cc = prod(xyM(3:4,:)-xym(1:2,:));
        GIoU = IoU - ((Cc-Unn)./Cc);
        d = reshape(0.5*(1-GIoU) ,[n m]);
    else
        d = reshape(1-IoU ,[n m]);
    end
    % Compute track existence flags
    x_exists(:,i) = ~isnan(x(1,:));
    y_exists(:,i) = ~isnan(y(1,:));
        
    % Distance between an empty and non-empty state
    one_exists = bsxfun(@xor,x_exists(:,i),y_exists(:,i)');
    d(one_exists) = 1;     
    
    % Find times when neither object exists
    neither_exists = bsxfun(@and,~x_exists(:,i),~y_exists(:,i)');

    % Full window, distance between empty states is zero
    d(neither_exists) = 0;
    
    % Store the distance matrix for this step
    distances(:,:,i) = d;
end
  
% Cap all inter-point distances
% Full window
distances = min(1,distances);

% Compute the OSPA(2) at the final evaluation point
i = num_eval ; 

% Window indices
win_idx = eval_idx(i) + win_off;
idx_val = (win_idx > 0) & (win_idx <= num_step);
win_idx = win_idx(idx_val);

% Compute the matrix of weighted time-averaged
% OSPA distances between tracks
trk_dist = mean(distances(:,:,win_idx),3,'omitnan');
trk_dist(isnan(trk_dist)) = 0;

% Get the number of objects in X and Y that exist
% at any time inside the current window
valid_rows = any(x_exists(:,win_idx),2);
valid_cols = any(y_exists(:,win_idx),2);
m = sum(valid_rows);
n = sum(valid_cols);

% Solve the optimal assignment problem
trk_dist = trk_dist(valid_rows,valid_cols);
if isempty(trk_dist)
  cost = 0;
else
  if m > n
      trk_dist = trk_dist';
  end
  [~,cost] = lapjv(trk_dist);
end
% Compute the OSPA track distances
if max(m,n) == 0
   ospa2 = 0;
else
   ospa2 = (abs(m-n) + cost)/max(m,n);
end
end