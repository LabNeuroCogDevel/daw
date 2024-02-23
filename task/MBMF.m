%MBMF Runs the full task.
%This calls the tutorial and the Task
%The MBMF versions are basically the same, except for redundancy removal so
%they can be run without a break in between.
%

SacklerNumber=input('Subject''s Sackler ID? ','s');
try 
    [window choice1 choice2 state money rts1 rts2]=MBMFtutorial(SacklerNumber);
    eval(['save ' [SacklerNumber '_' num2str(now*1000,9)] '_tutorial choice1 choice2 state money rts1 rts2'])

    window =Screen('OpenWindow',0,[0 0 0]);
    [choice1 choice2 state money totalwon rts1 rts2 stim1_ons_sl stim1_ons_ms choice1_ons_sl choice1_ons_ms stim2_ons_sl stim2_ons_ms choice2_ons_sl choice2_ons_ms rew_ons_sl rew_ons_ms name payoff]= MBMFtask(SacklerNumber, window);
    eval(['save ' [SacklerNumber '_' num2str(now*1000,9)] '_task choice1 choice2 state money totalwon rts1 rts2 stim1_ons_sl stim1_ons_ms choice1_ons_sl choice1_ons_ms stim2_ons_sl stim2_ons_ms choice2_ons_sl choice2_ons_ms rew_ons_sl rew_ons_ms name payoff'])
    sca
catch err
    sca
    rethrow(err)
end
