function [choice, rt, ons_sl, ons_ms, ch_sl, ch_ms, pos, stimleft,stimright, dimChoice] = halftrial(planetpic,pix,window,level,oldstim)

global leftpos rightpos boxypos choicetime isitime moneytime ititime;

% run half a trial, ie one state

% set up pictures, swapping sides accoridng to swap

stimleft = pix(1);
stimright = pix(2);

Screen('DrawTexture',window,planetpic,[],[]); %draw background planet
if (level==1)
    Screen('DrawTexture',window,oldstim,[],[leftpos+250 boxypos-250 leftpos+300+250 boxypos+300-250]);
end
Screen('DrawTexture',window,stimleft.norm,[],[leftpos boxypos leftpos+300 boxypos+300]);
Screen('DrawTexture',window,stimright.norm,[],[rightpos boxypos rightpos+300 boxypos+300]);

[ons_sl, ons_ms] = slicewrapper;

% wait out ITI or initial slicewait  
if (level == 0)
    [ons_sl, ons_ms] = waitwrapper(ons_sl + ititime);
end

%display boxes, and record the time as t0
t0 = Screen('Flip',window);

% get a keystroke
[pos,t1] = selectbox(ons_sl + choicetime);  

% timed out

if ~pos
  % spoiled trial
  Screen('DrawTexture',window,planetpic,[],[]); %draw background planet
  Screen('DrawTexture',window,stimleft.spoiled,[],[leftpos boxypos leftpos+300 boxypos+300]);
  Screen('DrawTexture',window,stimright.spoiled,[],[rightpos boxypos rightpos+300 boxypos+300]);
  Screen('Flip',window);
  waitwrapper(ons_sl + choicetime + moneytime);

  rt = 0;
  choice = 0;
  ch_sl = 0;
  ch_ms = 0;
  dimChoice=0;
else
  rt = t1 - t0;
  choice = pos;
  [ch_sl, ch_ms] = slicewrapper; % get slice onset times for choice

  % animate the box
  
  dimChoice = animatebox(planetpic,stimleft, stimright, pos, ch_sl + isitime, window);
end
