%
function t = read_daw(mat_file)
% READ_DAW read matfile output of ../MBMFtask.m and create a table
% row per trial. columns: id (repeated), choice1, choice2, state, money
% intended to be used by daw2csv.m
   a=load(mat_file);
   n_trials = length(a.choice1);
   % id likely to be like 12345_yyyymmdd
   % but at least one is missing _date
   % for this reason use cell {} for id instead of raw char
   id_name = num2str(a.name);
   id_col = repmat({id_name}, n_trials, 1);
   t=table(id_col, a.choice1',a.choice2',a.state',a.money');
   t.Properties.VariableNames = {'id' 'choice1' 'choice2' 'state','money'};
end
