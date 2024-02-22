%
function t = read_daw(mat_file)
% READ_DAW read matfile output of ../MBMFtask.m and create a table
% row per trial. columns: id (repeated), choice1, choice2, state, money
% intended to be used by daw2csv.m
   a=load(mat_file);
   n_trials = length(a.choice1);
   id_col = repmat(a.name, n_trials, 1);
   t=table(id_col, a.choice1',a.choice2',a.state',a.money');
   t.Properties.VariableNames = {'id' 'choice1' 'choice2' 'state','money'};
end
