# TYRecorderAnimation
shapeLayer录音器动画，能根据传入的数值实时改变动画界面

`用例`

* 创建

    ``_dynamicView = [TYRecorderAnimationView recorderWithFrameX:7 frameY:50 height:259 themeColor:[UIColor whiteColor] frequency:timeDuration];``
* 调用

    ``[_dynamicView refreshUIWithSoundVolume:soundVolume];``  
