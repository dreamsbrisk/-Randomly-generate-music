
C = 60
D = 62
E = 64
F = 65
G = 67
A = 69
B = 71

n = 6654#设置全部种子
MM = C#初始音    60是C大调，修改为62是D大调，

NumOfCycles = choose([3, 4, 5, 6, 7, 8, 9])#设置音一循环有几个音
#调式,自己选择，要完整设置随机调式需要很多if语句，以达到单个调式的效果很麻烦。如果要变化，要在这里加循环

define :MusicC do
  play choose([MM, MM+2, MM+4, MM+5, MM+7, MM+9, MM+11])#C大调
end


CIonian = choose([MM, MM+2, MM+4, MM+5, MM+7, MM+9, MM+11,MM+12])#C大调
CAeolian = choose([MM, MM+2, MM+3, MM+5, MM+7, MM+8, MM+10,MM+12])#C小调
CDorian = choose([MM, MM+2, MM+3, MM+5, MM+7, MM+9, MM+10,MM+12])#多利亚小调
CPhrygian = choose([MM, MM+1, MM+3, MM+5, MM+7, MM+8, MM+10,MM+12])#悲伤
CLydian = choose([MM, MM+2, MM+4, MM+6, MM+7, MM+9, MM+11,MM+12])#梦幻科技滑稽宇宙
CMixolydian = choose([MM, MM+2, MM+4, MM+5, MM+7, MM+9, MM+10,MM+12])#
CLocrian = choose([MM, MM+1, MM+3, MM+5, MM+6, MM+8, MM+10,MM+12])#黑暗
#MusicMode = choose([CIonian, CAeolian, CDorian, CPhrygian, CLydian, CMixolydian, CIonian])#调式选择
MusicMode = CIonian#此时，CIonian是一个数字
MMode = MusicMode#MMode初始化，这是弄主音的
BMode = MMode#ModeM初始化，这是弄Abelti bass的
#我要创建一个函数，来决定下一个音。或者我可以通过和弦来降低不稳定性




with_fx :reverb, mix: 0.7 do
  define :my_player do |num|#定义
    play num
  end
  #未完成，效果好像不是很好，我打算重新写个方法然后弄，通过记事本直接全部替换
  define :music_instrument do#更新低音乐器，应该再加一个low
    use_synth :beep
  end
  define :music_instrument_High do#更新高音乐器
    use_synth :piano
  end
  
  define :chord_player do |root, repeats, intensity|#非常简单做和弦
    repeats.times do
      play chord(root, :minor7), sustain: 0.1, amp: intensity
      sleep 0.5
    end
  end
  
  
  define :terminating do#正终止
    use_synth :piano#设置乐器
    chord_player :g3, 1, 1#{和弦代号}{次数}{力度}
    
    chord_player :c3, 1, 2
    
  end
  
  
  define :katano do#卡农和声进行
    use_synth :piano
    
    in_thread do
      play :E5, sustain: 2, amp: 0.7
      sleep 2
      play :D5, sustain: 2, amp: 0.7
      sleep 2
      play :C5, sustain: 2, amp: 0.7
      sleep 2
      play :B4, sustain: 2, amp: 0.7
      sleep 2
      play :A, sustain: 2, amp: 0.7
      sleep 2
      play :G, sustain: 2, amp: 0.7
      sleep 2
      play :A, sustain: 2, amp: 0.7
      sleep 2
      play :B, sustain: 2, amp: 0.7
      sleep 2
    end
    in_thread do
      play :C, sustain: 2, amp: 0.9
      sleep 2
      play :B3, sustain: 2, amp: 0.9
      sleep 2
      play :A3, sustain: 2, amp: 0.9
      sleep 2
      play :G3, sustain: 2, amp: 0.9
      sleep 2
      play :F3, sustain: 2, amp: 0.9
      sleep 2
      play :E3, sustain: 2, amp: 0.9
      sleep 2
      play :D3, sustain: 2, amp: 0.9
      sleep 2
      play :G3, sustain: 2, amp: 0.9
      sleep 2
    end
    
  end
  
  
  
  define :abelti_bass do#MMode是通过实时检测，可能会有点奇怪？
    use_synth :piano
    play MMode
    sleep 1
    play MMode+7
    sleep 1
    play MMode+16
    sleep 1
    play MMode+7
    sleep 1
  end
  
  
  define :music_c_ionian do#可以之后再定义是哪个调式
    in_thread do
      NumOfCycles.times do#设置该小节有几个音符
        music_instrument#设置乐器
        in_thread do
          MMode = choose([MM, MM+2, MM+4, MM+5, MM+7, MM+9, MM+11])
          play choose([MM, MM+2, MM+4, MM+5, MM+7, MM+9, MM+11])
          sleep choose([0.25, 0.5])
        end
        
      end
      sleep NumOfCycles/2
    end
    NumOfCycles.times do#主音
      music_instrument_High
      play MMode, release: choose([0.5, 0.25])
      sleep choose([0.5, 0.25])
    end
  end
  
  define :music_c_aeolian do#可以之后再定义是哪个调式
    in_thread do
      NumOfCycles.times do#设置该小节有几个音符
        use_synth :beep
        in_thread do
          MMode = choose([MM, MM+2, MM+3, MM+5, MM+7, MM+8, MM+10])
          play MMode, release: choose([0.5, 0.25])
        end
        sleep choose([0.25, 0.5])
      end
      sleep NumOfCycles/2
    end
    NumOfCycles.times do#设置该小节有几个音符
      use_synth :piano
      play MMode, release: choose([0.5, 0.25])
      sleep choose([0.5, 0.25])
    end
    
  end
  
  define :music_c_dorian do#可以之后再定义是哪个调式
    in_thread do
      NumOfCycles.times do#设置该小节有几个音符
        music_instrument#更新乐器
        MMode = choose([MM, MM+2, MM+3, MM+5, MM+7, MM+9, MM+10])
        play MMode, release: choose([0.5, 0.25])
        sleep choose([0.25, 0.5])
      end
      sleep NumOfCycles/2
    end
    NumOfCycles.times do#主音
      music_instrument_High
      play MMode, release: choose([0.5, 0.25])
      sleep choose([0.5, 0.25])
    end
    
  end
  
  define :music_c_phrygian do#可以之后再定义是哪个调式
    in_thread do
      NumOfCycles.times do#设置该小节有几个音符
        use_synth :beep
        in_thread do
          MMode = choose([MM, MM+2, MM+3, MM+5, MM+7, MM+9, MM+10])
          play MMode, release: choose([0.5, 0.25])
        end
        sleep choose([0.25, 0.5])
      end
      sleep NumOfCycles/2
    end
    in_thread do
      use_synth :beep
      play chord(MMode-4, :minor7), release: 2
      sleep 2
    end
    NumOfCycles.times do#设置该小节有几个音符
      use_synth :piano
      play MMode, release: choose([0.5, 0.25])
      sleep choose([0.5, 0.25])
    end
    
  end
  define :music_c_lydian do#可以之后再定义是哪个调式
    in_thread do
      NumOfCycles.times do#设置该小节有几个音符
        use_synth :beep
        in_thread do
          MMode = choose([MM, MM+2, MM+4, MM+6, MM+7, MM+9, MM+11])
          play MMode, release: choose([0.5, 0.25])
        end
        sleep choose([0.25, 0.5])
      end
      sleep NumOfCycles/2
    end
    in_thread do
      use_synth :beep
      play chord(MMode-4, :minor7), release: 2
      sleep 2
    end
    NumOfCycles.times do#设置该小节有几个音符
      use_synth :piano
      play MMode, release: choose([0.5, 0.25])
      sleep choose([0.5, 0.25])
    end
    
  end
  
  define :music_c_mixolydian do#可以之后再定义是哪个调式
    in_thread do
      NumOfCycles.times do#设置该小节有几个音符
        use_synth :beep
        in_thread do
          MMode = choose([MM, MM+2, MM+4, MM+5, MM+7, MM+9, MM+10])
          play MMode, release: choose([0.5, 0.25])
        end
        sleep choose([0.25, 0.5])
      end
      sleep NumOfCycles/2
    end
    in_thread do
      use_synth :beep
      play chord(MMode-4, :minor7), release: 2
      sleep 2
    end
    NumOfCycles.times do#设置该小节有几个音符
      use_synth :piano
      play MMode, release: choose([0.5, 0.25])
      sleep choose([0.5, 0.25])
    end
    
  end
  define :music_c_locrian do#可以之后再定义是哪个调式
    in_thread do
      NumOfCycles.times do#设置该小节有几个音符
        use_synth :beep
        in_thread do
          MMode = choose([MM, MM+1, MM+3, MM+5, MM+6, MM+8, MM+10])
          play MMode, release: choose([0.5, 0.25])
        end
        sleep choose([0.25, 0.5])
      end
      sleep NumOfCycles/2
    end
    in_thread do
      use_synth :beep
      play chord(MMode-4, :minor7), release: 2
      sleep 2
    end
    NumOfCycles.times do#设置该小节有几个音符
      use_synth :piano
      play MMode, release: choose([0.5, 0.25])
      sleep choose([0.5, 0.25])
    end
    
  end
  
  
  
  
  define :musicPaYin do#琶音
    musicPaYinPM = choose([60, 64, 54])
    
    play_pattern_timed chord(musicPaYinPM, :m13), [0.25, 0.5]
  end
  
  define :music101 do#鼓
    4.times do
      with_fx :lpf, cutoff: 100 do
        sample :sn_dub, sustain: 0, release: 0.05, amp: 3
      end
      sleep ring(1, 0.5)[look]
      sample :drum_tom_mid_soft
      
      if one_in(2)
        sleep 0.5
        sample :drum_heavy_kick
      else
        sleep 0.5
        sample :drum_tom_mid_soft
      end
      sleep ring(0.5, 1)[tick]
    end
  end
  
  
  define :music1 do
    in_thread do
      2.times do
        if MusicMode = CIonian
          in_thread do
            NumOfCycles.times do#设置该小节有几个音符
              in_thread do
                MMode = choose([MM, MM+2, MM+4, MM+5, MM+7, MM+9, MM+11])
                
                play choose([MM, MM+2, MM+4, MM+5, MM+7, MM+9, MM+11])
              end
              sleep choose([0.25, 0.5])
            end
            sleep NumOfCycles/2
          end
          in_thread do
            play chord(MMode, :minor7), release: 2
            sleep 2
          end
        else
        end
        if MusicMode = CAeolian
          in_thread do
            NumOfCycles.times do#设置该小节有几个音符
              in_thread do
                MMode = choose([MM, MM+2, MM+3, MM+5, MM+7, MM+8, MM+10])
                play MMode
              end
              sleep choose([0.25, 0.5])
            end
            sleep NumOfCycles/2
          end
          in_thread do
            play chord(MMode, :minor7), release: 2
            sleep 2
          end
        else
        end
        if MusicMode =CDorian
          in_thread do
            NumOfCycles.times do#设置该小节有几个音符
              in_thread do
                MMode = choose([MM, MM+2, MM+3, MM+5, MM+7, MM+9, MM+10])
                play MMode
              end
              sleep choose([0.25, 0.5])
            end
            sleep NumOfCycles/2
          end
          in_thread do
            play chord(MMode, :minor7), release: 2
            sleep 2
          end
        else
        end
        if MusicMode =CPhrygian
          in_thread do
            NumOfCycles.times do#设置该小节有几个音符
              in_thread do
                MMode = choose([MM, MM+1, MM+3, MM+5, MM+7, MM+8, MM+10])
                play MMode
              end
              sleep choose([0.25, 0.5])
            end
            sleep NumOfCycles/2
          end
          in_thread do
            play chord(MMode, :minor7), release: 2
            sleep 2
          end
        else
        end
        if MusicMode =CLydian
          in_thread do
            NumOfCycles.times do#设置该小节有几个音符
              in_thread do
                MMode = choose([MM, MM+2, MM+4, MM+6, MM+7, MM+9, MM+11])
                play MMode
              end
              sleep choose([0.25, 0.5])
            end
            sleep NumOfCycles/2
          end
          in_thread do
            play chord(MMode, :minor7), release: 2
            sleep 2
          end
        else
        end
        if MusicMode =CMixolydian
          in_thread do
            NumOfCycles.times do#设置该小节有几个音符
              in_thread do
                MMode = choose([MM, MM+2, MM+4, MM+5, MM+7, MM+9, MM+10])
                play MMode
              end
              sleep choose([0.25, 0.5])
            end
            sleep NumOfCycles/2
          end
          in_thread do
            play chord(MMode, :minor7), release: 2
            sleep 2
          end
        else
        end
        if MusicMode =CIonian
          in_thread do
            NumOfCycles.times do#设置该小节有几个音符
              in_thread do
                MMode = choose([MM, MM+1, MM+3, MM+5, MM+6, MM+8, MM+10])
                play MMode
              end
              sleep choose([0.25, 0.5])
            end
            sleep NumOfCycles/2
          end
          in_thread do
            play chord(MMode, :minor7), release: 2
            sleep 2
          end
        else
        end
      end
    end
  end
  
end

define :music2 do
  in_thread do
    4.times do
      
      num2 = choose([60, 64, 67])
      num2X = choose([2, 4, 6, -2, -4, -6, 0])
      
      in_thread do
        play choose([num2+num2X]), attack: 0.3, release: 1.7
      end
      in_thread do
        play choose([num2+num2X]), attack: 0.3, release: 1.7
      end
      sleep choose([0.25, 0.5, 1])
    end
  end
end

define :music3 do
  in_thread do
    4.times do
      
      num3 = choose([60, 64, 67])
      num3X = choose([2, 4, 6, -2, -4, -6, 0])
      
      in_thread do
        play choose([num3+num3X]), attack: 0.3
      end
      sleep choose([0.25, 0.5, 1])
    end
  end
end

define :music4 do
  4.times do
    in_thread do
      play choose([60, 64, 67])
    end
    in_thread do
      play choose([71, 64, 67])
    end
    sleep choose([0.25, 0.5, 1])
  end
end

define :music1X2 do
  2.times do
    use_random_seed 12+n#种子序号
    music1
    sleep NumOfCycles/2#四个音是2
  end
  
  2.times do
    use_random_seed 30+n#种子序号
    music2
    sleep 2
  end
end

define :music2X3 do
  in_thread do#第二节
    2.times do
      use_random_seed 6+n#种子序号
      music3
      sleep 2
    end
    2.times do
      use_random_seed 6+n#种子序号
      music3
      sleep 2
    end
  end
  
  in_thread do
    use_synth :hollow
    music1X2
  end
end

define :music5X do
  4.times do
    use_random_seed 12+n#种子序号
    music5
    sleep NumOfCycles/2#四个音是2
  end
end


#切换调式,好像无法套娃定义？
define :music_c_0 do
  2.times do
    use_random_seed 12+n#种子序号
    
    music_c_ionian
    sleep NumOfCycles/4#四个音是2?
    NumOfCycles = choose([3, 4, 5, 6])#更新音一循环有几个音
    BMode = MMode#ModeM初始化，这是弄Abelti bass的
  end
end



define :music_c_1 do
  1.times do
    use_random_seed 24+n#种子序号
    music_c_ionian
    sleep NumOfCycles/4#四个音是2?
    NumOfCycles = choose([3, 4, 5, 6])#更新音一循环有几个音,NumOfCycles是设置音一循环有几个音
    BMode = MMode#这是弄Abelti bass的
    play BMode
    
  end
end
define :music_c_2 do
  2.times do
    use_random_seed 48+n#种子序号
    
    music_c_ionian
    sleep NumOfCycles/4#四个音是2?
    NumOfCycles = choose([3, 4, 5, 6])#更新音一循环有几个音
    BMode = MMode#这是弄Abelti bass的
  end
end

define :music_c_3 do
  2.times do
    use_random_seed 96+n#种子序号
    
    music_c_dorian
    sleep NumOfCycles/4#四个音是2?
    NumOfCycles = choose([3, 4, 5, 6])#更新音一循环有几个音
    BMode = MMode#这是弄Abelti bass的
  end
end
define :music_c_4 do
  2.times do
    use_random_seed 192+n#种子序号
    
    music_c_dorian
    sleep NumOfCycles/4#四个音是2?
    NumOfCycles = choose([3, 4, 5, 6])#更新音一循环有几个音
    BMode = MMode#这是弄Abelti bass的
  end
end



in_thread do
  6.times do
    katano
    sleep 16
  end
end

in_thread do
  music_c_1
  music_c_1
  n = n+1
  music_c_1
  n = n-1
  music_c_1
  define :music_instrument_High do#更新高音乐器
    use_synth :dpulse
  end
  NumOfCycles = choose([3, 4, 5, 6, 7, 8, 9])#更新音一循环有几个音
  music_c_2
  music_c_3
  music_c_2
  define :music_instrument_High do#更新高音乐器
    use_synth :chipbass
  end
  NumOfCycles = choose([3, 4, 5, 6, 7, 8, 9])#更新音一循环有几个音
  music_c_3
  musicPaYin
  sleep 0.5
  music_c_4
  music_c_1
  music_c_4
  define :music_instrument_High do#更新高音乐器
    use_synth :dsaw
  end
  NumOfCycles = choose([3, 4, 5, 6, 7, 8, 9])#更新音一循环有几个音
  music_c_4
  music_c_1
  music_c_0
  terminating
end


