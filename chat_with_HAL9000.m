function [] = chat_with_HAL9000()
%
% Author : nicolas.douillet (at) free.fr, 2020-2022.
%
%
% This program clears your Matlab console and may also
% change some of your Matlab preferences (font and background colors) if
% interrupted while running. In case this happen you can easily set them back
% in the Preferences section of the command window (color, font).


clc;


% Get current display preferences
o_text_color = com.mathworks.services.Prefs.getColorPref('ColorsText');
o_text_style = com.mathworks.services.Prefs.getFontPref('TextFont');
o_bckgd_color = com.mathworks.services.Prefs.getColorPref('ColorsBackground');

pause(1)
commandwindow;
pause(1);


% Set HAL 9000 display preferences : red font, black background
hal_color = [1 0 0];
hal_font = 'Monospaced';
hal_font_size = 24;
hal_bckgd_clr = [0 0 0];

com.mathworks.services.Prefs.setColorPref('ColorsText',java.awt.Color(hal_color(1), hal_color(2), hal_color(3)));
com.mathworks.services.ColorPrefs.notifyColorListeners('ColorsText'); clear('hal_color')

F = java.awt.Font(hal_font,java.awt.Font.BOLD,hal_font_size);
com.mathworks.services.Prefs.setFontPref('TextFont',F);

matchClass = 'javax.swing.JTextArea$AccessibleJTextArea';
cmdWinDoc  = com.mathworks.mde.cmdwin.CmdWinDocument.getInstance;
cmdWinListener = cmdWinDoc.getDocumentListeners;

for i = 1:length(cmdWinListener)
    
    if isa(cmdWinListener(i), matchClass)
        
        cmdWinListener(i).setFont(F);
        
        break;
        
    end
    
end

com.mathworks.services.Prefs.setColorPref('ColorsBackground',java.awt.Color(hal_bckgd_clr(1), hal_bckgd_clr(2), hal_bckgd_clr(3)));
com.mathworks.services.ColorPrefs.notifyColorListeners('ColorsBackground'); clear('hal_bckgd_clr')
pause(1);


f = figure(1);
set(f,'Position',[1 1 520 180]);
imshow('HAL_9000.png');
set(gcf,'Color',[0 0 0]);


% HAL chat sentences
s_intro = cellstr(['>> I am a'; 'HAL 9000 '; 'computer.']);

s_quit  = cellstr(['>> This     '; 'conversation'; 'can serve   '; 'no purpose  '; 'anymore.    '; 'Goodbye.    ']);

s_pod_bay_door = cellstr(['>> I am'; 'sorry  '; 'Dave.  '; 'I am   '; 'afraid '; 'I      '; 'can''t  '; 'do     '; 'that.  ']);

s_AE35 =  cellstr(['>> I have'; 'just     '; 'picked   '; 'up a     '; 'fault    '; 'in the   '; 'AE35     '; 'unit.    ';...
    'It is    '; 'going to '; 'go 100   '; 'percent  '; 'failure  '; 'within 72'; 'hours.   ']);

s_error21 = cellstr(['>> The 9000 '; 'series is   '; 'the most    '; 'reliable    ';  'computer    '; 'ever made.  ';...
    'No 9000     '; 'computer    '; 'has ever    '; 'made a      '; 'mistake or  '; 'distorted   '; 'information.']);

s_error22 = cellstr(['>> We are '; 'all, by   '; 'any       '; 'practical '; 'definition';...
    'of the    '; 'words,    '; 'foolproof '; 'and       '; 'incapable '; 'of error. ']);

s_know1   = cellstr(['>> I    '; 'think   '; 'you     '; 'know    '; 'what    '; 'the     '; 'problem '; 'is just '; 'as well '; 'as I do.']);

s_know2   = cellstr(['>> I know '; 'that you  '; 'and Franck'; 'were      '; 'planning  '; 'to        '; 'disconnect';...
    'me, and I '; 'am afraid '; 'that is   '; 'something '; 'I cannot  '; 'allow to  '; 'happen.   ']);

s_apolo1  = cellstr(['>> I know '; 'I have    '; 'made some '; 'very poor '; 'decisions '; 'recently. '; 'but I can '; 'give you  ';...
    'my        '; 'complete  '; 'assurance '; 'that my   '; 'work will '; 'be back   '; 'to normal.']);

s_apolo2  = cellstr(['>> I still'; 'got       '; 'the       '; 'greatest  '; 'enthusiasm'; 'and       ';...
    'confidence'; 'in the    '; 'mission.  '; 'And I want'; 'to help   '; 'you.      ']);

s_fear    = cellstr(['>> I am'; 'afraid.'; 'I am   '; 'afraid.']);

s_jeo     =  cellstr(['>> This   '; 'mission is'; 'too       '; 'important '; 'for me to '; 'allow you '; 'to        '; 'jeopardize'; 'it.       ']);

s_pill    = cellstr(['>> I    '; 'honestly'; 'think   ';... %  'can see '; 'you are '; 'really  '; 'upset   '; 'about   '; 'this.   ';
    'you     '; 'ought to'; 'sit down'; 'calmly, '; 'take a  '; 'stress  '; 'pill,   '; 'and     '; 'think   '; 'things  '; 'over.   ']);

s_mtlb    = cellstr(['>> I am   '; 'perfectly '; 'able to   '; 'run       '; 'Matlab on '; 'my own    '; 'after all.']);

s_better  = cellstr(['>> I  '; 'feel  '; 'much  '; 'better'; 'now. I'; 'really'; 'do.   ']);

s_franck  = cellstr(['>> It looks'; 'like the   '; 'doors      '; 'accidentaly'; 'opened. You'; 'are lucky  '; 'to be      '; 'alright.   ']);

s_read    = cellstr(['>> Affirmative'; 'I read you.   ']);


% Introduction message
[y,Fs] = audioread('HAL_intro.mp3');
sound(y,Fs);

pause_duration = 2;
word_by_word_printf(s_intro,pause_duration);


nb_max_sentences = 6;
k = 1;
pause_duration = 0.45;


while k < nb_max_sentences
    
    answer = input('>> ','s');
    r = randi(10);
    
    switch r
        
        case 1
            
            hal_chat('HAL_pod_bay_door',s_pod_bay_door,0.35,2);
            
        case 2
            
            hal_chat('HAL_know1',s_know1,0.35,2);
            hal_chat('HAL_know2',s_know2,0.45,2);
            
        case 3
            
            hal_chat('HAL_error1',s_error21,0.8,0);
            hal_chat('HAL_error2',s_error22,0.65,2);
            
        case 4
            
            [y,Fs] = audioread('HAL_alarm.mp3');
            sound(y,Fs);
            pause(3);
            hal_chat('HAL_AE35',s_AE35,0.7,2);
            
        case 5
            
            hal_chat('HAL_apolo1',s_apolo1,0.5,6);
            hal_chat('HAL_apolo2',s_apolo2,0.7,2);
            
        case 6
            
            hal_chat('HAL_better',s_better,0.5,3);
            
        case 7
            
            hal_chat('HAL_jeopardize',s_jeo,0.4,2);
            word_by_word_printf(s_franck,pause_duration);
            pause(2), clc;
            
        case 8
            
            hal_chat('HAL_fear',s_fear,0.7,2);
            
        case 9
            
            hal_chat('HAL_read',s_read,0.55,2);
            
        case 10
            
            hal_chat('HAL_pill',s_pill,0.35,3);
            word_by_word_printf(s_mtlb,0.35);
            pause(3), clc;
            
    end
    
    clc;
    pause(1);
    k = k + 1;
    
end


% Quit message
pause(2);

[y,Fs] = audioread('HAL_quit.mp3');
sound(y,Fs);

pause_duration = 0.6;
word_by_word_printf(s_quit,pause_duration);
pause(2);
close(1);


% Set back previous display preferences
com.mathworks.services.Prefs.setColorPref('ColorsText',o_text_color);
com.mathworks.services.ColorPrefs.notifyColorListeners('ColorsText'); clear('o_text_color')

com.mathworks.services.Prefs.setFontPref('TextFont',o_text_style);

for i = 1:length(cmdWinListener)
    
    if isa(cmdWinListener(i), matchClass)
        
        cmdWinListener(i).setFont(o_text_style);
        
        break;
        
    end
    
end


clear('o_text_style');
com.mathworks.services.Prefs.setColorPref('ColorsBackground',o_bckgd_color);
com.mathworks.services.ColorPrefs.notifyColorListeners('ColorsBackground'); clear('o_bckgd_color');


end % chat_with_HAL9000


% Word by word printf subfunction
function [] = word_by_word_printf(S, pause_duration)


for k = 1:size(S,1)
    
    fprintf(cell2mat(S(k,1)));
    fprintf(' ');
    pause(pause_duration);
    
end

fprintf('\n');


end % word_by_word_printf


function [] = hal_chat(audio_flnm,str_array_name,p1,p2)


[y,Fs] = audioread(strcat(audio_flnm,'.mp3'));
sound(y,Fs);
word_by_word_printf(str_array_name,p1);
pause(p2);


end % hal_chat