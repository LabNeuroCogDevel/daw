function [dimChoice] = animatebox(planetpic,stimleft, stimright, pos, unt, window)

global leftpos rightpos boxypos animxpos animypos fposvect

leftposvect = [leftpos boxypos leftpos+300 boxypos+300];
rightposvect = [rightpos boxypos rightpos+300 boxypos+300];

% activate box
  
if pos==1
  Screen('DrawTexture',window,planetpic,[],[]); %draw background planet
  Screen('DrawTexture',window,stimleft.act1,[],leftposvect);
  Screen('DrawTexture',window,stimright.deact,[],rightposvect);
elseif pos==2
  Screen('DrawTexture',window,planetpic,[],[]); %draw background planet
  Screen('DrawTexture',window,stimleft.deact,[],leftposvect);
  Screen('DrawTexture',window,stimright.act1,[],rightposvect);
end
Screen('Flip',window);

% animate box moving into position ( 90ms)
onset = -0.015;
for i =1:6
  xpos = animxpos(i);
  ypos = animypos(i);
 
  %WaitSecs(0.015);
  if pos==1
    Screen('DrawTexture',window,planetpic,[],[]); %draw background planet
    Screen('DrawTexture',window,stimright.deact,[],rightposvect);
    Screen('DrawTexture',window,stimleft.act1,[],leftposvect...
        -[-xpos ypos -xpos ypos]);
  elseif pos==2
    Screen('DrawTexture',window,planetpic,[],[]); %draw background planet
    Screen('DrawTexture',window,stimleft.deact,[],leftposvect);
    Screen('DrawTexture',window,stimright.act1,[],rightposvect...
        -[xpos ypos xpos ypos]);
  end;
  onset = Screen('Flip',window,onset+0.015);
end

fposvect = leftposvect -[-animxpos(6) animypos(6) -animxpos(6) animypos(6)];

% then highlight the chosen box for a further fixed action-outcome time
% highlight is rapidly alternating between 2 highlighted slot images

onset = -0.1;
i = 1;

while slicewrapper < unt
    u = [stimleft.act1 stimleft.act2;stimright.act1 stimright.act2];
    Screen('DrawTexture',window,planetpic,[],[]); %draw background planet
    Screen('DrawTexture',window,u(pos,i),[],fposvect);
    if pos == 1
        Screen('DrawTexture',window,stimright.deact,[],rightposvect);
    elseif pos == 2
        Screen('DrawTexture',window,stimleft.deact,[],leftposvect);
    end
    onset = Screen('Flip',window,onset+0.1);
    
    if i == 1
        i = 2;
    elseif i == 2
        i = 1;
    end
    
    %WaitSecs(0.2)
end

Screen('DrawTexture',window,planetpic,[],[]); %draw background planet

if pos==1
  Screen('DrawTexture',window,stimleft.deact,[],fposvect);
  dimChoice = stimleft.deact;
elseif pos==2
  Screen('DrawTexture',window,stimright.deact,[],fposvect);
  dimChoice = stimright.deact;
end
