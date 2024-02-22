% 20180910 - WF 
%   read in daw task mat file and create csv file in Hera project directory
% 20240222WF
%  * moved mat parsing code into read_daw.m
%  * into version control w/task files (prev from mMR/PET study code folder)
%  * write combined csv file in matlab instead of in separate R file
%
% in script folder (need read_daw.m) run like:
%  matlab -r "try,daw2csv('path/to/*_task.mat','all_daw.csv'),end;quit"
%
% or in Makefile:
%  all_daw.csv: path/to/*_task.mat
%  	matlab -r "try,daw2csv('path/to/*_task.mat','$@'),end;quit"

function daw_all_visits = daw2csv(mat_glob, outfile,  sdir)
% DAW2CSV combine all daw matfiles in MAT_GLOB into per trail csv file
% returns combined dataframe. *sideffect* writes OUTFILE if given
% colums created by read_daw.m: id (subj_date), choice1, choice1, state, money
%
% ARGUMENTS:
%   mat_glob  file glob (string) wildcard/star path to all mat files
%             like '/Volumes/L/bea_res/Data/Temporary Raw Data/PET/1*_2*/*_task.mat'
%
%   outfile   final output file location to write all trials of all participants
%             if not provided or empty, no file is written
%             **will always overwrite old file when writting**
%
%   sdir      root directory to save individual files like
%             {sdir}/{id}/daw/daw_{id}.csv
%             if not provided, only collapsed large output file written
%             when provided, old files are not overwritten
if nargin < 2, outfile=''; end
if nargin < 3, sdir=''; end

% mat_glob='/Volumes/L/bea_res/Data/Temporary Raw Data/PET/1*_2*/*_task.mat'
daw_all_visits = table();
for mat_file_obj = dir(mat_glob)'
   % from dir struct into path (string)
   mat_file = fullfile(mat_file_obj.folder, mat_file_obj.name);
   if dir(mat_file).bytes <= 0
       warning(mat_file, 'has no data!')
       continue
   end
   try
      daw_idv = read_daw(mat_file);
   catch e
      e,
      warning(mat_file, 'failed to read!')
      continue
   end
   daw_all_visits = [daw_all_visits; daw_idv];

   % write tmp files?
   id_name = daw_idv.id{1};
   idv_out=fullfile(sdir, id_name, 'daw', ['daw_' id_name '.csv']);
   if ~isempty(sdir) && ~exists(idv_out,'file')
      mkdir(fileparts(idv_out));
      writetable(daw_idv, idv_out);
   end
end

if ~isempty(outfile)
   writetable(daw_all_visits, outfile);
end

end

