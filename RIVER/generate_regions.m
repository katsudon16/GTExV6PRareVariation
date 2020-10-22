%%%%% Assign relevant directories into your own directories 
dirNames.anno = '../reference';
dirNames.region = '../preprocessing/rvsite';
%%%%%

region_tss.labels = '10k';
region_tss.dist = 1e3*10;
region_tss.fid = fopen(sprintf('%s/region.tss%s.txt',dirNames.region,region_tss.labels),'w');
load(sprintf('%s/annoGTEx.mat',dirNames.anno));

factor = 0;
for g = 1:size(anno.gene_ids,1)
    if anno.chr(g) < 23, % remove X,Y,MT
        switch anno.gene_ids{g,1},
            case '+',
                idx_tss = 1;
            case '-',
                idx_tss = 2;
        end
                
        %for i = 1:length(region_tss.labels)
        %    % chr | start | stop | gencodeidx | geneName | TSS
        %    fprintf(region_tss.fid(i),'%d\t%d\t%d\t%d\t%s\t%d\n',anno.chr(g),max(1,anno.pos(g,idx_tss)-region_tss.dist(i)),anno.pos(g,idx_tss)+region_tss.dist(i),19,anno.gene_ids{g,2},anno.pos(g,idx_tss));
        %end
        fprintf(region_tss.fid(1),'%d\t%d\t%d\t%d\t%s\t%d\n',anno.chr(g),max(1,anno.pos(g,idx_tss)-region_tss.dist(1)),anno.pos(g,idx_tss)+region_tss.dist(1),19,anno.gene_ids{g,2},anno.pos(g,idx_tss));
    else
        continue
    end
    if floor(g/1000) ~= factor,
        factor = factor + 1;
        disp([' === g: ' num2str(g) ' === ']);
    end
end
fclose(region_tss.fid);

    
                
                
                
    
