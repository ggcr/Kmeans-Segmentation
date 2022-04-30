function [clusters, centres] = kmeans(im, array_im, k, limit_it)
    dim = size(array_im,2);
    n = size(array_im,1);

    it = 0;

    rand = randperm(n,k);
    centres = array_im(rand,:);
    
    clusters = zeros(1,n);
    
    stop = false;
    
    clusters_prev = clusters;
    
    tic
    
    while stop == false & it<limit_it
    
        mean_K = zeros(k,dim);
    
        for i = 1:n
            d = zeros(1,k);
            for c=1:k
                d(c) = sqrt((array_im(i,1) - centres(c,1)).^2 + (array_im(i,2) - centres(c,2)).^2 + (array_im(i,3) - centres(c,3)).^2);
            end
            [~, clusterP] = min(d);
            clusters(i) = clusterP;
        end
    
        
        for c=1:k
            mean_K(c,:) = mean(array_im(clusters==c,:));
        end
        centres = mean_K;
        
    
        if clusters == clusters_prev
            stop = true;
        end
    
        clusters_prev = clusters;
    
        it = it + 1;
    
        
    end

    disp(it);
    
end