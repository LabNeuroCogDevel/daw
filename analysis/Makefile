# to disable datalad:
# DATALAD= make txt/luna_habit.csv

.SUFFIXES: # disable built in compile rules
DATALAD ?= datalad run --explicit -o $@  # enable datalad by default

# wrap matlab with try catch
define matlab
	matlab -nodisplay -r "try,$1,catch e, e, end; quit"
endef

all: txt/luna_habit.csv
# completed studies: txt/luna_7tbrainmech.csv txt/luna_pet.csv

txt/luna_habit.csv: $(wildcard /Volumes/L/bea_res/HabitR37/Behavioral' 'Visit/Behavioral' 'Data/1*_2*/1*_task.mat) | txt/
	$(DATALAD) $(call matlab, \
           daw2csv('/Volumes/L/bea_res/HabitR37/Behavioral Visit/Behavioral Data/1*_2*/1*_task.mat','$@');)


## previous studies (data collection ended)
txt/luna_7tbrainmech.csv: $(wildcard /Volumes/L/bea_res/Data/Temporary' 'Raw' 'Data/7T/1*_2*/*_task.mat) | txt/
	$(DATALAD) $(call matlab,\
           daw2csv('/Volumes/L/bea_res/Data/Temporary Raw Data/7T/1*_2*/*_task.mat', '$@');)

txt/luna_pet.csv: $(wildcard  /Volumes/L/bea_res/Data/Temporary' 'Raw' 'Data/PET/1*_2*/*task.mat) | txt/
	$(DATALAD) $(call matlab,\
           daw2csv('/Volumes/L/bea_res/Data/Temporary Raw Data/PET/1*_2*/*task.mat', '$@');)

%/:
	mkdir -p $@
