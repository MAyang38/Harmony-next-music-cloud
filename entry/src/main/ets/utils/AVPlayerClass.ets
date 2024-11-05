import media from "@ohos.multimedia.media";
import { SongType } from "../model/music";
import { emitter } from "@kit.BasicServicesKit";

export class AVPlayerClass{
  static player:media.AVPlayer  = {} as media.AVPlayer
  // 2.歌曲时长
  static duration: number = 0
  // 3 时长
  static time:number = 0
  // 4. 是否播放
  static isPlay: boolean = false
  // 5. 播放模式
  static playMode:'auto'|'repeat'|'random'  = 'auto'


  // 播放列表
  static playList: SongType[] = []
  // 播放索引
  static playIndex:number = 0


  static async init(){
    AVPlayerClass.player = await media.createAVPlayer()

    AVPlayerClass.player.on('stateChange',(state)=>{
      switch (state){
        case 'initialized':
          AVPlayerClass.player?.prepare()
          break
        case 'prepared':
          AVPlayerClass.player?.play()
          break

      }
    })
    AVPlayerClass.player.on('durationUpdate',(duration)=>{
      AVPlayerClass.duration = duration
    })
    AVPlayerClass.player.on('timeUpdate',(time)=>{
      console.log(JSON.stringify(time))
      AVPlayerClass.time = time
      AVPlayerClass.updateState()
    })

  }
  // 单曲播放
  static async singlePlay(song:SongType){


    const index = AVPlayerClass.playList.findIndex(item=>{item.id === song.id})
    if(index >=0){
      if(AVPlayerClass.player.url === song.url){
          // 继续播放
      }else{
        await AVPlayerClass.player.reset()
        AVPlayerClass.playIndex = index
        AVPlayerClass.player.url = song.url
      }
    }else{
      AVPlayerClass.playList.unshift(song)
      AVPlayerClass.playIndex = 0
      AVPlayerClass.time = 0
      // AVPlayerClass.duration =
      // 设置播放源
      // 状态机进入限制状态
      AVPlayerClass.player.reset()
      AVPlayerClass.player.url = song.url
    }
    AVPlayerClass.isPlay = true
    AVPlayerClass.updateState()

  }
  static  nextPlay(){
    if(AVPlayerClass.playIndex < AVPlayerClass.playList.length - 1){
        AVPlayerClass.playIndex++
      AVPlayerClass.player.reset()
      AVPlayerClass.player.url = AVPlayerClass.playList[AVPlayerClass.playIndex].url
    }else{
      AlertDialog.show({ message: '已经是最后一首歌了' })

    }

  }
  static  prevPlay(){
    if(AVPlayerClass.playIndex > 0){
      AVPlayerClass.playIndex--
      AVPlayerClass.player.reset()
      AVPlayerClass.player.url = AVPlayerClass.playList[AVPlayerClass.playIndex].url
    }else{
      AlertDialog.show({ message: '已经是第一首歌了' })

    }

  }


    // 3. 发布信息
  static updateState(){
    emitter.emit({
      eventId:0
    },{
      data:{
        duration :AVPlayerClass.duration,
        time :AVPlayerClass.time,
        isPlay :AVPlayerClass.isPlay,
        playMode :AVPlayerClass.playMode,
        playList:AVPlayerClass.playList,
        playIndex:AVPlayerClass.playIndex,
        img:AVPlayerClass.playList[AVPlayerClass.playIndex].img,
        name:AVPlayerClass.playList[AVPlayerClass.playIndex].name,
        author:AVPlayerClass.playList[AVPlayerClass.playIndex].author,
      }
    }
    )
  }
}