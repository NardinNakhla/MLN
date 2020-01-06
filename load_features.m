fid=fopen('features.csv');
database = textscan(fid,'%s','HeaderLines',1,'Delimiter','\n','CollectOutput',1);
fclose(fid);
