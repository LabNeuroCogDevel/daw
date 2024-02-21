function [choice1 choice2 state money totalwon rts1 rts2 stim1_ons_sl stim1_ons_ms choice1_ons_sl choice1_ons_ms stim2_ons_sl stim2_ons_ms choice2_ons_sl choice2_ons_ms rew_ons_sl rew_ons_ms name payoff] = MBMFtask(name, w)
%MBMFtask
% sequential choice expt
% ND, October 2006

% 20180329WF - allow task without practice
if ~exist('name','var')
   fprintf('specify subject id like: MBMFtask 10000\n')
   return
end
if ~exist('w','var')
     w=Screen('OpenWindow',0,[0 0 0]);
end

clearvars -except name w


% ptbpath = '/Applications/Psychtoolbox';
% addpath([ptbpath '/PsychBasic']);
% addpath([ptbpath '/PsychOneliners']);
% addpath([ptbpath '/PsychPriority']);
% addpath([ptbpath '/PsychJava']);
% addpath([ptbpath '/PsychAlphaBlending'])
% addpath([ptbpath '/PsychRects'])

HideCursor

% specify the task parameters
global leftpos rightpos boxypos moneyypos moneyxpos animxpos animypos moneytime ...
    isitime ititime choicetime moneypic losepic inmri keyleft keyright...
    starttime ;

totaltrials=200;    %total number of trials in the task
transprob =.7;    % probability of 'correct' transition

[xres,yres] = Screen('windowsize',0);
xcenter = xres/2;
ycenter = yres/2;

leftpos = xcenter-400;
rightpos = xcenter+100;
boxypos = ycenter+50;

moneyypos = ycenter-round(75/2)-200;
moneyxpos = xcenter-round(75/2);

animxpos = 0:50:250;
animypos = 0:50:250;

moneytime = round(1000 / 90);
isitime = round(1000 / 90);
ititime = round(1000 / 90);
choicetime = round(3000 / 90);

numbreaks = 2;

% set break times

b = 0:round(totaltrials/(numbreaks+1)):totaltrials;
b(1) = [];
if totaltrials - b(length(b)) < round(totaltrials/(numbreaks+1))*0.5
    b(length(b)) = [];
end

inmri = 0;  % set to 1 to time everything to slices

keyleft = KbName('1!');%[u]
keyright = KbName('0)');%[i]

numrewardedtrials = round(totaltrials/3);


load behav/masterprob4
    
% create iti jitter matrix, mean 18 slices

jitter = zeros(1,totaltrials);

%set random number generator
rng('shuffle');

starttime = GetSecs*1000;

% Load the figures
[t(1,1).norm, ~, alpha]=imread('behav/rocket1_norm.png');
t(1,1).norm(:,:,4) = alpha(:,:);
[t(1,1).deact, ~, alpha]=imread('behav/rocket1_deact.png');
t(1,1).deact(:,:,4) = alpha(:,:);
[t(1,1).act1, ~, alpha]=imread('behav/rocket1_a1.png');
t(1,1).act1(:,:,4) = alpha(:,:);
[t(1,1).act2, ~, alpha]=imread('behav/rocket1_a2.png');
t(1,1).act2(:,:,4) = alpha(:,:);
[t(1,1).spoiled, ~, alpha]=imread('behav/rocket1_sp.png');
t(1,1).spoiled(:,:,4) = alpha(:,:);

[t(1,2).norm, ~, alpha]=imread('behav/rocket2_norm.png');
t(1,2).norm(:,:,4) = alpha(:,:);
[t(1,2).deact, ~, alpha]=imread('behav/rocket2_deact.png');
t(1,2).deact(:,:,4) = alpha(:,:);
[t(1,2).act1, ~, alpha]=imread('behav/rocket2_a1.png');
t(1,2).act1(:,:,4) = alpha(:,:);
[t(1,2).act2, ~, alpha]=imread('behav/rocket2_a2.png');
t(1,2).act2(:,:,4) = alpha(:,:);
[t(1,2).spoiled, ~, alpha]=imread('behav/rocket2_sp.png');
t(1,2).spoiled(:,:,4) = alpha(:,:);

[t(2,1).norm, ~, alpha]=imread('behav/alien1_norm.png');
t(2,1).norm(:,:,4) = alpha(:,:);
[t(2,1).deact, ~, alpha]=imread('behav/alien1_deact.png');
t(2,1).deact(:,:,4) = alpha(:,:);
[t(2,1).act1, ~, alpha]=imread('behav/alien1_a1.png');
t(2,1).act1(:,:,4) = alpha(:,:);
[t(2,1).act2, ~, alpha]=imread('behav/alien1_a2.png');
t(2,1).act2(:,:,4) = alpha(:,:);
[t(2,1).spoiled, ~, alpha]=imread('behav/alien1_sp.png');
t(2,1).spoiled(:,:,4) = alpha(:,:);    

[t(2,2).norm, ~, alpha]=imread('behav/alien2_norm.png');
t(2,2).norm(:,:,4) = alpha(:,:);
[t(2,2).deact, ~, alpha]=imread('behav/alien2_deact.png');
t(2,2).deact(:,:,4) = alpha(:,:);
[t(2,2).act1, ~, alpha]=imread('behav/alien2_a1.png');
t(2,2).act1(:,:,4) = alpha(:,:);
[t(2,2).act2, ~, alpha]=imread('behav/alien2_a2.png');
t(2,2).act2(:,:,4) = alpha(:,:);
[t(2,2).spoiled, ~, alpha]=imread('behav/alien2_sp.png');
t(2,2).spoiled(:,:,4) = alpha(:,:); 

[t(3,1).norm, ~, alpha]=imread('behav/alien3_norm.png');
t(3,1).norm(:,:,4) = alpha(:,:);
[t(3,1).deact, ~, alpha]=imread('behav/alien3_deact.png');
t(3,1).deact(:,:,4) = alpha(:,:);
[t(3,1).act1, ~, alpha]=imread('behav/alien3_a1.png');
t(3,1).act1(:,:,4) = alpha(:,:);
[t(3,1).act2, ~, alpha]=imread('behav/alien3_a2.png');
t(3,1).act2(:,:,4) = alpha(:,:);
[t(3,1).spoiled, ~, alpha]=imread('behav/alien3_sp.png');
t(3,1).spoiled(:,:,4) = alpha(:,:);    

[t(3,2).norm, ~, alpha]=imread('behav/alien4_norm.png');
t(3,2).norm(:,:,4) = alpha(:,:);
[t(3,2).deact, ~, alpha]=imread('behav/alien4_deact.png');
t(3,2).deact(:,:,4) = alpha(:,:);
[t(3,2).act1, ~, alpha]=imread('behav/alien4_a1.png');
t(3,2).act1(:,:,4) = alpha(:,:);
[t(3,2).act2, ~, alpha]=imread('behav/alien4_a2.png');
t(3,2).act2(:,:,4) = alpha(:,:);
[t(3,2).spoiled, ~, alpha]=imread('behav/alien4_sp.png');
t(3,2).spoiled(:,:,4) = alpha(:,:);

[moneypic, ~, alpha] = imread('behav/t.png');
moneypic(:,:,4) = alpha(:,:); 
[losepic, ~, alpha] = imread('behav/nothing.png');
losepic(:,:,4) = alpha(:,:); 
 
earth = imread('behav/earth.jpg');
planetR = imread('behav/redplanet1.jpg');
planetP = imread('behav/purpleplanet.jpg');


% initialise data vectors

choice1 = zeros(1,totaltrials);         % first level choice
choice2 = zeros(1,totaltrials);         % second level choice
state = zeros(1,totaltrials);           % second level state
rts1 = zeros(1,totaltrials);            % first level RT
rts2 = zeros(1,totaltrials);            % second level RT
money = zeros(1,totaltrials);           % win

stim1_ons_sl = zeros(1,totaltrials);    % onset of first-level stim, slices
stim1_ons_ms = zeros(1,totaltrials);    % onset of first-level stim, ms
stim2_ons_sl = zeros(1,totaltrials);    % onset of second-level stim, slices
stim2_ons_ms = zeros(1,totaltrials);    % onset of second-level stim, ms
choice1_ons_sl = zeros(1,totaltrials);  % onset of first-level choice, slices
choice1_ons_ms = zeros(1,totaltrials);  % onset of first-level choice, ms
choice2_ons_sl = zeros(1,totaltrials);  % onset of second-level choice, slices
choice2_ons_ms = zeros(1,totaltrials);  % onset of second-level choice, ms
rew_ons_sl = zeros(1,totaltrials);      % onset of outcome, slices
rew_ons_ms = zeros(1,totaltrials);      % onset of outcome, ms

% initial wait

%%%%%% The Screen should now be carried over from MBMFtutorial
 Screen('TextFont',w,'Helvetica');
 Screen('TextSize',w,30);
 Screen('TextStyle',w,1);
 Screen('TextColor',w,[255 255 255]);
 wrap = 80;

% convert image arrays to textures
for i = 1:3
    for j = 1:2
        s(i,j).norm = Screen(w,'MakeTexture',t(i,j).norm);
        s(i,j).deact = Screen(w,'MakeTexture',t(i,j).deact);
        s(i,j).act1 = Screen(w,'MakeTexture',t(i,j).act1);
        s(i,j).act2 = Screen(w,'MakeTexture',t(i,j).act2);
        s(i,j).spoiled = Screen(w,'MakeTexture',t(i,j).spoiled);
    end
end

moneypic = Screen(w,'MakeTexture',moneypic);
losepic = Screen(w,'MakeTexture',losepic);
earth = Screen(w,'MakeTexture',earth);
planetR = Screen(w,'MakeTexture',planetR);
planetP = Screen(w,'MakeTexture',planetP);

Screen('BlendFunction', w, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA); %necessary for transparency

% make logfile to be filled in in real time
logfile = fopen([name '_' num2str(now*1000,9) 'logfile-task.txt'], 'a');
fprintf(logfile,'\ntrial choice1   rts1   stim1ons_sl   stim1ons_ms   choice1ons_sl   choice1ons_ms   state   choice2   rts2   stim2ons_sl   stim2ons_ms   choice2ons_sl   choice2ons_ms   won\n');


% % % % main experimental loop % % % %
for trial = 1:totaltrials

Screen('Flip',w);
   
    if find(trial == b) > 0
        
        DrawFormattedText(w, ['Take a break!' '\n\n' 'Press any key to continue when you are ready.'],'center','center');
        Screen('Flip',w);
        KbWait([],2);
        Screen('Flip',w);
        %WaitSecs((ititime*90)/1000)
    end
    
  % first level
    level = 0;
    planetpic = earth; %state 1 planet is earth
    [choice1(trial),rts1(trial),stim1_ons_sl(trial),stim1_ons_ms(trial),choice1_ons_sl(trial),choice1_ons_ms(trial),~,~,~, lastChoice] = ...
  	halftrial(planetpic, s(1,:),w,level);
   
  % record first choice in log
     fprintf(logfile,'\n%d %d %f %f %f %f %f',trial,choice1(trial),rts1(trial),...
      stim1_ons_sl(trial),stim1_ons_ms(trial),choice1_ons_sl(trial),choice1_ons_ms(trial))
  
  if ~choice1(trial) % spoiled
      continue;
  end
  
  

  
   %determine where we transition
  state(trial) = 2 + xor((rand > transprob),(choice1(trial)-1));
  switch (state(trial)) %set planet pic depending on state
      case 2
          planetpic = planetR;
      case 3
          planetpic = planetP;    
  end

  % second level
  level=1;
  [choice2(trial), rts2(trial),stim2_ons_sl(trial),stim2_ons_ms(trial),choice2_ons_sl(trial),choice2_ons_ms(trial),chpos,stimleft,stimright] = ...
  	halftrial(planetpic, s(state(trial),:),w,level, lastChoice);
   
  % record second choice in log
  fprintf(logfile,'\t%d %d %f %f %f %f %f',state(trial),choice2(trial),rts2(trial),...
      stim2_ons_sl(trial),stim2_ons_ms(trial),choice2_ons_sl(trial),choice2_ons_ms(trial))
  
  if ~choice2(trial) % spoiled
      fprintf(logfile,' ')
      continue;
  end
  
  % outcome
  money(trial) = rand < payoff(state(trial)-1,choice2(trial),trial);

  [rew_ons_sl(trial),rew_ons_ms(trial)] = drawoutcome(money(trial),w,chpos,stimleft,stimright);
  
  fprintf(logfile,'\t%d',money(trial))
end

% figure out what they won
totalwon = sum(money);

DrawFormattedText(w,['Nice!  You found ',num2str(totalwon),' pieces of space treasure. \n\n Click any key to close'],'center','center',[],wrap);
Screen('Flip',w);
KbWait([],2);

Screen('Close')
Screen('CloseAll')
ShowCursor
