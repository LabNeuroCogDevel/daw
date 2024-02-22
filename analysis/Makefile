.SUFFIXES:

txt/luna_habit.csv: $(wildcard /Volumes/L/bea_res/HabitR37/Behavioral' 'Visit/Behavioral' 'Data/1*_2*/1*_task.mat) | txt/
	datalad run -o $@ matlab -nodisplay -r "try,daw2csv('/Volumes/L/bea_res/HabitR37/Behavioral Visit/Behavioral Data/1*_2*/1*_task.mat','$@'),end;quit"
%/:
	mkdir -p $@
